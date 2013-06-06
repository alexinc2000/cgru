#!/bin/bash

cd `dirname $0`
cd ..

dest=$1
[ -z "$dest" ] && dest=cgru.info
cgru=$PWD

credentials=rules/export_credentials.sh
if [ ! -f $credentials ]; then
	echo $credentials file not founded
	exit 1
fi
source $credentials

echo USER=$FTP_USER
echo DEST=$dest

ftp -in $dest <<END_SCRIPT
quote USER $FTP_USER
quote PASS $FTP_PASS

mkdir rules
cd rules
mput *.html *.php *.txt
ls

mkdir lib
mput lib/*.css lib/*.js
ls lib

mkdir rules
mput rules/*.css rules/*.js
mput rules/rules.00_general.json
ls rules

mkdir rules/bin
mput rules/bin/*.py
ls rules/bin

mkdir rules/assets
mput rules/assets/*.js rules/assets/*.html
ls rules/assets



mkdir rules_root
cd rules_root
lcd rules_root

mkdir .rules
mput .rules/*.html .rules/*.json
ls .rules

mkdir Ask_Questions_Here
mkdir Ask_Questions_Here/.rules
mput Ask_Questions_Here/.rules/body.html Ask_Questions_Here/.rules/*.json
ls Ask_Questions_Here/.rules

mkdir CG_PROJECT
cd CG_PROJECT
lcd CG_PROJECT
mkdir .rules
mput .rules/body.html
ls .rules

mkdir SCENES
cd SCENES
lcd SCENES
mkdir .rules
mput .rules/body.html
ls .rules

mkdir A_SCENE
cd A_SCENE
lcd A_SCENE
mkdir .rules
mput .rules/body.html
ls .rules

mkdir A_SHOT
cd A_SHOT
lcd A_SHOT
mkdir .rules
mput .rules/body.html
ls .rules

END_SCRIPT
