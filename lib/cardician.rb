require 'google_drive'
require 'linkedin'

# Get the user's LinkedIn URL from args.
URL = ARGV[0]
ARGV.clear

# LinkedIn API ID and secret. Need to move these to .env.
ID = '78ql1v36h0gkrg'
SECRET = 'FmkJQH0KETRMSTKJ'

# Set up the LinkedIn client and build the authorization request.
client = LinkedIn::Client.new(ID, SECRET)
request_token = client.request_token({}, :scope => "r_basicprofile r_emailaddress")

# Store the token, secret and pin URL.
rtoken = request_token.token
rsecret = request_token.secret
pin_url = request_token.authorize_url

# Direct the user to authenticate manually and enter the pin.
puts "Access this URL: #{pin_url}"
puts "Get the PIN and paste it here:"
pin = gets.strip

# Authorize! Store the access keys. (Maybe should write them to .env?)
access_keys = client.authorize_from_request(rtoken, request_token.secret, pin)

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