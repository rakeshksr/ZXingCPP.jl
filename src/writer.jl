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
        :size_hint => set_size_hint!,
        :rotate => set_rotate!,
        :with_hrt => set_with_hrt!,
        :with_quiet_zones => set_with_quiet_zones!
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
function set_size_hint!(opts::WriterOptions, size_hint::Integer)
    ZXing_WriterOptions_setSizeHint(opts.ptr, size_hint)
end
function set_rotate!(opts::WriterOptions, rotate::Integer)
    ZXing_WriterOptions_setRotate(opts.ptr, rotate)
end
function set_with_hrt!(opts::WriterOptions, with_hrt::Bool)
    ZXing_WriterOptions_setWithHRT(opts.ptr, with_hrt)
end
function set_with_quiet_zones!(opts::WriterOptions, with_quiet_zones::Bool)
    ZXing_WriterOptions_setWithQuietZones(opts.ptr, with_quiet_zones)
end

get_scale(opts::WriterOptions) = ZXing_WriterOptions_getScale(opts.ptr)
get_size_hint(opts::WriterOptions) = ZXing_WriterOptions_getSizeHint(opts.ptr)
get_rotate(opts::WriterOptions) = ZXing_WriterOptions_getRotate(opts.ptr)
get_with_hrt(opts::WriterOptions) = ZXing_WriterOptions_getWithHRT(opts.ptr)
get_with_quiet_zones(opts::WriterOptions) = ZXing_WriterOptions_getWithQuietZones(opts.ptr)

function Base.show(io::IO, opts::WriterOptions)
    scale = get_scale(opts)
    size_hint = get_size_hint(opts)
    rotate = get_rotate(opts)
    with_hrt = get_with_hrt(opts)
    with_quiet_zones = get_with_quiet_zones(opts)
    print(
        io,
        """
WriterOptions(
    scale: $scale
    size_hint: $size_hint
    rotate: $rotate
    with_hrt: $with_hrt
    with_quiet_zones: $with_quiet_zones
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
