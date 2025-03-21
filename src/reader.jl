mutable struct ReaderOptions
    ptr::Ptr{ZXing_ReaderOptions}

    function ReaderOptions(ptr::Ptr{ZXing_ReaderOptions})
        obj = new(ptr)
        finalizer(obj) do obj
            ZXing_ReaderOptions_delete(obj.ptr)
        end
    end
end

function ReaderOptions(; kwargs...)
    ptr = ZXing_ReaderOptions_new()
    opts = ReaderOptions(ptr)
    kw_map = Dict(
        :try_harder => set_try_harder!,
        :try_rotate => set_try_rotate!,
        :try_invert => set_try_invert!,
        :try_downscale => set_try_downscale!,
        :is_pure => set_is_pure!,
        :return_errors => set_return_errors!,
        :formats => set_formats!,
        :binarizer => set_binarizer!,
        :ean_add_on_symbol => set_ean_add_on_symbol!,
        :text_mode => set_text_mode!,
        :min_line_count => set_min_line_count!,
        :max_number_of_symbols => set_max_number_of_symbols!
    )
    for (k, v) in kwargs
        fun = kw_map[k]
        fun(opts, v)
    end
    return opts
end

function set_try_harder!(opts::ReaderOptions, try_harder::Bool)
    ZXing_ReaderOptions_setTryHarder(opts.ptr, try_harder)
end
function set_try_rotate!(opts::ReaderOptions, try_rotate::Bool)
    ZXing_ReaderOptions_setTryRotate(opts.ptr, try_rotate)
end
function set_try_invert!(opts::ReaderOptions, try_invert::Bool)
    ZXing_ReaderOptions_setTryInvert(opts.ptr, try_invert)
end
function set_try_downscale!(opts::ReaderOptions, try_downscale::Bool)
    ZXing_ReaderOptions_setTryDownscale(opts.ptr, try_downscale)
end
function set_is_pure!(opts::ReaderOptions, is_pure::Bool)
    ZXing_ReaderOptions_setIsPure(opts.ptr, is_pure)
end
function set_return_errors!(opts::ReaderOptions, return_errors::Bool)
    ZXing_ReaderOptions_setReturnErrors(opts.ptr, return_errors)
end
function set_formats!(opts::ReaderOptions, formats::ZXing_BarcodeFormats)
    ZXing_ReaderOptions_setFormats(opts.ptr, formats)
end
function set_binarizer!(opts::ReaderOptions, binarizer::ZXing_Binarizer)
    ZXing_ReaderOptions_setBinarizer(opts.ptr, binarizer)
end
function set_ean_add_on_symbol!(
        opts::ReaderOptions, ean_add_on_symbol::ZXing_EanAddOnSymbol)
    ZXing_ReaderOptions_setEanAddOnSymbol(opts.ptr, ean_add_on_symbol)
end
function set_text_mode!(opts::ReaderOptions, text_mode::ZXing_TextMode)
    ZXing_ReaderOptions_setTextMode(opts.ptr, text_mode)
end
function set_min_line_count!(opts::ReaderOptions, n::Integer)
    ZXing_ReaderOptions_setMinLineCount(opts.ptr, n)
end
function set_max_number_of_symbols!(opts::ReaderOptions, n::Integer)
    ZXing_ReaderOptions_setMaxNumberOfSymbols(opts.ptr, n)
end

get_try_harder(opts::ReaderOptions) = ZXing_ReaderOptions_getTryHarder(opts.ptr)
get_try_rotate(opts::ReaderOptions) = ZXing_ReaderOptions_getTryRotate(opts.ptr)
get_try_invert(opts::ReaderOptions) = ZXing_ReaderOptions_getTryInvert(opts.ptr)
get_try_downscale(opts::ReaderOptions) = ZXing_ReaderOptions_getTryDownscale(opts.ptr)
get_is_pure(opts::ReaderOptions) = ZXing_ReaderOptions_getIsPure(opts.ptr)
get_return_errors(opts::ReaderOptions) = ZXing_ReaderOptions_getReturnErrors(opts.ptr)
get_formats(opts::ReaderOptions) = ZXing_ReaderOptions_getFormats(opts.ptr)
get_binarizer(opts::ReaderOptions) = ZXing_ReaderOptions_getBinarizer(opts.ptr)
get_ean_add_on_symbol(opts::ReaderOptions) = ZXing_ReaderOptions_getEanAddOnSymbol(opts.ptr)
get_text_mode(opts::ReaderOptions) = ZXing_ReaderOptions_getTextMode(opts.ptr)
get_min_line_count(opts::ReaderOptions) = ZXing_ReaderOptions_getMinLineCount(opts.ptr)
function get_max_number_of_symbols(opts::ReaderOptions)
    ZXing_ReaderOptions_getMaxNumberOfSymbols(opts.ptr)
end

function Base.show(io::IO, opts::ReaderOptions)
    try_harder = get_try_harder(opts)
    try_rotate = get_try_rotate(opts)
    try_invert = get_try_invert(opts)
    try_downscale = get_try_downscale(opts)
    is_pure = get_is_pure(opts)
    return_errors = get_return_errors(opts)
    formats = string(get_formats(opts))
    binarizer = get_binarizer(opts)
    ean_add_on_symbol = get_ean_add_on_symbol(opts)
    text_mode = get_text_mode(opts)
    min_line_count = get_min_line_count(opts)
    max_number_of_symbols = get_max_number_of_symbols(opts)
    print(
        io,
        """
ReaderOptions(
    try_harder: $try_harder
    try_rotate: $try_rotate
    try_invert: $try_invert
    try_downscale: $try_downscale
    is_pure: $is_pure
    return_errors: $return_errors
    formats: $formats
    binarizer: $binarizer
    ean_add_on_symbol: $ean_add_on_symbol
    text_mode: $text_mode
    min_line_count: $min_line_count
    max_number_of_symbols: $max_number_of_symbols
)
    """
    )
end

function read_barcodes(iv::ImageView, opts::ReaderOptions = ReaderOptions())
    Barcodes(ZXing_ReadBarcodes(iv.ptr, opts.ptr))
end
