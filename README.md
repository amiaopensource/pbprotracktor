# What is this?

`pbprotrackor` is a bash script which queries the postgres database of Protrack to output PBCore. Use at your own risk. Some other scripts may be added here to facilitate finangling that PBCore or sending it to other systems. 

# How valid is the PBCore?

Mostly valid.

/# todo: add validity checks.

# How to install?

## Via Homebrew

```
brew tap amiaopensource/amiaos
brew install pbprotrackor
```

# How to use?

To pull a PBCore XML from the database where the media attachment's id is `SHOW1234`, try:

```
pbprotrackor SHOW1324
```

or gather many PBCore records at once via:

```
pbprotrackor SHOW1324 SHOW1325 SOMEOTHERSHOW123 U812
```

During the first run, `pbprotrackor` will prompt for a configuration file to be written which requires the ip address and a user name for the server which hosts ProTrack.

The output will only be XML. There are no error codes (yet) or options. Also presently the query is only started via the media attachment id.

Also note that postgres outputs the XML with no line breaks. If you require pretty XML try piping the output through xmlstarlet, such as:

```
pbprotrackor SHOW1324 SHOW1325 SOMEOTHERSHOW123 U812 | xml fo
```

# License

See [License](#license).
