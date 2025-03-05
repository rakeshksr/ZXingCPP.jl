mutable struct ImageView
    ptr::Ptr{ZXing_ImageView}

    function ImageView(ptr::Ptr{ZXing_ImageView})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_ImageView_delete(obj.ptr)
        end
    end
end

function ImageView(data::Ptr{UInt8}, width::Integer, height::Integer, fmt::ZXing_ImageFormat, row_stride=0, pix_stride=0)
    ptr = ZXing_ImageView_new(data, width, height, fmt, row_stride, pix_stride)
    return ImageView(ptr)
end

function ImageView(data::AbstractArray{UInt8}, width::Integer, height::Integer, fmt::ZXing_ImageFormat, row_stride=0, pix_stride=0)
    s = length(data)
    ptr = ZXing_ImageView_new_checked(data, s, width, height, fmt, row_stride, pix_stride)
    return ImageView(ptr)
end

function ImageView(data::AbstractMatrix{UInt8}, row_stride=0, pix_stride=0)
    h = size(data, 1)
    w = size(data, 2)
    s = length(data)
    fmt = ZXing_ImageFormat_Lum
    ptr = ZXing_ImageView_new_checked(data, s, w, h, fmt, row_stride, pix_stride)
    return ImageView(ptr)
end

crop!(iv::ImageView, left::Integer, top::Integer, width::Integer, height::Integer) = ZXing_ImageView_crop(iv.ptr, left, top, width, height)
rotate!(iv::ImageView, degree::Integer) = ZXing_ImageView_rotate(iv.ptr, degree)

mutable struct Image
    ptr::Ptr{ZXing_Image}

    function Image(ptr::Ptr{ZXing_Image})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_Image_delete(obj.ptr)
        end
    end
end

width(img::Image) = ZXing_Image_width(img.ptr)
height(img::Image) = ZXing_Image_height(img.ptr)
function data(img::Image)
    dp = ZXing_Image_data(img.ptr)
    w = width(img)
    h = height(img)
    return unsafe_wrap(Array, dp, (w, h))
end
format(img::Image) = ZXing_Image_format(img.ptr)

function ImageView(img::Image)
    ptr = img.ptr
    dp = ZXing_Image_data(ptr)
    w = ZXing_Image_width(ptr)
    h = ZXing_Image_height(ptr)
    fmt = ZXing_Image_format(ptr)
    ImageView(dp, w, h, fmt)
end
