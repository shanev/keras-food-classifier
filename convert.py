# import argparse
# import os
# import sys

import coremltools
from keras.models import load_model

# def testLoadModel(filename):
#     model = load_model(filename)

# def convert(inFilename, outFileName, labels, author = '', license = '', short_description = ''):
#     coreml_model = coremltools.converters.keras.convert(inFilename,class_labels = labels, input_names = 'image', image_input_names = 'image')
#     coreml_model.author = author
#     coreml_model.license = license
#     coreml_model.short_description = short_description
#     coreml_model.save(outFilename)

# if __name__=="__main__":
#     a = argparse.ArgumentParser()
#     a.add_argument('--infile','-i', metavar="H5", default="model.h5")
#     a.add_argument('--outfile','-o', metavar="MLMODEL", default="model.mlmodel")
#     a.add_argument('--label','-l', metavar="LABEL", action='append')
#     a.add_argument('--labelfile','-f', metavar="FILENAME")
#     a.add_argument('--author','-a', metavar="NAME", default='')
#     a.add_argument('--license', metavar="LICENSE", default='Apache-2.0')
#     a.add_argument('--description','-d', metavar="SHORT DESCRIPTION", default='Model for image recognition')

#     args = a.parse_args()
#     if args.infile is None or args.outfile is None:
#         a.print_help()
#         sys.exit(1)
#     elif (not os.path.exists(args.infile)):
#         print("Filename " + args.infile + " does not exist")
#         sys.exit(1)
#     elif args.label is None and args.labelfile is None:
#         print("You need either --label OR --labelfile with a list of files")
#         sys.exit(1)

#     if (not args.label is None):
#         labels = args.label

#     convert(args.infile, args.outfile, labels, args.author, args.license, args.description)

model = load_model('VegeModel5.h5')
model.summary()

coreml_model = coremltools.converters.keras.convert(
  'VegeModel5.h5',
  image_scale=1./255,
  input_names = 'image',
  image_input_names = 'image',
  class_labels = ['avocado','carrots','kale'])

coreml_model.save('VegeModel5.mlmodel')
