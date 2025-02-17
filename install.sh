#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

APPNAME="pensebete"
APPENTRY=pensebete.sh
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

read -r -p "Proceed with the installation? [y/N]" -n 1

echo

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    mkdir -p /opt/$APPNAME/main
    echo "Created /opt/"$APPNAME"/main"

    cp -rf * /opt/$APPNAME/main/
    rm -f /opt/$APPNAME/main/install.sh
    echo "Copied files to /opt/"$APPNAME"/main"

    ln -sf /opt/$APPNAME/main/$APPENTRY /usr/bin/$APPNAME
    echo "Created an extension-less symlink to "$APPNAME" in /usr/bin"

    echo "Installation successful !"
    echo "Call '"$APPNAME"' whenever you want..."
fi
