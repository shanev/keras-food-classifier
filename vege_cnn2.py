# Based on https://keras.io/applications/
# Fine-tune InceptionV3 on a new set of classes

# Issues
# 
# Error when converting:
# ValueError: need more than 1 value to unpack

from keras.applications.inception_v3 import InceptionV3
from keras.preprocessing import image
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Model
from keras.layers import Dense, GlobalAveragePooling2D
from keras import backend as K
from pprint import pprint

# dimensions of our images.
img_width, img_height = 150, 150

train_data_dir = 'data/train'
validation_data_dir = 'data/validation'
num_train_samples = 1760
num_validation_samples = 240
num_classes = 3
epochs = 10
batch_size = 16

# create the base pre-trained model
base_model = InceptionV3(weights='imagenet', include_top=False)

# add a global spatial average pooling layer
x = base_model.output
x = GlobalAveragePooling2D()(x)
# let's add a fully-connected layer
x = Dense(1024, activation='relu')(x)
# and a logistic layer -- let's say we have 200 classes
predictions = Dense(num_classes, activation='softmax')(x)

# this is the model we will train
model = Model(inputs=base_model.input, outputs=predictions)

# first: train only the top layers (which were randomly initialized)
# i.e. freeze all convolutional InceptionV3 layers
for layer in base_model.layers:
    layer.trainable = False

# compile the model (should be done *after* setting layers to non-trainable)
model.compile(optimizer='rmsprop', loss='categorical_crossentropy')

# this is the augmentation configuration we will use for training
train_datagen = ImageDataGenerator(
  rescale=1. / 255,
  shear_range=0.2,
  zoom_range=0.2,
  horizontal_flip=True)

# this is the augmentation configuration we will use for testing:
# only rescaling
test_datagen = ImageDataGenerator(rescale=1. / 255)

train_generator = train_datagen.flow_from_directory(
  train_data_dir,
  target_size=(img_width, img_height),
  batch_size=batch_size)

validation_generator = test_datagen.flow_from_directory(
  validation_data_dir,
  target_size=(img_width, img_height),
  batch_size=batch_size)

# print order of class indices needed for conversion to CoreML
pprint(validation_generator.class_indices)

# train the model on the new data for a few epochs
model.fit_generator(
  train_generator,
  steps_per_epoch=num_train_samples // batch_size,
  epochs=epochs,
  validation_data=validation_generator,
  validation_steps=num_validation_samples // batch_size)

# at this point, the top layers are well trained and we can start fine-tuning
# convolutional layers from inception V3. We will freeze the bottom N layers
# and train the remaining top layers.

# let's visualize layer names and layer indices to see how many layers
# we should freeze:
for i, layer in enumerate(base_model.layers):
   print(i, layer.name)

# we chose to train the top 2 inception blocks, i.e. we will freeze
# the first 249 layers and unfreeze the rest:
for layer in model.layers[:249]:
   layer.trainable = False
for layer in model.layers[249:]:
   layer.trainable = True

# we need to recompile the model for these modifications to take effect
# we use SGD with a low learning rate
from keras.optimizers import SGD
model.compile(optimizer=SGD(lr=0.0001, momentum=0.9), loss='categorical_crossentropy')

# we train our model again (this time fine-tuning the top 2 inception blocks
# alongside the top Dense layers
model.fit_generator(
  train_generator,
  steps_per_epoch=num_train_samples // batch_size,
  epochs=epochs,
  validation_data=validation_generator,
  validation_steps=num_validation_samples // batch_size)

model.save('VegeModel5.h5')
