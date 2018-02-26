#! /usr/bin/env python
# -*- coding: UTF-8 -*-
import sys
import getopt
import toml
import json
def main(argv):
    inputfile = ''
    outputfile = ''
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
        print('json2toml.py -i <inputfile> -o <outputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('json2toml.py -i <inputfile> -o <outputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg
    print(inputfile)
    print(outputfile)
    obj = json.load(open(inputfile, "r"))
    toml.dump(obj, open(outputfile, "w"))
   
if __name__ == "__main__":
    main(sys.argv[1:])
