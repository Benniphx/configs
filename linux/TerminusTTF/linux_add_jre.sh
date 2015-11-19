#!/bin/bash

fonts_path=/usr/lib/jvm/java-7-oracle/jre/lib/fonts
sudo cp Terminus*.ttf "$fonts_path/"
sudo chmod a+r "$fonts_path/*"
