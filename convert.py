import coremltools
coreml_model = coremltools.converters.keras.convert('vege_model_1.h5')

# from keras.models import load_model

# model = load_model('first_try.h5')

# coreml_model = coremltools.converters.keras.convert(model)
coreml_model.save("vege_model_1.mlmodel")
