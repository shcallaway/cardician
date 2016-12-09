require 'google_drive'
require 'linkedin'
require 'dotenv'

# Get the user's LinkedIn URL from args.
URL = ARGV[0]
ARGV.clear

# Load the LinkedIn API credentials.
Dotenv.load
ID = ENV['LINKEDIN_ID']
SECRET = ENV['LINKEDIN_SECRET']

# Set up the LinkedIn client.
client = LinkedIn::Client.new(ID, SECRET)

access_keys = false
# Authorize from existing access keys if possible.
if access_keys
  client.authorize_from_access(access_keys[0], access_keys[1])
# Otherwise, authenticate.
else
  # Generate a request token.
  request_token = client.request_token({}, :scope => "r_basicprofile r_emailaddress")

  # Store the token, secret and pin URL.
  rtoken = request_token.token
  rsecret = request_token.secret
  pin_url = request_token.authorize_url

  # Direct the user to authenticate manually via browser and enter the pin.
  puts "ACTION REQUIRED: You need to authenticate this app with LinkedIn. "\
       "To authorize, visit this URL:\n#{pin_url}\n"
  print "Copy the six digit code and paste it here:"

  # Get the PIN. (Strip trailing whitespace.)
  pin = gets.strip

  # Try authorizing using the provided code.
  begin 
    access_keys = client.authorize_from_request(rtoken, request_token.secret, pin) 
  rescue
    # Abort if the authorization fails. 
    abort("Invalid authorization code. Try reshuffling.")
  end 
end

user = client.profile(url: URL)
first_name = user.first_name
last_name = user.last_name

# Create a new Google session. 
# Prompts for credentials the first time.
# Saves to config.json for later.
session = GoogleDrive::Session.from_config("google.json")

# Grab the first worksheet of Google sheet: 1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0
ws = session.spreadsheet_by_key("1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0").worksheets[0]

# Find the next available row.
row = ws.num_rows + 1

# Populate cells in new row.
# Need to switch this out for command line args.
ws[row, 1] = first_name
ws[row, 2] = last_name
ws[row, 3] = URL

# Save the changes to the server.
ws.save()

# Print the new entry.
p "New Spreadsheet Entry: #{ws[row, 1]}, #{ws[row, 2]}, #{ws[row, 3]}"

# Reload the worksheet to get changes by other clients.
ws.reload