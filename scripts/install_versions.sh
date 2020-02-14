#!/bin/sh

while read in; do asdf install $in; done < /build/versions/$1 