using .libZXingCpp:
    ZXing_ImageFormat,
    ZXing_ImageView,
    ZXing_ImageView_delete,
    ZXing_ImageView_new,
    ZXing_ImageView_new_checked,
    ZXing_Image,
    ZXing_Image_delete,
    ZXing_Image_data,
    ZXing_Image_width,
    ZXing_Image_height,
    ZXing_Image_format

# Image View
mutable struct ImageView
    ptr::Ptr{ZXing_ImageView}

    function ImageView(ptr::Ptr{ZXing_ImageView})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_ImageView_delete(obj.ptr)
        end
    end
end

function ImageView(data::Ptr{UInt8}, width::Cint, height::Cint, format::ZXing_ImageFormat, row_stride=0, pix_stride=0)
    ptr = ZXing_ImageView_new(data, width, height, format, row_stride, pix_stride)
    return ImageView(ptr)
end

function ImageView(data::AbstractArray{UInt8}, width::Cint, height::Cint, format::ZXing_ImageFormat, row_stride=0, pix_stride=0)
    s = length(data)
    ptr = ZXing_ImageView_new_checked(data, s, width, height, format, row_stride, pix_stride)
    return ImageView(ptr)
end

function ImageView(data::AbstractMatrix{UInt8}, format::ZXing_ImageFormat, row_stride=0, pix_stride=0)
    h = size(data, 1)
    w = size(data, 2)
    s = length(data)
    ptr = ZXing_ImageView_new_checked(data, s, w, h, format, row_stride, pix_stride)
    return ImageView(ptr)
end


# Image
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
