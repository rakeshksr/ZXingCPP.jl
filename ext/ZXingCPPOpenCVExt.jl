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
        ZXing_ImageFormat_Lum
    elseif c == 2
        ZXing_ImageFormat_LumA
    elseif c == 3
        ZXing_ImageFormat_BGR
    else
        # c==4
        ZXing_ImageFormat_BGRA
    end
    return ImageView(img, w, h, fmt)
end

function Base.convert(::Type{OpenCV.Mat}, img::Image)
    OpenCV.Mat(img)
end
function Base.convert(::Type{ImageView}, img::OpenCV.Mat)
    ImageView(img)
end

function ZXingCPP.read_barcodes(
        img::OpenCV.Mat{UInt8}, opts::ReaderOptions = ReaderOptions())
    read_barcodes(ImageView(img), opts)
end

end
