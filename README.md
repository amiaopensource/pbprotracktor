# What is this?

`pbprotrackor` is a bash script which queries the postgres database of ProTrack to output PBCore. Use at your own risk. Some other scripts may be added here to facilitate finagling that PBCore or sending it to other systems. 

## How valid is the PBCore?

Mostly valid.

/# todo: add validity checks.

## How to install?

### Via Homebrew

```
brew tap amiaopensource/amiaos
brew install pbprotrackor
```

Alternatively, you can run the following command:
```
brew install amiaopensource/amiaos/pbprotrackor
```

## How to use?

To pull a PBCore XML from the database where the media attachment's ID is `SHOW1234`, try:

```
pbprotrackor SHOW1324
```

or gather many PBCore records at once via:

```
pbprotrackor SHOW1324 SHOW1325 SOMEOTHERSHOW123 U812
```

During the first run, `pbprotrackor` will prompt for a configuration file to be written which requires the IP address and a user name for the server which hosts ProTrack.

The output will either XML (no option) or CVS (option `-c`). The option `-a` returns all instantiations per asset, rather than only the called one.

There are no error codes yet. Also presently the query is only started via the media attachment ID.

# License

`pbprotrackor` is licensed under a [MIT](License.txt) License.
