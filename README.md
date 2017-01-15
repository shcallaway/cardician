# Cardician

![alt text](https://github.com/shcallaway/cardician/blob/master/assets/gambit.jpg)

> Become a card-wielding magician.

Cardician makes it quick and easy to keep track of professional connections. Add names and profile links to a Google sheet from the comfort of your command line. Just provide a LinkedIn URL and let Cardician do the rest. 

Cardician was born out of laziness; Specifically, I got tired of copy-pasting information about connections into my spreadsheet while searching for a new job. It's a simple Ruby applicaton. 

## Table of Contents

- [Cardician](#)
    - [Table of Contents](#)
    - [Dependencies](#)
    - [Installation](#)
    - [To Use](#)
    - [Resources](#)

## Dependencies

1. Ruby (w/ Google Drive, LinkedIn, Dotenv, & Colorize Gems)

## Installation

1. Clone the repository.
2. Run `bundle install` in the root directory to install the necessary gems.
3. Create a .env file with the following API keys:

* LINKEDIN_ID - Provided upon registering a Linkedin app
* LINKEDIN_SECRET - Same as above
* GSHEET_ID - Visible in the Google sheet URL

4. Optional: Set up a bash alias to invoke Cardian from any directory:

```
alias cardician=ruby\ /Users/scallaway/Desktop/Cardician/cardician.rb
```

## To Use

To add a connection, pass their Linkedin URL as a command line argument to the main Ruby file. Like so:

```
$ruby /Cardician/lib/cardician.rb https://www.linkedin.com/in/sherwoodcallaway
```

On first use, Cardician prompts the user to authenticate with Linkedin and Google. It conveniently saves these credentials for later.

## Resources

* [Google Sheets API Ruby Quickstart](https://developers.google.com/sheets/quickstart/ruby)
* [Google Drive Gem](https://github.com/gimite/google-drive-ruby)
* [LinkedIn Gem](https://github.com/hexgnu/linkedin)
* [LinkedIn API](https://developer.linkedin.com/docs/oauth2)
