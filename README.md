## NVIDIA DIGITS CNN training

Based on http://reza.codes/2017-07-29/how-to-train-your-own-dataset-for-coreml/.

1. Compress image data

```
cd ~/Dropbox/SousChef/data
tar -zcvf food.tar.gz food
```

2. Upload to AWS

`aws s3 cp food.tar.gz s3://souschef.ai/data/food.tar.gz --acl public-read`

3. Start instance

`aws ec2 start-instances --instance-ids i-0ade0ef688dee181e`

4. Get instance public IP

```
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].PublicIpAddress" \
  --output=text | pbcopy
```

5. Login to DIGITS and upload data
```
cd ~/Projects/MachineLearning/keras/food
ssh -i DIGITS/digits.pem ubuntu@[PUBLIC IP ADDRESS]
cd data
wget -O food.tar.gz "https://s3.amazonaws.com/souschef.ai/data/food.tar.gz"
tar xvzf food.tar.gz
chmod -R 0755 food
```

Note: May need to add SSH inbound rule for MyIP in security policy.

6. Train model

Folder: `/home/ubuntu/data/food/images`

Pretrained model: `/home/ubuntu/models/bvlc_alexnet.caffemodel`

Use [caffe.json](https://raw.githubusercontent.com/shanev/keras-food-classifier/master/DIGITS/caffe.json?token=AABD0T-_kffeCCeVk2-dfYDDsfZZaHBAks5aNDvpwA%3D%3D)

7. Stop instance

`aws ec2 stop-instances --instance-ids i-0ade0ef688dee181e`

8. Download model and convert to CoreML using `DIGITS/run.py`

9. Upload CoreML model to S3:

```
aws s3 cp models/Foods40.mlmodel s3://souschef.ai/coreml/Foods.mlmodel --acl public-read
```
