[![Build Status](https://travis-ci.org/tonghuix/getstart-zh.svg?branch=master)](https://travis-ci.org/tonghuix/getstart-zh)
[![Build Status](https://drone.io/github.com/tonghuix/getstart-zh/status.png)](https://drone.io/github.com/tonghuix/getstart-zh/latest)

# FlightGear Getstart Manual Chinese Translation

Here is Chinese translation for the [Getstart Manual](https://sourceforge.net/p/flightgear/getstart/ci/master/tree/) of [FlightGear](http://www.flightgear.org/), which is a awesome free and open source flight simulator I never met. 

## Downloads

**PDF Version:** [Download](https://tonghuix.fedorapeople.org/getstart-zh.pdf)

## How to build

To build the PDF Manual on an Debian 8/9/Sid or Ubuntu 14.04 system, you will need the following packages:

````
sudo apt-get install texlive-latex-base texlive-xetex xutils-dev \
     texlive-latex-extra texlive-fonts-recommended tex4ht
````

For Chinese

````
sudo apt-get install cjk-latex latex-cjk-chinese latex-cjk-chinese-arphic-gbsn00lp \
    latex-cjk-chinese-arphic-gkai00mp fonts-arphic-gkai00mp fonts-arphic-gbsn00lp\
    texlive-lang-cjk fonts-wqy-microhei fonts-wqy-zenhei

````

When all installed, just excute

````
$ bin/makegetstart.sh zh pdf
````

It will generate Chinese version Getstart pdf file into `getstart` directory of the source coude.

## Licence

Same as the [FlightGear source code](https://sourceforge.net/p/flightgear/), licenced by GPLv2.

