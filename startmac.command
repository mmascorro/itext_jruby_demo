#!/bin/bash

#ensures this starts from this folder instead of user home
cd "`dirname "$0"`"

#add jruby bins to path
PATH=$(pwd)/jruby/bin:$PATH

#switch to actuall app root
cd pdfwebapp

#start it
jruby -rubygems app.rb