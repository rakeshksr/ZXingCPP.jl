# Barcode
mutable struct Barcode
    ptr::Ptr{ZXing_Barcode}

    function Barcode(ptr::Ptr{ZXing_Barcode})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_Barcode_delete(obj.ptr)
        end
    end
end

is_valid(barcode::Barcode) = ZXing_Barcode_isValid(barcode.ptr)
error_type(barcode::Barcode) = ZXing_Barcode_errorType(barcode.ptr)
error_msg(barcode::Barcode) = unsafe_string(ZXing_Barcode_errorMsg(barcode.ptr))
format(barcode::Barcode) = ZXing_Barcode_format(barcode.ptr)
content_type(barcode::Barcode) = ZXing_Barcode_contentType(barcode.ptr)

function bytes(barcode::Barcode)
    len = Ref{Int32}(0)
    bytes_ptr = ZXing_Barcode_bytes(barcode.ptr, len)
    return unsafe_wrap(Array, bytes_ptr, len[])
end

function bytes_eci(barcode::Barcode)
    len = Ref{Int32}(0)
    bytes_ptr = ZXing_Barcode_bytesECI(barcode.ptr, len)
    return unsafe_wrap(Array, bytes_ptr, len[])
end

text(barcode::Barcode) = unsafe_string(ZXing_Barcode_text(barcode.ptr))
ec_level(barcode::Barcode) = unsafe_string(ZXing_Barcode_ecLevel(barcode.ptr))
function symbology_identifier(barcode::Barcode)
    unsafe_string(ZXing_Barcode_symbologyIdentifier(barcode.ptr))
end
Base.position(barcode::Barcode) = ZXing_Barcode_position(barcode.ptr)
orientation(barcode::Barcode) = ZXing_Barcode_orientation(barcode.ptr)
has_eci(barcode::Barcode) = ZXing_Barcode_hasECI(barcode.ptr)
is_inverted(barcode::Barcode) = ZXing_Barcode_isInverted(barcode.ptr)
is_mirrored(barcode::Barcode) = ZXing_Barcode_isMirrored(barcode.ptr)
line_count(barcode::Barcode) = ZXing_Barcode_lineCount(barcode.ptr)

function Base.show(io::IO, ::MIME"text/plain", barcode::Barcode)
    fmt = string(format(barcode))
    txt = text(barcode)
    print(
        io,
        """
Barcode(
    Text: $(txt)
    Format: $(fmt)
)"""
    )
end

function Base.show(io::IO, barcode::Barcode)
    fmt = string(format(barcode))
    txt = text(barcode)
    print(
        io,
        "Barcode(Text: $(txt), Format: $(fmt))"
    )
end

# Barcodes
const Barcodes = Array{Barcode, 1}

function Barcodes(bcs::Ptr{ZXing_Barcodes})
    len = ZXing_Barcodes_size(bcs)
    barcodes = Barcodes(undef, len)
    for i in 1:len
        bc = Barcode(ZXing_Barcodes_move(bcs, i - 1))
        barcodes[i] = bc
    end
    ZXing_Barcodes_delete(bcs)
    return barcodes
end
