#!/usr/bin/env python3
# from https://gist.github.com/kirienko/55436c7c68088a98ffe54a68c7bd7b4c
# see https://stackoverflow.com/questions/51973437/reverse-pdf-imposition

import os
import copy
import sys
import math
import PyPDF2 as pyPdf

"""

--A3--         --A4--
[2|3]         [1]
[4|1]         [2]
[6|7]    =>   [3]
[8|5]         [4]


"""

def crop_A3page(A3page):
    global A4left
    global A4right
    A4left = copy.copy(A3page)
    A4right = copy.copy(A3page)

    x1, x2 = A3page.mediaBox.lowerLeft
    x3, x4 = A3page.mediaBox.upperRight

    x1, x2 = math.floor(x1), math.floor(x2)
    x3, x4 = math.floor(x3), math.floor(x4)
    x5, x6 = math.floor(x3/2), math.floor(x4/2)

    if x3 > x4:
        # horizontal
        A4left.mediaBox.upperRight = (x5, x4)
        A4left.mediaBox.lowerLeft = (x1, x2)

        A4right.mediaBox.upperRight = (x3, x4)
        A4right.mediaBox.lowerLeft = (x5, x2)

    else:
        # vertical
        A4left.mediaBox.upperRight = (x3, x4)
        A4left.mediaBox.lowerLeft = (x1, x6)

        A4right.mediaBox.upperRight = (x3, x6)
        A4right.mediaBox.lowerLeft = (x1, x2)


def shuffle_pages(src, dst):
    src_f = open(src, 'r+b')
    dst_f = open(dst, 'w+b')

    input_PDF = pyPdf.PdfFileReader(src_f)
    num_pages = input_PDF.getNumPages()

    output = pyPdf.PdfFileWriter()

    for i in range(0, num_pages):
        print("page A3: "+str(i))
        crop_A3page(input_PDF.getPage(i))
        if (i % 2 == 0):
            output.insertPage(A4left, 2*i+1)
            print("page A3 gauche->page A4: "+str(2*i+1))
            output.insertPage(A4right, 2*i+2)
            print("page A3 droite->page A4: "+str(2*i+2))
        else:
            output.insertPage(A4left, 2*i+1)
            print("page A3 gauche->page A4: "+str(2*i+1))
            output.insertPage(A4right, 2*i-2)
            print("page A3 droite->page A4: "+str(2*i-2))

    output.write(dst_f)
    src_f.close()
    dst_f.close()


if len(sys.argv) < 3:
    print("\nusage:\n$ python reverse_impose.py input.pdf output.pdf")
    sys.exit()

input_file = sys.argv[1]
output_file = sys.argv[2]


shuffle_pages(input_file, output_file)
small_output_file = str.replace(output_file, '.pdf', '-small.pdf')

os.system("gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -sOutputFile="+small_output_file+" "+output_file)
