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
    else
        ZXing_CPP.libZXingCpp.ZXing_ImageFormat_BGR
    end
    return ZXing_CPP.ImageView(img, Int32(w), Int32(h), fmt)
end

end