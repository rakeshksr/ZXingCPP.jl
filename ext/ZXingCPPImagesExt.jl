module ZXingCPPImagesExt

using ImageCore
using ZXingCPP

function Base.Matrix{Gray{N0f8}}(img::Image)
    d = ZXingCPP.data(img)
    nv = normedview(d)
    pimg = permutedims(nv)
    gimg = Gray.(pimg)
    return gimg
end

function Base.Matrix(img::Image)
    return Matrix{Gray{N0f8}}(img::Image)
end

function ZXingCPP.ImageView(img::AbstractMatrix{T}) where {N, T <: Colorant{N0f8, N}}
    h, w = size(img)
    cv = channelview(img)

    cvp = if T == Gray{N0f8}
        permutedims(cv, (2, 1))
    else
        permutedims(cv, (1, 3, 2))
    end

    rv = rawview(cvp)

    fmt = if T == Gray{N0f8}
        ZXing_ImageFormat_Lum
    elseif T == GrayA{N0f8}
        ZXing_ImageFormat_LumA
    elseif T == RGB{N0f8}
        ZXing_ImageFormat_RGB
    elseif T == BGR{N0f8}
        ZXing_ImageFormat_BGR
    elseif T == RGBA{N0f8}
        ZXing_ImageFormat_RGBA
    elseif T == ARGB{N0f8}
        ZXing_ImageFormat_ARGB
    elseif T == BGRA{N0f8}
        ZXing_ImageFormat_BGRA
    elseif T == ABGR{N0f8}
        ZXing_ImageFormat_ABGR
    else
        ZXing_ImageFormat_None
    end

    if fmt == ZXing_ImageFormat_None
        throw(ArgumentError("Unsupported Image type: $(typeof(img))"))
    end

    return ZXingCPP.ImageView(rv, w, h, fmt)
end

function Base.convert(::Type{Matrix{Gray{N0f8}}}, img::Image)
    return Matrix(img)
end
function Base.convert(::Type{ImageView}, img::Matrix{T}) where {N, T <: Colorant{N0f8, N}}
    return ImageView(img)
end

function ZXingCPP.read_barcodes(
        img::AbstractMatrix{T},
        opts::ReaderOptions = ReaderOptions()
    ) where {N, T <: Colorant{N0f8, N}}
    return read_barcodes(ImageView(img), opts)
end

end
