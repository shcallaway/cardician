require "google_drive"
require "httparty"
require "nokogiri"
require "pry"

# Store the LinkedIn URL form command line.
linkedin_url = "https://www.linkedin.com/in/sherwoodcallaway"

# Get the contents of the LinkedIn page.
page = HTTParty.get(linkedin_url, follow_redirects: true)

# Page is actually just an HTML header with a JS redirect -- need to get to the final page somehow?
p page.parsed_response

# Once I get to the final page, I can do all this:

# # Parse the page with Nokogiri.
# parse_page = Nokogiri::HTML(page)

# full_name = parse_page.css("span.full-name").text

# Parse the full_name into first_name and last_name.

# # Create a session. Prompts for credentials the first time.
# # Saves to config.json for later.
# session = GoogleDrive::Session.from_config("config.json")

# # Grab the first worksheet of Google sheet: 1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0
# ws = session.spreadsheet_by_key("1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0").worksheets[0]

# # Find the next available row.
# row = ws.num_rows + 1

# # Populate cells in new row.
# # Need to switch this out for command line args.
# ws[row, 1] = first_name
# ws[row, 2] = last_name
# ws[row, 3] = linkedin_url

# # Save the changes to the server.
# ws.save()

# # Print the new entry.
# p "New Spreadsheet Entry: #{ws[row, 1]} #{ws[row, 2]}"

# # Reload the worksheet to get changes by other clients.
# ws.reload