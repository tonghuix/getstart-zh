[![Build Status](https://travis-ci.org/tonghuix/getstart-zh.svg?branch=master)](https://travis-ci.org/tonghuix/getstart-zh)

# FlightGear Getstart Manual Chinese Translation

Here is Chinese translation for the [Getstart Manual](https://sourceforge.net/p/flightgear/getstart/ci/master/tree/) of [FlightGear](http://www.flightgear.org/), which is a awesome free and open source flight simulator I never met. 

## Downloads

**PDF Version:** [Download](https://github.com/tonghuix/getstart-zh/releases)

## How to build

To build the PDF Manual on an Debian 9/10/Sid or Ubuntu 18.04 system, you will need the following packages:

````
sudo apt-get -y --no-install-recommends install texlive-latex-base          \ 
     texlive-xetex xutils-dev texlive-latex-extra texlive-fonts-recommended \
	 tex4ht texlive-fonts-extra lmodern imagemagick
````

For Chinese

````
sudo apt-get -y --no-install-recommends install texlive-lang-chinese \
     texlive-generic-recommended cjk-latex latex-cjk-chinese fonts-noto \
	 fonts-noto-cjk

````

Install Fandol fonts, which used in this Chinese translation:

````
$ ./install.fandolsong.sh
````

When all installed, just excute

````
$ bin/makegetstart.sh zh pdf
````

It will generate Chinese version Getstart pdf file into `getstart-zh` directory of the source coude.

## Licence

Same as the [FlightGear source code](https://sourceforge.net/p/flightgear/), licenced by GPLv2.

