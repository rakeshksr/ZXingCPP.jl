module ZXingCPPOpenCVExt

using OpenCV
using ZXingCPP

function OpenCV.Mat(img::Image)
    d = ZXingCPP.data(img)
    opencv_data = reshape(d, 1, size(d)...)
    return OpenCV.Mat(opencv_data)
end

function ZXingCPP.ImageView(img::OpenCV.Mat{UInt8})
    c, w, h = size(img)
    fmt = if c == 1
        ZXingCPP.libZXingCpp.ZXing_ImageFormat_Lum
    elseif c == 2
        ZXingCPP.libZXingCpp.ZXing_ImageFormat_LumA
    elseif c == 3
        ZXingCPP.libZXingCpp.ZXing_ImageFormat_BGR
    else
        # c==4
        ZXingCPP.libZXingCpp.ZXing_ImageFormat_BGRA
    end
    return ZXingCPP.ImageView(img, w, h, fmt)
end

ZXingCPP.read_barcodes(img::OpenCV.Mat{UInt8}, opts::ReaderOptions=ReaderOptions()) = read_barcodes(ImageView(img), opts)

end