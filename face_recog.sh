#move photo from local to S3
#aws s3 cp input1.jpg s3://rawbot-ocr/source.jpg

#execute the aws rekognition cli script and output the response in a file
#sh ./aws_compareface.sh > compareface.response

#parse the response file to check similarity
SIMILARITY=`grep "Similarity" compareface.response | awk -F'[:&]' '{print $2}' | sed -e 's/ //g'`
echo "Similarity percentage: $SIMILARITY"

#Check the plate number if valid
if [[ $SIMILARITY > 90 ]]
then
        echo "Hello Boss!"
        `./arduino-serial/arduino-serial -b 9600 -p /dev/ttyUSB0 -s 6 > arduino.txt`
else
        echo "Intruder Alert!"
fi

#move the files from S3 plate_uploads to logs DIR
#DATE=`date '+%m/%d/%y %H:%M:%S'`
#RE_DATE=`echo $DATE | sed -e 's/\//-/g' -e 's/ /_/g'`
#LOGFILE=`echo "INPUT_${RE_DATE}.jpg"`
#echo $LOGFILE
#aws s3 mv s3://qtpi-storage/plate_uploads/input1.jpg s3://qtpi-storage/logs/$LOGFILE
