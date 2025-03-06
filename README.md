# ZXingCPP

[![Build Status](https://github.com/rakeshksr/ZXingCPP.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rakeshksr/ZXingCPP.jl/actions/workflows/CI.yml?query=branch%3Amain)


ZXingCPP.jl is a Julia wrapper for the C++ library [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp). It is an open-source, multi-format linear/matrix barcode image processing library implemented in C++.

ZXingCPP.jl provides fast and accurate barcode detection, decoding and creation within Julia.


## Usage
```julia
using ZXingCPP
using OpenCV
```
### Create
```julia
f = ZXing_BarcodeFormat_QRCode
co = CreatorOptions(f)
bc = Barcode("HELLO WORLD", co)
print(bc)
```
### Write
```julia
wo = WriterOptions(; scale=10)
zimg = write_barcode_to_image(bc, wo)
cvimg = OpenCV.Mat(zimg)
OpenCV.imwrite("barcode.png", cvimg)
```
### Read
```julia
img = OpenCV.imread("barcode.png", OpenCV.IMREAD_UNCHANGED)
ro = ReaderOptions(; formats=ZXing_BarcodeFormat_QRCode)
bcs = read_barcodes(img, ro)
print(bcs)
```
