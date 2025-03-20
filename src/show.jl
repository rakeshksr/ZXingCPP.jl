function Base.show(io::IO, ::MIME"text/plain", barcode_format::ZXing_BarcodeFormat)
    str = unsafe_string(ZXing_BarcodeFormatToString(barcode_format))
    print(io, str)
end

function Base.show(io::IO, ::MIME"text/plain", content_type::ZXing_ContentType)
    str = unsafe_string(ZXing_ContentTypeToString(content_type))
    print(io, str)
end

function Base.show(io::IO, ::MIME"text/plain", position::ZXing_Position)
    str = unsafe_string(ZXing_PositionToString(position))
    print(io, str)
end
