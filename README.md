Atom::Electron
================
[![Build Status](https://travis-ci.org/azawawi/perl6-atom-electron.svg?branch=master)](https://travis-ci.org/azawawi/perl6-atom-electron)

The goal is to write cross-platform Perl 6 desktop applications using JavaScript, HTML and CSS on top of the Electron platform. The Electron framework is based on io.js and Chromium and is used in the Atom editor.

## Assumptions

Please make sure the correct electron platform is found in https://github.com/atom/electron/releases. and ```electron``` can be called from the command line.

## Installation

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
