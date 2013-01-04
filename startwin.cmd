@echo off

:: Set JAVA_HOME
for /d %%i in ("\Program Files\Java\jre*") do set JAVA_HOME=%%i

::add jruby bins to path
set PATH=%PATH%;%cd%\jruby\bin

::switch to actuall app root
cd /d pdfwebapp

::start it
jruby -rubygems app.rb