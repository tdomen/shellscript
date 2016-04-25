#!/bin/sh

mkdir ~/.config/nautilus/connection_history
DATE=`date +%Y%m%d`
cp ~/.config/nautilus/servers ~/.config/nautilus/connection_history/"servers_backup_$DATE"

cat << EOF > ~/.config/nautilus/servers
<?xml version="1.0" encoding="UTF-8"?>
<xbel version="1.0"
      xmlns:bookmark="http://www.freedesktop.org/standards/desktop-bookmarks"
      xmlns:mime="http://www.freedesktop.org/standards/shared-mime-info"
>
  <bookmark href="smb://172.20.11.17/amour/chizai/2016/M1/tdomen" added="2016-04-18T11:15:41Z" modified="2016-04-18T18:24:30Z" visited="2016-04-18T18:24:30Z">
    <title>tdomen</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-04-18T18:24:30Z" count="4"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
  <bookmark href="smb://172.20.11.17/" added="2015-06-29T03:12:04Z" modified="2016-04-18T11:01:31Z" visited="2016-04-18T11:01:31Z">
    <title>172.20.11.17 上のWindows 共有</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-04-18T11:01:31Z" count="80"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
  <bookmark href="smb://172.20.11.103/" added="2015-08-21T07:11:41Z" modified="2016-04-15T08:00:47Z" visited="2016-04-15T08:00:47Z">
    <title>172.20.11.103 上のWindows 共有</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-04-15T08:00:47Z" count="40"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
  <bookmark href="smb://172.20.11.103/anime/" added="2015-12-05T08:28:52Z" modified="2016-04-12T07:52:30Z" visited="2016-04-12T07:52:30Z">
    <title>172.20.11.103 上の anime</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-04-12T07:52:30Z" count="14"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
  <bookmark href="smb://172.20.11.103/unfiled/" added="2015-12-05T08:32:24Z" modified="2016-04-18T18:27:03Z" visited="2016-04-18T18:27:03Z">
    <title>172.20.11.103 上の unfiled</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-04-18T18:27:03Z" count="14"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
  <bookmark href="smb://172.20.11.103/av/" added="2015-08-23T21:28:02Z" modified="2016-03-21T13:26:27Z" visited="2016-03-21T13:26:27Z">
    <title>172.20.11.103 上の av</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-03-21T13:26:27Z" count="24"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
  <bookmark href="smb://172.20.11.103/request/" added="2015-09-12T17:42:44Z" modified="2016-04-16T07:41:58Z" visited="2016-04-16T07:41:58Z">
    <title>172.20.11.103 上の request</title>
    <info>
      <metadata owner="http://freedesktop.org">
        <bookmark:applications>
          <bookmark:application name="nautilus" exec="&apos;nautilus %u&apos;" modified="2016-04-16T07:41:58Z" count="11"/>
        </bookmark:applications>
      </metadata>
    </info>
  </bookmark>
</xbel>
EOF
