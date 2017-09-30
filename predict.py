# test_model = load_model('first_model.h5')
# def predict(basedir, model):
#     for i in range(1401,1411):
#         path = basedir + str(i) + '.jpg'
    
#         img = load_img(path,False,target_size=(img_width,img_height))
#         x = img_to_array(img)
#         x = np.expand_dims(x, axis=0)
#         preds = model.predict_classes(x)
#         probs = model.predict_proba(x)
#         print(probs)

from keras.models import load_model
from keras.preprocessing.image import img_to_array, load_img
import numpy as np

# dimensions of our images.
img_width, img_height = 150, 150

model = load_model('./models/VegeModel5.h5')

img = load_img('./data/train/avocado/avocado10.jpg', False, target_size=(img_width, img_height))
x = img_to_array(img, data_format='channels_last')
x = x / 255
x = x.reshape((1,) + x.shape) # (1, 150, 150, 3)
# print(x.shape)
pred = model.predict(x)
print(pred)

img = load_img('./data/train/avocado/avocado6.jpg', False, target_size=(img_width, img_height))
x = img_to_array(img, data_format='channels_last')
x = x / 255
x = x.reshape((1,) + x.shape) # (1, 150, 150, 3)
pred = model.predict(x)
print(pred)

img = load_img('./data/train/carrots/Carrot6.jpg', False, target_size=(img_width, img_height))
x = img_to_array(img)
x = x / 255
x = x.reshape((1,) + x.shape)
pred = model.predict(x)
print(pred)

img = load_img('./data/train/kale/Kale.jpg', False, target_size=(img_width, img_height))
x = img_to_array(img)
x = x / 255
x = x.reshape((1,) + x.shape)
pred = model.predict(x)
print(pred)

img = load_img('./data/fake/fake1.jpg', False, target_size=(img_width, img_height))
x = img_to_array(img)
x = x / 255
x = x.reshape((1,) + x.shape)
pred = model.predict(x)
print(pred)

img = load_img('./data/fake/fake2.jpg', False, target_size=(img_width, img_height))
x = img_to_array(img)
x = x / 255
x = x.reshape((1,) + x.shape)
pred = model.predict(x)
print(pred)

img = load_img('./data/fake/fake3.png', False, target_size=(img_width, img_height))
x = img_to_array(img)
x = x / 255
x = x.reshape((1,) + x.shape)
pred = model.predict(x)
print(pred)
