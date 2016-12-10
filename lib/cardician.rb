require 'google_drive'
require 'linkedin'
require 'dotenv'

# Abort if no args supplied.
if ARGV.empty?
  abort("ERROR: LinkedIn URL missing.")
end

# Get the user's LinkedIn URL from args.
URL = ARGV[0]
ARGV.clear

# Load the LinkedIn API credentials.
if File.exists?(".env")
  Dotenv.load
  ID = ENV['LINKEDIN_ID']
  SECRET = ENV['LINKEDIN_SECRET']
else 
    abort("ERROR: LinkedIn API credentials missing.")
end

# Set up the LinkedIn client.
client = LinkedIn::Client.new(ID, SECRET)

# Look for some existing access keys.
if File.exists?("linkedin.txt")
  # Read the string from file and convert to array.
  access_keys = File.open("linkedin.txt", &:gets).gsub(/[\[\]"]/, "").split(", ")
else
  access_keys = false
end 

# Authorize from existing access keys if possible.
if access_keys
  client.authorize_from_access(access_keys[0], access_keys[1])
# Otherwise, authenticate.
else
  # Generate a request token.
  request_token = client.request_token({}, scope: "r_basicprofile r_emailaddress")

  # Store the token, secret and pin URL.
  rtoken = request_token.token
  rsecret = request_token.secret
  pin_url = request_token.authorize_url

  # Direct the user to authenticate manually via browser and enter the pin.
  puts "You need to authenticate this app with LinkedIn. "\
       "To authorize, visit this URL:\n#{pin_url}\n"
  print "Copy the five digit code and paste it here:"

  # Get the PIN. (Strip trailing whitespace.)
  pin = gets.strip

  # Try authorizing using the provided code.
  begin 
    access_keys = client.authorize_from_request(rtoken, request_token.secret, pin) 

    # Write the new access keys to a local file.
    File.open("linkedin.txt", "w") do |f|
      f.write("#{access_keys}")
    end
  rescue
    # Abort if the authorization fails. 
    abort("ERROR: Invalid authorization code.")
  end 
end

# Try to find the LinkedIn user.
begin
  user = client.profile(url: URL)
rescue
  abort("ERROR: Can't find a profile with that URL.")
end

# Get relevant info from the LinkedIn user.
first_name = user.first_name
last_name = user.last_name

# Create a new Google session. 
# (Prompts for credentials the first time. Saves to config.json after.)
begin
  session = GoogleDrive::Session.from_config("google.json")
rescue
  abort("ERROR: Google authorizaiton failed.")
end

# Grab the first worksheet of Google sheet: 1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0
begin
  ws = session.spreadsheet_by_key("1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0").worksheets[0]
rescue
  abort("ERROR: Invalid spreadsheet ID.")
end

# Find the next available row.
row = ws.num_rows + 1

# Populate cells in new row.
ws[row, 1] = first_name
ws[row, 2] = last_name
ws[row, 3] = URL

# Save the changes to the server.
begin
  ws.save()
rescue
  abort("ERROR: Failed to save.")
end

# Print the success statement.
puts "Success! A new card has been added to your deck."