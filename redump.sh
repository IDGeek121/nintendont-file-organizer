#!/bin/bash
for f in ./games/*/*.iso
do
  echo "Calculating MD5 for $f"
  MD5=$(/usr/bin/md5sum "$f" | awk '{print $1;}')

  echo "Searching for $MD5 from datfile"
  RESULT=$(grep "$MD5" "redump.dat")
  if [ "$RESULT" != "" ]
  then
    RE="name=\"([^\"]*)"
    if [[ $RESULT =~ $RE ]]
    then
      echo "Found game ${BASH_REMATCH[1]}"
      mv "$f" "${BASH_REMATCH[1]}"
      RE2="^(.*\/).*\.iso"
      if [[ $f =~ $RE2 ]]
      then
        echo "Removing old directory"
        rmdir "${BASH_REMATCH[1]}"
      fi
    fi
  fi
done
