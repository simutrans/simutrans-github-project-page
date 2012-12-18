#!/bin/bash

# script builds pak128 and proivdes download of it
# it is specifically written for one machine and 
# the file structure there

gitdir=~/simutrans.dev/pak128/
buildir=simutrans/
build=pak128
pakz=$build.r$rev.7z

pagedir=~/simutrans.dev/page/pak128builds/


cd $gitdir

git svn rebase

rev=`git svn info |grep Revision|cut -b 11-`
now=`date --rfc-3339=seconds -u`
gitmsg="ads pak128 developmetn snapshot r$rev"


./pakmak.py

cd $buildir
cp -r $build  $build.r$rev
7zr a  $pakz  $build.r$rev
mv $pakz $pagedir

cd $pagedir
git pull

sed '$d' index.html > temp
echo "$now <a href=$pakz>$pakz</a></br>" >> temp
tail -1 index.html >> temp
mv temp index.html


git add index.html $pakz
git commit -m $gitmsg
git push
