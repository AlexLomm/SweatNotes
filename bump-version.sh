#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {major|minor|patch|build}"
  exit 1
fi

case $1 in
  major)
    perl -i -pe 's/^(version:\s+)(\d+)\.(\d+)\.(\d+)\+(\d+)$/"${1}".($2+1).".0.0+0"/e' ./pubspec.yaml
    ;;
  minor)
    perl -i -pe 's/^(version:\s+)(\d+)\.(\d+)\.(\d+)\+(\d+)$/"${1}".$2.".".($3+1).".0+0"/e' ./pubspec.yaml
    ;;
  patch)
    perl -i -pe 's/^(version:\s+)(\d+)\.(\d+)\.(\d+)\+(\d+)$/"${1}".$2.".".$3.".".($4+1)."+0"/e' ./pubspec.yaml
    ;;
  build)
    perl -i -pe 's/^(version:\s+)(\d+)\.(\d+)\.(\d+)\+(\d+)$/"${1}".$2.".".$3.".".$4."+".($5+1)/e' ./pubspec.yaml
    ;;
  *)
    echo "Invalid argument. Use one of the following: major, minor, patch, build"
    exit 1
    ;;
esac

# Commit and tag this change.
version=`grep 'version: ' ./pubspec.yaml | sed 's/version: //'`
git commit -m "Bump version to $version" ./pubspec.yaml
git tag $version
