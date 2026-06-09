mutable struct WriterOptions
    ptr::Ptr{ZXing_WriterOptions}

    function WriterOptions(ptr::Ptr{ZXing_WriterOptions})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_WriterOptions_delete(obj.ptr)
        end
    end
end

function WriterOptions(; kwargs...)
    ptr = ZXing_WriterOptions_new()
    opts = WriterOptions(ptr)
    kw_map = Dict(
        :scale => set_scale!,
        :rotate => set_rotate!,
        :add_hrt => set_add_hrt!,
        :add_quiet_zones => set_add_quiet_zones!
    )
    for (k, v) in kwargs
        fun = kw_map[k]
        fun(opts, v)
    end
    return opts
end

function set_scale!(opts::WriterOptions, scale::Integer)
    ZXing_WriterOptions_setScale(opts.ptr, scale)
end
function set_rotate!(opts::WriterOptions, rotate::Integer)
    ZXing_WriterOptions_setRotate(opts.ptr, rotate)
end
function set_add_hrt!(opts::WriterOptions, add_hrt::Bool)
    ZXing_WriterOptions_setAddHRT(opts.ptr, add_hrt)
end
function set_add_quiet_zones!(opts::WriterOptions, add_quiet_zones::Bool)
    ZXing_WriterOptions_setAddQuietZones(opts.ptr, add_quiet_zones)
end

get_scale(opts::WriterOptions) = ZXing_WriterOptions_getScale(opts.ptr)
get_rotate(opts::WriterOptions) = ZXing_WriterOptions_getRotate(opts.ptr)
get_add_hrt(opts::WriterOptions) = ZXing_WriterOptions_getAddHRT(opts.ptr)
get_add_quiet_zones(opts::WriterOptions) = ZXing_WriterOptions_getAddQuietZones(opts.ptr)

function Base.show(io::IO, opts::WriterOptions)
    scale = get_scale(opts)
    rotate = get_rotate(opts)
    add_hrt = get_add_hrt(opts)
    add_quiet_zones = get_add_quiet_zones(opts)
    print(
        io,
        """
WriterOptions(
    scale: $scale
    rotate: $rotate
    add_hrt: $add_hrt
    add_quiet_zones: $add_quiet_zones
)
    """
    )
end

function write_barcode_to_svg(barcode::Barcode, opts::WriterOptions = WriterOptions())
    unsafe_string(ZXing_WriteBarcodeToSVG(barcode.ptr, opts.ptr))
end
function write_barcode_to_image(barcode::Barcode, opts::WriterOptions = WriterOptions())
    Image(ZXing_WriteBarcodeToImage(barcode.ptr, opts.ptr))
end
