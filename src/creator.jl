mutable struct CreatorOptions
    ptr::Ptr{ZXing_CreatorOptions}

    function CreatorOptions(ptr::Ptr{ZXing_CreatorOptions})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_CreatorOptions_delete(obj.ptr)
        end
    end
end

function CreatorOptions(format::ZXing_BarcodeFormat; kwargs...)
    ptr = ZXing_CreatorOptions_new(format)
    opts = CreatorOptions(ptr)
    kw_map = Dict(
        :format => set_format!,
        :options => set_options!
    )
    for (k, v) in kwargs
        fun = kw_map[k]
        fun(opts, v)
    end
    return opts
end

set_format!(opts::CreatorOptions, format::ZXing_BarcodeFormat) = ZXing_CreatorOptions_setFormat(opts.ptr, format)
function set_options!(opts::CreatorOptions, options::String)
    ZXing_CreatorOptions_setOptions(opts.ptr, options)
end

get_format(opts::CreatorOptions) = ZXing_CreatorOptions_getFormat(opts.ptr)
function get_options(opts::CreatorOptions)
    unsafe_string(ZXing_CreatorOptions_getOptions(opts.ptr))
end

function Base.show(io::IO, opts::CreatorOptions)
    format = get_format(opts)
    options = get_options(opts)

    print(
        io,
        """
CreatorOptions(
    format: $format
    options: $options
    )
"""
    )
end

function create_barcode_from_text(data::String, sz::Integer, opts::CreatorOptions)
    Barcode(ZXing_CreateBarcodeFromText(data, sz, opts.ptr))
end
function create_barcode_from_text(data::String, opts::CreatorOptions)
    create_barcode_from_text(data, 0, opts)
end
function create_barcode_from_bytes(
        data::AbstractArray{UInt8}, sz::Integer, opts::CreatorOptions)
    data_ptr = pointer(data)
    Barcode(ZXing_CreateBarcodeFromBytes(data_ptr, sz, opts.ptr))
end
function create_barcode_from_bytes(data::AbstractArray{UInt8}, opts::CreatorOptions)
    sz = length(data)
    return create_barcode_from_bytes(data, sz, opts)
end

function Barcode(data::String, sz::Integer, opts::CreatorOptions)
    create_barcode_from_text(data, sz, opts)
end
Barcode(data::String, opts::CreatorOptions) = create_barcode_from_text(data, opts)
function Barcode(data::AbstractArray{UInt8}, sz::Integer, opts::CreatorOptions)
    create_barcode_from_bytes(data, sz, opts)
end
function Barcode(data::AbstractArray{UInt8}, opts::CreatorOptions)
    create_barcode_from_bytes(data, opts)
end
