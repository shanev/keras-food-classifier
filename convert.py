# coreml_model = coremltools.converters.keras.convert(model, input_names = 'image',
# ... image_input_names = 'image', class_labels = ['cat', 'dog', 'rat'])

import coremltools
from keras.models import load_model

model = load_model('vege_model_1.h5')
model.summary()

coreml_model = coremltools.converters.keras.convert(
  model,
  input_names = 'image',
  image_input_names = 'image',
  class_labels = ['carrots', 'kale'])

coreml_model.save("vege_model_1.mlmodel")
