using .libZXingCpp:
    ZXing_BarcodeFormat,
    ZXing_CreatorOptions,
    ZXing_CreatorOptions_new,
    ZXing_CreatorOptions_delete,
    ZXing_CreatorOptions_setFormat,
    ZXing_CreatorOptions_setReaderInit,
    ZXing_CreatorOptions_setForceSquareDataMatrix,
    ZXing_CreatorOptions_setEcLevel,
    ZXing_CreatorOptions_getFormat,
    ZXing_CreatorOptions_getReaderInit,
    ZXing_CreatorOptions_getForceSquareDataMatrix,
    ZXing_CreatorOptions_getEcLevel,
    ZXing_CreateBarcodeFromText


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
        # :format => set_format!,
        :reader_init => set_reader_init!,
        :force_square_data_matrix => set_force_square_data_matrix!,
        :ec_level => set_ec_level!,
    )
    for (k, v) in kwargs
        fun = kw_map[k]
        fun(opts, v)
    end
    return opts
end

# ERROR: could not load symbol "ZXing_CreatorOptions_setFormat"
# set_format!(opts::CreatorOptions, format::ZXing_BarcodeFormat) = ZXing_CreatorOptions_setFormat(opts.ptr, format)
set_reader_init!(opts::CreatorOptions, reader_init::Bool) = ZXing_CreatorOptions_setReaderInit(opts.ptr, reader_init)
set_force_square_data_matrix!(opts::CreatorOptions, force_square_data_matrix::Bool) = ZXing_CreatorOptions_setForceSquareDataMatrix(opts.ptr, force_square_data_matrix)
set_ec_level!(opts::CreatorOptions, ec_level::String) = ZXing_CreatorOptions_setEcLevel(opts.ptr, ec_level)

# ERROR: could not load symbol "ZXing_CreatorOptions_getFormat"
# get_format(opts::CreatorOptions) = ZXing_CreatorOptions_getFormat(opts.ptr)
get_reader_init(opts::CreatorOptions) = ZXing_CreatorOptions_getReaderInit(opts.ptr)
get_force_square_data_matrix(opts::CreatorOptions) = ZXing_CreatorOptions_getForceSquareDataMatrix(opts.ptr)
get_ec_level(opts::CreatorOptions) = unsafe_string(ZXing_CreatorOptions_getEcLevel(opts.ptr))

function Base.show(io::IO, opts::CreatorOptions)
    # format = get_format(opts)
    reader = get_reader_init(opts)
    force_square_data_matrix = get_force_square_data_matrix(opts)
    ec_level = get_ec_level(opts)

    print(
        io,
        """
CreatorOptions(
    format: 
    reader: $reader
    force_square_data_matrix: $force_square_data_matrix
    ec_level: $ec_level
)
    """
    )
end

create_barcode_from_text(data::String, size::Int32, opts::CreatorOptions) = Barcode(ZXing_CreateBarcodeFromText(data, size, opts.ptr))
create_barcode_from_text(data::String, opts::CreatorOptions) = Barcode(ZXing_CreateBarcodeFromText(data, 0, opts.ptr))
Barcode(data::String, size::Int32, opts::CreatorOptions) = create_barcode_from_text(data, size, opts)
Barcode(data::String, opts::CreatorOptions) = create_barcode_from_text(data, opts)
# To-Do
# function ZXing_CreateBarcodeFromBytes(data, size, opts)
#     @ccall libZXing.ZXing_CreateBarcodeFromBytes(data::Ptr{Cvoid}, size::Cint, opts::Ptr{ZXing_CreatorOptions})::Ptr{ZXing_Barcode}
# end
