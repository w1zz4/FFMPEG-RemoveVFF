#!/bin/bash

#Usage /mnt/Share/Medias/ListeMedias/Remove_VFF.sh "Full movie Path"

dirpath="$(dirname "$1")";
filename="$(basename  "$1")";
stream=$(ffmpeg -i "$dirpath/$filename" 2>&1 | grep -B2 -i VFF | head -n 1 | awk -F ' ' '{print $2}' | cut -c 2-4);
echo $stream
if [ -z "$stream" ]; then
  echo "Stream variable is empty, nothing to do!";
else
  ffmpeg -i "$dirpath/$filename" -map 0 -map -"$stream" -y -c copy "$dirpath/TMP_${filename}";
  rm -f "$1";
  mv "$dirpath/TMP_${filename}" "$1";
  chown -R w1zz4:w1zz4 "$dirpath";
  ffmpeg -i "$dirpath/$filename" 2>&1 | grep -A2 Audio;
