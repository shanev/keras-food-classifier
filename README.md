# Vegetable Classifier CNN in Keras

Currently only works for carrots and kale.

## Training Data

### ImageNet

Currently used for training data at `data/train`.

wget -O list_of_images.txt "http://www.image-net.org/api/text/imagenet.synset.geturls?wnid=n02139199"

wget -i list_of_images.txt

### Google Images

Currently used for validation data at `data/validation`

Use downloader in `downloader/google.py`.

## Links

https://github.com/fchollet/keras/issues/4465

http://www.codesofinterest.com/2017/08/bottleneck-features-multi-class-classification-keras.html

https://sriraghu.com/2017/07/12/computer-vision-in-ios-object-detection/

https://sriraghu.com/2017/07/06/computer-vision-in-ios-coremlkerasmnist/

https://willowtreeapps.com/ideas/integrating-trained-models-into-your-ios-app-using-core-ml

https://www.tooploox.com/blog/custom-classifiers-in-ios11-using-coreml-and-vision

https://hackernoon.com/keras-with-gpu-on-amazon-ec2-a-step-by-step-instruction-4f90364e49ac
