require "google_drive"

# Create a session. Prompts for credentials the first time.
# Saves to config.json for later.
session = GoogleDrive::Session.from_config("config.json")

# Grab the first worksheet of Google sheet: 1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0
ws = session.spreadsheet_by_key("1tii5sC0lGTPOUteb7p9JxVqxK45RcCbOCCeEbgD5rv0").worksheets[0]

# Find the next available row.
row = ws.num_rows + 1

# Populate cells in new row.
# Need to switch this out for command line args.
ws[row, 1] = "Jane"
ws[row, 2] = "Doe"

# Save the changes to the server.
ws.save()

# Print the new entry.
p "New Spreadsheet Entry: #{ws[row, 1]} #{ws[row, 2]}"

# Reload the worksheet to get changes by other clients.
ws.reload