aws rekognition compare-faces \
--source-image '{"S3Object":{"Bucket":"rawbot-ocr","Name":"source.jpg"}}' \
--target-image '{"S3Object":{"Bucket":"rawbot-ocr","Name":"target.jpg"}}' \
--region us-east-1
