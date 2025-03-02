using .libZXingCpp:
    ZXing_Barcode,
    ZXing_BarcodeFormat,
    ZXing_BarcodeFormatToString,
    ZXing_Barcode_delete,
    ZXing_Barcode_isValid,
    # ZXing_Barcode_errorType,
    # ZXing_Barcode_errorMsg,
    ZXing_Barcode_format,
    # ZXing_Barcode_contentType,
    # ZXing_Barcode_bytes,
    # ZXing_Barcode_bytesECI,
    ZXing_Barcode_text,
    ZXing_Barcode_ecLevel,
    ZXing_Barcode_symbologyIdentifier,
    ZXing_Barcode_position,
    ZXing_Barcode_orientation,
    ZXing_Barcode_hasECI,
    ZXing_Barcode_isInverted,
    ZXing_Barcode_isMirrored,
    ZXing_Barcode_lineCount,
    ZXing_Barcodes,
    ZXing_Barcodes_delete,
    ZXing_Barcodes_size,
    ZXing_Barcodes_at

# include("utils.jl")

Base.string(barcode_format::ZXing_BarcodeFormat) = unsafe_string(ZXing_BarcodeFormatToString(barcode_format))


# Barcode
# create_zxing_ptr_struct(:Barcode, :ZXing_Barcode)
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

# To-Do
# error_type(barcode::Barcode) = ZXing_Barcode_errorType(barcode.ptr)
# error_msg(barcode::Barcode) = unsafe_string(ZXing_Barcode_errorMsg(barcode.ptr))

format(barcode::Barcode) = ZXing_Barcode_format(barcode.ptr)

# To-Do
# format(barcode::Barcode) = ZXing_Barcode_format(barcode.ptr)
# content_type(barcode::Barcode) = ZXing_Barcode_contentType(barcode.ptr)
# bytes(barcode::Barcode) = ZXing_Barcode_bytes(barcode.ptr, len)
# bytes_eci(barcode::Barcode) = ZXing_Barcode_bytesECI(barcode.ptr, len)

text(barcode::Barcode) = unsafe_string(ZXing_Barcode_text(barcode.ptr))
ec_level(barcode::Barcode) = unsafe_string(ZXing_Barcode_ecLevel(barcode.ptr))
symbology_identifier(barcode::Barcode) = unsafe_string(ZXing_Barcode_symbologyIdentifier(barcode.ptr))
position(barcode::Barcode) = ZXing_Barcode_position(barcode.ptr)
orientation(barcode::Barcode) = ZXing_Barcode_orientation(barcode.ptr)
has_eci(barcode::Barcode) = ZXing_Barcode_hasECI(barcode.ptr)
is_inverted(barcode::Barcode) = ZXing_Barcode_isInverted(barcode.ptr)
is_mirrored(barcode::Barcode) = ZXing_Barcode_isMirrored(barcode.ptr)
line_count(barcode::Barcode) = ZXing_Barcode_lineCount(barcode.ptr)

## To-Do: Improve
function Base.show(io::IO, barcode::Barcode)
    fmt = string(format(barcode))
    txt = text(barcode)
    print(
        io,
        """
Barcode(
    Format: $(fmt)
    Text: $(txt)
)"""
    )
end

# Barcodes
# create_zxing_ptr_struct(:Barcodes, :ZXing_Barcodes)
mutable struct Barcodes
    ptr::Ptr{ZXing_Barcodes}

    function Barcodes(ptr::Ptr{ZXing_Barcodes})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_Barcodes_delete(obj.ptr)
        end
    end
end

Base.eltype(::Type{Barcodes}) = Barcode
Base.length(barcodes::Barcodes) = ZXing_Barcodes_size(barcodes.ptr)

function Base.getindex(barcodes::Barcodes, i::Int)
    1 <= i <= length(barcodes) || throw(BoundsError(barcodes, i))
    ptr = ZXing_Barcodes_at(barcodes.ptr, i - 1)
    return Barcode(ptr)
end
Base.getindex(barcodes::Barcodes, i::Number) = barcodes[convert(Int, i)]

Base.firstindex(barcodes::Barcodes) = 1
Base.lastindex(barcodes::Barcodes) = length(barcodes)

Base.iterate(barcodes::Barcodes, state=1) = state > length(barcodes) ? nothing : (barcodes[state], state + 1)

function Base.show(io::IO, barcodes::Barcodes)
    println(io, "Barcodes[")
    for barcode in barcodes
        show(io, barcode)
        println(io, ",")
    end
    print(io, "]")
end
