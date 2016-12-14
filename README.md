# Cardician

![alt text](https://github.com/shcallaway/cardician/blob/master/assets/gambit.jpg)

> Add professional connections to a Google sheet from the command line. Become a card-weilding magician.

## Background

Cardician makes it quick and easy to keep track of professional connections. Add names and URLs from Linkedin to a Google sheet from the comfort of your command line.

## Usage

To add a connection, pass their Linkedin URL as a command line argument to the main Ruby file. Like so:

`$ruby /Cardician/lib/cardician.rb https://www.linkedin.com/in/sherwoodcallaway`

On first use, Cardician prompts the user authenticate with Linkedin and Google. It saves these credentials for later.

Use a bash alias to invoke Cardician from any directory:

`alias cardician=ruby\ /Users/scallaway/Desktop/Cardician/cardician.rb`

## Install

Clone the repository. Run `bundle install` in the root directory to install the necessary gems.

You will need to provide three values in a .env file:
* LINKEDIN_ID - Provided upon [registering a Linkedin app](https://www.linkedin.com/developer/apps)
* LINKEDIN_SECRET - Same as above
* GSHEET_ID - Visible in the Google sheet URL

## Resources
* [Google Sheets API Ruby Quickstart](https://developers.google.com/sheets/quickstart/ruby)
* [Google Drive Gem](https://github.com/gimite/google-drive-ruby)
* [LinkedIn Gem](https://github.com/hexgnu/linkedin)
* [LinkedIn API](https://developer.linkedin.com/docs/oauth2)
