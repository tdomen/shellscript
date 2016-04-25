#!/bin/sh
rsync -avz --delete -e 'ssh -p 424' /home/tdomen/ipsj-unix tdomen@172.20.11.112:/home/tdomen/backup 
