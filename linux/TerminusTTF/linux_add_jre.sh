#!/bin/bash

FONTS_PATH=/usr/lib/jvm/java-7-oracle/jre/lib/fonts

sudo cp Terminus*.ttf $FONTS_PATH/
sudo chmod a+r $FONTS_PATH/*
