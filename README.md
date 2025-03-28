# ZXingCPP

[![Build Status](https://github.com/rakeshksr/ZXingCPP.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/rakeshksr/ZXingCPP.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![SciML Code Style](https://img.shields.io/static/v1?label=code%20style&message=SciML&color=9558b2&labelColor=389826)](https://github.com/SciML/SciMLStyle)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/rakeshksr/ZXingCPP.jl/blob/main/LICENSE)


ZXingCPP.jl is a Julia wrapper for the C++ library [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp). It is an open-source, multi-format linear/matrix barcode image processing library implemented in C++.

ZXingCPP.jl provides fast and accurate barcode detection, decoding and creation within Julia.

ZXingCPP.jl integrated with [Images.jl](https://github.com/JuliaImages/Images.jl) and [OpenCV.jl](https://github.com/JuliaImages/OpenCV.jl). Both packages can used to read and write barcode images.

## Usage

### Using Images.jl

```julia
using ZXingCPP

using ImageCore
using FileIO
using ImageIO
```

**Create:**
```julia
f = ZXing_BarcodeFormat_QRCode
co = CreatorOptions(f)
bc = Barcode("HELLO WORLD", co)
print(bc)
```

**Write:**
```julia
wo = WriterOptions(; scale=10)
zimg = write_barcode_to_image(bc, wo)
jimg = Matrix(zimg)
save("barcode.png", jimg)
```

**Read:**
```julia
img = load("barcode.png")
ro = ReaderOptions(; formats=ZXing_BarcodeFormat_QRCode)
bcs = read_barcodes(img, ro)
print(bcs)
```

Pluto notebook with annotation example using `Images.jl` found at [here](examples/annotation_images.jl)

### Using OpenCV.jl

```julia
using ZXingCPP
using OpenCV
```
**Create:**
```julia
f = ZXing_BarcodeFormat_QRCode
co = CreatorOptions(f)
bc = Barcode("HELLO WORLD", co)
print(bc)
```

**Write:**
```julia
wo = WriterOptions(; scale=10)
zimg = write_barcode_to_image(bc, wo)
cvimg = OpenCV.Mat(zimg)
OpenCV.imwrite("barcode.png", cvimg)
```

**Read:**
```julia
img = OpenCV.imread("barcode.png", OpenCV.IMREAD_UNCHANGED)
ro = ReaderOptions(; formats=ZXing_BarcodeFormat_QRCode)
bcs = read_barcodes(img, ro)
print(bcs)
```

Pluto notebook with annotation example using `OpenCV.jl` found at [here](examples/annotation_opencv.jl)
