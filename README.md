# Atom::Electron
[![Build Status](https://travis-ci.org/azawawi/perl6-atom-electron.svg?branch=master)](https://travis-ci.org/azawawi/perl6-atom-electron)

The goal is to write cross-platform Perl 6 desktop applications using
JavaScript, HTML and CSS on top of the Electron platform. It is based on [io.js](http://iojs.org) and [Chromium](http://www.chromium.org) and is used in
 the [Atom editor](https://github.com/atom/atom).

## Electron Installation

Please follow the instructions below based on your platform:

### Linux

- Install nodejs using apt
```
    sudo apt-get install nodejs
```
- Install pre-built electron for your platform using the following command
  line:

```
    sudo npm install electron-prebuilt -g
```

After a successful installation, electron should be installed in
``/usr/local/bin/electron``.

## Windows

If that fails, please download the correct electron platform from
https://github.com/atom/electron/releases. and make sure that ```electron```
can be called from the command line.

- Install the installer from https://nodejs.org/
- Install pre-built electron for your platform using the following command
  line:

```
    npm install electron-prebuilt -g
```


After a success installation, electron should be installed in
``%USERPROFILE%\AppData\Roaming\npm\electron.cmd``

## Atom::Electron Installation

To install it using Panda (a module management tool bundled with Rakudo Star):

    panda update
    panda install Atom::Electron

## Testing

To run tests:

    prove -e perl6

## Author

Ahmad M. Zawawi, azawawi on #perl6, https://github.com/azawawi/

## License

Artistic License 2.0
