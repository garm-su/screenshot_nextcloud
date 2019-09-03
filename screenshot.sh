#!/bin/bash
SERVER=
LOGIN=
PASSWORD=
UPLOAD_PATH=Upload

URL=$SERVER/remote.php/webdav

fname=$(date  +%Y-%m-%d\_%H:%M:%S).png
path=/tmp/$fname

while [ -f $path ];
do
        fname=$(date  +%Y-%m-%d\_%H:%M:%S)\_$RANDOM.png
        path=/tmp/$fname
done

echo $path
notify-send Screenshot "Select object"
scrot -b -s $path

if [ -f $path ];
then
        cloudpath=$UPLOAD_PATH/$fname
        fullpath=$URL/$cloudpath
        echo $fullpath
        cmd="curl -u $LOGIN:$PASSWORD -k -T $path $fullpath"
        echo $cmd
        $($cmd)

        cmd="curl -u \"$LOGIN:$PASSWORD\" -H \"OCS-APIRequest: true\" -X POST $SERVER/ocs/v1.php/ap$
        echo $cmd
        url=$(eval $cmd)
        echo $url/preview | xclip -selection clipboard

        notify-send Screenshot "Uploaded"
fi
