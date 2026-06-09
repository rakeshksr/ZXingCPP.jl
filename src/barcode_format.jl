function Base.show(io::IO, barcode_format::ZXing_BarcodeFormat)
    str = unsafe_string(ZXing_BarcodeFormatToString(barcode_format))
    print(io, str)
end

Base.print(io::IO, barcode_format::ZXing_BarcodeFormat) = show(io, barcode_format)


libZXingCpp.ZXing_BarcodeFormat(str::String) = ZXing_BarcodeFormatFromString(str)
symbology(format::ZXing_BarcodeFormat) = ZXing_BarcodeFormatSymbology(format)

const BarcodeFormats = Vector{ZXing_BarcodeFormat}

function BarcodeFormats(filter::ZXing_BarcodeFormat)
    len = Ref{Int32}(0)
    list_ptr = ZXing_BarcodeFormatsList(filter, len)
    return unsafe_wrap(BarcodeFormats, list_ptr, len[])
end

function BarcodeFormats(str::String)
    len = Ref{Int32}(0)
    ptr = ZXing_BarcodeFormatsFromString(str, len)
    return unsafe_wrap(BarcodeFormats, ptr, len[])
end
