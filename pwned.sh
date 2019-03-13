#!/bin/bash

# Check your password at haveibeenpwned.com
# KH 2019

URL="https://api.pwnedpasswords.com/range"

echo -n "Enter password (No echo): "
read -s pw
echo

SHA1=$(echo -n "$pw" | sha1sum | awk '{print toupper($1)}')
SHA5C=$(echo -n "$SHA1" | cut -c1-5);
SHAREST=$(echo -n "$SHA1" | cut -c6-);

RES=$(curl -A "My agent" -s $URL/$SHA5C | sed 's/\r//' | grep "$SHAREST")

if [ ! -z "$RES" ]; then
  TIMES=$(echo -n $RES | cut -d ':' -f 2);
  echo "Password found $TIMES times";
else
  echo "Password not found";
fi
