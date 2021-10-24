#!/bin/bash

break=${1-20m}

if [ ! -w /etc/hosts ]
then
       echo "Usage: sudo $0 $*"
       exit 1
fi       
# goal reminder:
# sudo -u dotan -i xdg-open https://linkedin.com
# unblock:
perl -ibak -pE 'if ($mod) { s/^/#/ }; if (/site blocking/) { $mod=1 };' /etc/hosts
echo "Free to browse for $break"
sudo -u dotan -i xdg-open https://www.hackerrank.com/interview/interview-preparation-kit
`perl -MFile::Spec::Functions=rel2abs -MFile::Basename=dirname -E 'print dirname rel2abs(shift)' $0`/timer.pl $break
# reblock:
perl -ibak -pE 'if ($mod) { s/^#// }; if (/site blocking/) { $mod=1 };' /etc/hosts
echo "Back to work now"
sudo -u dotan -i xdg-open 'https://jira.prod.evogene.host/issues/?filter=10507'
