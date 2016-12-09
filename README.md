# Cardician

![alt text](https://github.com/shcallaway/cardician/blob/master/assets/gambit.jpg)

Add professional connections to a Google sheet from the command line. Become a card-weilding magician.

## How It Works

This screenshot shows the entire process, which requires the user to authenticate with both LinkedIn and Google. The goal is to eventually store credentials from both APIs so that the user only has to authenticate once. In the end, a user will be able to add Google sheet entries just by calling `card` with a LinkedIn URL.

![alt text](https://github.com/shcallaway/cardician/blob/master/assets/terminal.png)

## Bash Alias

A bash alias makes it easy to invoke Cardician from any driectory. Add the following line to the `.bashrc` file:

```alias card=ruby\ /Users/scallaway/Desktop/Cardician/cardician.rb```

This line creates an alias `card` that executes the main file. If the Cardician directory is somewhere other than Desktop, modify the directory accordingly.

## Resources
* [Google Sheets API Ruby Quickstart](https://developers.google.com/sheets/quickstart/ruby)
* [Google Drive Gem](https://github.com/gimite/google-drive-ruby)
* [LinkedIn Gem](https://github.com/hexgnu/linkedin)
* [LinkedIn API](https://developer.linkedin.com/docs/oauth2)