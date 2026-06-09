function Base.show(io::IO, content_type::ZXing_ContentType)
    str = unsafe_string(ZXing_ContentTypeToString(content_type))
    print(io, str)
end
Base.print(io::IO, content_type::ZXing_ContentType) = show(io, content_type)


function Base.show(io::IO, position::ZXing_Position)
    str = unsafe_string(ZXing_PositionToString(position))
    print(io, str)
end
Base.print(io::IO, position::ZXing_Position) = show(io, position)
