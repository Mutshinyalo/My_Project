#!/bin/bash

#this line creates an array of all untracked files in the directory
mapfile -t lines < <(git ls-files --others --exclude-standard)

#this line gets the count of all untracked files
untracked_files=$(git ls-files --others --exclude-standard | wc -l)

#this line determines how long to sleep between pushes
sleep_seconds=3

#this line determines how many files to push per batch
stage_size=250

#initiating batch counter
commit_batch_counter=1

while [ $untracked_files -gt 0 ]
do
   echo "number of untracked files remaining...${untracked_files}"
   echo "staging ${stage_size} files"
   git add "${lines[@]:0:${stage_size}}"
   
   echo "comitting batch ${commit_batch_counter}"
   git commit -m "initial commit batch ${commit_batch_counter}"
   
   echo "pusing commit batch ${commit_batch_counter}"
   
   git push origin main
   
   
   
   commit_batch_counter=$(( $commit_batch_counter + 1 ))
   mapfile -t lines < <(git ls-files --others --exclude-standard)
   untracked_files=$(git ls-files --others --exclude-standard | wc -l)
   
   echo "Sleeping for ${sleep_seconds}"
   sleep $sleep_seconds
done
echo "$factorial"
