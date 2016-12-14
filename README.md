# Cardician

![alt text](https://github.com/shcallaway/cardician/blob/master/assets/gambit.jpg)

> Add professional connections to a Google sheet from the command line. Become a card-weilding magician.

## Background

Like most innovations, Cardician was born out of laziness; I got tired of manually pasting names and URLs into the Google spreadsheet where I track professional connections. 

## Usage

On first use, Cardician will prompt the user to authenticate with Linkedin and Google. It stores these credentials for future use. 

A bash alias makes it easy to invoke Cardician from any directory:

`alias card=bundle exec ruby\ /Users/scallaway/Desktop/Cardician/cardician.rb`

## Install

## Resources
* [Google Sheets API Ruby Quickstart](https://developers.google.com/sheets/quickstart/ruby)
* [Google Drive Gem](https://github.com/gimite/google-drive-ruby)
* [LinkedIn Gem](https://github.com/hexgnu/linkedin)
* [LinkedIn API](https://developer.linkedin.com/docs/oauth2)
