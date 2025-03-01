module ZXingCPPOpenCVExt

using OpenCV
using ZXing_CPP

function OpenCV.Mat(img::Image)
    d = ZXing_CPP.data(img)
    opencv_data = reshape(d, 1, size(d)...)
    return OpenCV.Mat(opencv_data)
end

function ZXing_CPP.ImageView(img::OpenCV.Mat{UInt8})
    c, w, h = size(img)
    fmt = if c == 1
        ZXing_CPP.libZXingCpp.ZXing_ImageFormat_Lum
    elseif c == 2
        ZXing_CPP.libZXingCpp.ZXing_ImageFormat_LumA
    elseif c == 3
        ZXing_CPP.libZXingCpp.ZXing_ImageFormat_BGR
    else
        # c==4
        ZXing_CPP.libZXingCpp.ZXing_ImageFormat_BGRA
    end
    return ZXing_CPP.ImageView(img, Int32(w), Int32(h), fmt)
end

ZXing_CPP.read_barcodes(img::OpenCV.Mat{UInt8}, opts::ReaderOptions=ReaderOptions()) = read_barcodes(ImageView(img), opts)

end