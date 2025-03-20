module libZXingCpp

using ZXing_CPP_jll
export ZXing_CPP_jll

using CEnum

mutable struct ZXing_Barcode end

mutable struct ZXing_Barcodes end

mutable struct ZXing_ImageView end

mutable struct ZXing_Image end

mutable struct ZXing_ReaderOptions end

mutable struct ZXing_CreatorOptions end

mutable struct ZXing_WriterOptions end

@cenum ZXing_ImageFormat::UInt32 begin
    ZXing_ImageFormat_None = 0
    ZXing_ImageFormat_Lum = 16777216
    ZXing_ImageFormat_LumA = 33554432
    ZXing_ImageFormat_RGB = 50331906
    ZXing_ImageFormat_BGR = 50462976
    ZXing_ImageFormat_RGBA = 67109122
    ZXing_ImageFormat_ARGB = 67174915
    ZXing_ImageFormat_BGRA = 67240192
    ZXing_ImageFormat_ABGR = 67305985
end

function ZXing_ImageView_new(data, width, height, format, rowStride, pixStride)
    @ccall libZXing.ZXing_ImageView_new(
        data::Ptr{UInt8}, width::Cint, height::Cint, format::ZXing_ImageFormat,
        rowStride::Cint, pixStride::Cint)::Ptr{ZXing_ImageView}
end

function ZXing_ImageView_new_checked(
        data, size, width, height, format, rowStride, pixStride)
    @ccall libZXing.ZXing_ImageView_new_checked(
        data::Ptr{UInt8}, size::Cint, width::Cint, height::Cint,
        format::ZXing_ImageFormat, rowStride::Cint, pixStride::Cint)::Ptr{ZXing_ImageView}
end

function ZXing_ImageView_delete(iv)
    @ccall libZXing.ZXing_ImageView_delete(iv::Ptr{ZXing_ImageView})::Cvoid
end

function ZXing_ImageView_crop(iv, left, top, width, height)
    @ccall libZXing.ZXing_ImageView_crop(
        iv::Ptr{ZXing_ImageView}, left::Cint, top::Cint, width::Cint, height::Cint)::Cvoid
end

function ZXing_ImageView_rotate(iv, degree)
    @ccall libZXing.ZXing_ImageView_rotate(iv::Ptr{ZXing_ImageView}, degree::Cint)::Cvoid
end

function ZXing_Image_delete(img)
    @ccall libZXing.ZXing_Image_delete(img::Ptr{ZXing_Image})::Cvoid
end

function ZXing_Image_data(img)
    @ccall libZXing.ZXing_Image_data(img::Ptr{ZXing_Image})::Ptr{UInt8}
end

function ZXing_Image_width(img)
    @ccall libZXing.ZXing_Image_width(img::Ptr{ZXing_Image})::Cint
end

function ZXing_Image_height(img)
    @ccall libZXing.ZXing_Image_height(img::Ptr{ZXing_Image})::Cint
end

function ZXing_Image_format(img)
    @ccall libZXing.ZXing_Image_format(img::Ptr{ZXing_Image})::ZXing_ImageFormat
end

@cenum ZXing_BarcodeFormat::UInt32 begin
    ZXing_BarcodeFormat_None = 0
    ZXing_BarcodeFormat_Aztec = 1
    ZXing_BarcodeFormat_Codabar = 2
    ZXing_BarcodeFormat_Code39 = 4
    ZXing_BarcodeFormat_Code93 = 8
    ZXing_BarcodeFormat_Code128 = 16
    ZXing_BarcodeFormat_DataBar = 32
    ZXing_BarcodeFormat_DataBarExpanded = 64
    ZXing_BarcodeFormat_DataMatrix = 128
    ZXing_BarcodeFormat_EAN8 = 256
    ZXing_BarcodeFormat_EAN13 = 512
    ZXing_BarcodeFormat_ITF = 1024
    ZXing_BarcodeFormat_MaxiCode = 2048
    ZXing_BarcodeFormat_PDF417 = 4096
    ZXing_BarcodeFormat_QRCode = 8192
    ZXing_BarcodeFormat_UPCA = 16384
    ZXing_BarcodeFormat_UPCE = 32768
    ZXing_BarcodeFormat_MicroQRCode = 65536
    ZXing_BarcodeFormat_RMQRCode = 131072
    ZXing_BarcodeFormat_DXFilmEdge = 262144
    ZXing_BarcodeFormat_DataBarLimited = 524288
    ZXing_BarcodeFormat_LinearCodes = 837502
    ZXing_BarcodeFormat_MatrixCodes = 211073
    ZXing_BarcodeFormat_Any = 1048575
    ZXing_BarcodeFormat_Invalid = 0x00000000ffffffff
end

const ZXing_BarcodeFormats = ZXing_BarcodeFormat

function ZXing_BarcodeFormatsFromString(str)
    @ccall libZXing.ZXing_BarcodeFormatsFromString(str::Cstring)::ZXing_BarcodeFormats
end

function ZXing_BarcodeFormatFromString(str)
    @ccall libZXing.ZXing_BarcodeFormatFromString(str::Cstring)::ZXing_BarcodeFormat
end

function ZXing_BarcodeFormatToString(format)
    @ccall libZXing.ZXing_BarcodeFormatToString(format::ZXing_BarcodeFormat)::Cstring
end

@cenum ZXing_Operation::UInt32 begin
    ZXing_Operation_Create = 0
    ZXing_Operation_Read = 1
    ZXing_Operation_CreateAndRead = 2
    ZXing_Operation_CreateOrRead = 3
end

function ZXing_SupportedBarcodeFormats(op)
    @ccall libZXing.ZXing_SupportedBarcodeFormats(op::ZXing_Operation)::ZXing_BarcodeFormats
end

@cenum ZXing_ContentType::UInt32 begin
    ZXing_ContentType_Text = 0
    ZXing_ContentType_Binary = 1
    ZXing_ContentType_Mixed = 2
    ZXing_ContentType_GS1 = 3
    ZXing_ContentType_ISO15434 = 4
    ZXing_ContentType_UnknownECI = 5
end

@cenum ZXing_ErrorType::UInt32 begin
    ZXing_ErrorType_None = 0
    ZXing_ErrorType_Format = 1
    ZXing_ErrorType_Checksum = 2
    ZXing_ErrorType_Unsupported = 3
end

function ZXing_ContentTypeToString(type)
    @ccall libZXing.ZXing_ContentTypeToString(type::ZXing_ContentType)::Cstring
end

struct ZXing_PointI
    x::Cint
    y::Cint
end

struct ZXing_Position
    topLeft::ZXing_PointI
    topRight::ZXing_PointI
    bottomRight::ZXing_PointI
    bottomLeft::ZXing_PointI
end

function ZXing_PositionToString(position)
    @ccall libZXing.ZXing_PositionToString(position::ZXing_Position)::Cstring
end

function ZXing_Barcode_isValid(barcode)
    @ccall libZXing.ZXing_Barcode_isValid(barcode::Ptr{ZXing_Barcode})::Bool
end

function ZXing_Barcode_errorType(barcode)
    @ccall libZXing.ZXing_Barcode_errorType(barcode::Ptr{ZXing_Barcode})::ZXing_ErrorType
end

function ZXing_Barcode_errorMsg(barcode)
    @ccall libZXing.ZXing_Barcode_errorMsg(barcode::Ptr{ZXing_Barcode})::Cstring
end

function ZXing_Barcode_format(barcode)
    @ccall libZXing.ZXing_Barcode_format(barcode::Ptr{ZXing_Barcode})::ZXing_BarcodeFormat
end

function ZXing_Barcode_contentType(barcode)
    @ccall libZXing.ZXing_Barcode_contentType(barcode::Ptr{ZXing_Barcode})::ZXing_ContentType
end

function ZXing_Barcode_bytes(barcode, len)
    @ccall libZXing.ZXing_Barcode_bytes(
        barcode::Ptr{ZXing_Barcode}, len::Ptr{Cint})::Ptr{UInt8}
end

function ZXing_Barcode_bytesECI(barcode, len)
    @ccall libZXing.ZXing_Barcode_bytesECI(
        barcode::Ptr{ZXing_Barcode}, len::Ptr{Cint})::Ptr{UInt8}
end

function ZXing_Barcode_text(barcode)
    @ccall libZXing.ZXing_Barcode_text(barcode::Ptr{ZXing_Barcode})::Cstring
end

function ZXing_Barcode_ecLevel(barcode)
    @ccall libZXing.ZXing_Barcode_ecLevel(barcode::Ptr{ZXing_Barcode})::Cstring
end

function ZXing_Barcode_symbologyIdentifier(barcode)
    @ccall libZXing.ZXing_Barcode_symbologyIdentifier(barcode::Ptr{ZXing_Barcode})::Cstring
end

function ZXing_Barcode_position(barcode)
    @ccall libZXing.ZXing_Barcode_position(barcode::Ptr{ZXing_Barcode})::ZXing_Position
end

function ZXing_Barcode_orientation(barcode)
    @ccall libZXing.ZXing_Barcode_orientation(barcode::Ptr{ZXing_Barcode})::Cint
end

function ZXing_Barcode_hasECI(barcode)
    @ccall libZXing.ZXing_Barcode_hasECI(barcode::Ptr{ZXing_Barcode})::Bool
end

function ZXing_Barcode_isInverted(barcode)
    @ccall libZXing.ZXing_Barcode_isInverted(barcode::Ptr{ZXing_Barcode})::Bool
end

function ZXing_Barcode_isMirrored(barcode)
    @ccall libZXing.ZXing_Barcode_isMirrored(barcode::Ptr{ZXing_Barcode})::Bool
end

function ZXing_Barcode_lineCount(barcode)
    @ccall libZXing.ZXing_Barcode_lineCount(barcode::Ptr{ZXing_Barcode})::Cint
end

function ZXing_Barcode_delete(barcode)
    @ccall libZXing.ZXing_Barcode_delete(barcode::Ptr{ZXing_Barcode})::Cvoid
end

function ZXing_Barcodes_delete(barcodes)
    @ccall libZXing.ZXing_Barcodes_delete(barcodes::Ptr{ZXing_Barcodes})::Cvoid
end

function ZXing_Barcodes_size(barcodes)
    @ccall libZXing.ZXing_Barcodes_size(barcodes::Ptr{ZXing_Barcodes})::Cint
end

function ZXing_Barcodes_at(barcodes, i)
    @ccall libZXing.ZXing_Barcodes_at(
        barcodes::Ptr{ZXing_Barcodes}, i::Cint)::Ptr{ZXing_Barcode}
end

function ZXing_Barcodes_move(barcodes, i)
    @ccall libZXing.ZXing_Barcodes_move(
        barcodes::Ptr{ZXing_Barcodes}, i::Cint)::Ptr{ZXing_Barcode}
end

@cenum ZXing_Binarizer::UInt32 begin
    ZXing_Binarizer_LocalAverage = 0
    ZXing_Binarizer_GlobalHistogram = 1
    ZXing_Binarizer_FixedThreshold = 2
    ZXing_Binarizer_BoolCast = 3
end

@cenum ZXing_EanAddOnSymbol::UInt32 begin
    ZXing_EanAddOnSymbol_Ignore = 0
    ZXing_EanAddOnSymbol_Read = 1
    ZXing_EanAddOnSymbol_Require = 2
end

@cenum ZXing_TextMode::UInt32 begin
    ZXing_TextMode_Plain = 0
    ZXing_TextMode_ECI = 1
    ZXing_TextMode_HRI = 2
    ZXing_TextMode_Hex = 3
    ZXing_TextMode_Escaped = 4
end

# no prototype is found for this function at ZXingC.h:226:22, please use with caution
function ZXing_ReaderOptions_new()
    @ccall libZXing.ZXing_ReaderOptions_new()::Ptr{ZXing_ReaderOptions}
end

function ZXing_ReaderOptions_delete(opts)
    @ccall libZXing.ZXing_ReaderOptions_delete(opts::Ptr{ZXing_ReaderOptions})::Cvoid
end

function ZXing_ReaderOptions_setTryHarder(opts, tryHarder)
    @ccall libZXing.ZXing_ReaderOptions_setTryHarder(
        opts::Ptr{ZXing_ReaderOptions}, tryHarder::Bool)::Cvoid
end

function ZXing_ReaderOptions_setTryRotate(opts, tryRotate)
    @ccall libZXing.ZXing_ReaderOptions_setTryRotate(
        opts::Ptr{ZXing_ReaderOptions}, tryRotate::Bool)::Cvoid
end

function ZXing_ReaderOptions_setTryInvert(opts, tryInvert)
    @ccall libZXing.ZXing_ReaderOptions_setTryInvert(
        opts::Ptr{ZXing_ReaderOptions}, tryInvert::Bool)::Cvoid
end

function ZXing_ReaderOptions_setTryDownscale(opts, tryDownscale)
    @ccall libZXing.ZXing_ReaderOptions_setTryDownscale(
        opts::Ptr{ZXing_ReaderOptions}, tryDownscale::Bool)::Cvoid
end

function ZXing_ReaderOptions_setIsPure(opts, isPure)
    @ccall libZXing.ZXing_ReaderOptions_setIsPure(
        opts::Ptr{ZXing_ReaderOptions}, isPure::Bool)::Cvoid
end

function ZXing_ReaderOptions_setReturnErrors(opts, returnErrors)
    @ccall libZXing.ZXing_ReaderOptions_setReturnErrors(
        opts::Ptr{ZXing_ReaderOptions}, returnErrors::Bool)::Cvoid
end

function ZXing_ReaderOptions_setFormats(opts, formats)
    @ccall libZXing.ZXing_ReaderOptions_setFormats(
        opts::Ptr{ZXing_ReaderOptions}, formats::ZXing_BarcodeFormats)::Cvoid
end

function ZXing_ReaderOptions_setBinarizer(opts, binarizer)
    @ccall libZXing.ZXing_ReaderOptions_setBinarizer(
        opts::Ptr{ZXing_ReaderOptions}, binarizer::ZXing_Binarizer)::Cvoid
end

function ZXing_ReaderOptions_setEanAddOnSymbol(opts, eanAddOnSymbol)
    @ccall libZXing.ZXing_ReaderOptions_setEanAddOnSymbol(
        opts::Ptr{ZXing_ReaderOptions}, eanAddOnSymbol::ZXing_EanAddOnSymbol)::Cvoid
end

function ZXing_ReaderOptions_setTextMode(opts, textMode)
    @ccall libZXing.ZXing_ReaderOptions_setTextMode(
        opts::Ptr{ZXing_ReaderOptions}, textMode::ZXing_TextMode)::Cvoid
end

function ZXing_ReaderOptions_setMinLineCount(opts, n)
    @ccall libZXing.ZXing_ReaderOptions_setMinLineCount(
        opts::Ptr{ZXing_ReaderOptions}, n::Cint)::Cvoid
end

function ZXing_ReaderOptions_setMaxNumberOfSymbols(opts, n)
    @ccall libZXing.ZXing_ReaderOptions_setMaxNumberOfSymbols(
        opts::Ptr{ZXing_ReaderOptions}, n::Cint)::Cvoid
end

function ZXing_ReaderOptions_getTryHarder(opts)
    @ccall libZXing.ZXing_ReaderOptions_getTryHarder(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getTryRotate(opts)
    @ccall libZXing.ZXing_ReaderOptions_getTryRotate(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getTryInvert(opts)
    @ccall libZXing.ZXing_ReaderOptions_getTryInvert(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getTryDownscale(opts)
    @ccall libZXing.ZXing_ReaderOptions_getTryDownscale(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getIsPure(opts)
    @ccall libZXing.ZXing_ReaderOptions_getIsPure(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getReturnErrors(opts)
    @ccall libZXing.ZXing_ReaderOptions_getReturnErrors(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getFormats(opts)
    @ccall libZXing.ZXing_ReaderOptions_getFormats(opts::Ptr{ZXing_ReaderOptions})::ZXing_BarcodeFormats
end

function ZXing_ReaderOptions_getBinarizer(opts)
    @ccall libZXing.ZXing_ReaderOptions_getBinarizer(opts::Ptr{ZXing_ReaderOptions})::ZXing_Binarizer
end

function ZXing_ReaderOptions_getEanAddOnSymbol(opts)
    @ccall libZXing.ZXing_ReaderOptions_getEanAddOnSymbol(opts::Ptr{ZXing_ReaderOptions})::ZXing_EanAddOnSymbol
end

function ZXing_ReaderOptions_getTextMode(opts)
    @ccall libZXing.ZXing_ReaderOptions_getTextMode(opts::Ptr{ZXing_ReaderOptions})::ZXing_TextMode
end

function ZXing_ReaderOptions_getMinLineCount(opts)
    @ccall libZXing.ZXing_ReaderOptions_getMinLineCount(opts::Ptr{ZXing_ReaderOptions})::Cint
end

function ZXing_ReaderOptions_getMaxNumberOfSymbols(opts)
    @ccall libZXing.ZXing_ReaderOptions_getMaxNumberOfSymbols(opts::Ptr{ZXing_ReaderOptions})::Cint
end

"""
    ZXing_ReadBarcodes(iv, opts)

Note: opts is optional, i.e. it can be NULL, which will imply default settings.
"""
function ZXing_ReadBarcodes(iv, opts)
    @ccall libZXing.ZXing_ReadBarcodes(
        iv::Ptr{ZXing_ImageView}, opts::Ptr{ZXing_ReaderOptions})::Ptr{ZXing_Barcodes}
end

function ZXing_CreatorOptions_new(format)
    @ccall libZXing.ZXing_CreatorOptions_new(format::ZXing_BarcodeFormat)::Ptr{ZXing_CreatorOptions}
end

function ZXing_CreatorOptions_delete(opts)
    @ccall libZXing.ZXing_CreatorOptions_delete(opts::Ptr{ZXing_CreatorOptions})::Cvoid
end

function ZXing_CreatorOptions_setFormat(opts, format)
    @ccall libZXing.ZXing_CreatorOptions_setFormat(
        opts::Ptr{ZXing_CreatorOptions}, format::ZXing_BarcodeFormat)::Cvoid
end

function ZXing_CreatorOptions_getFormat(opts)
    @ccall libZXing.ZXing_CreatorOptions_getFormat(opts::Ptr{ZXing_CreatorOptions})::ZXing_BarcodeFormat
end

function ZXing_CreatorOptions_setReaderInit(opts, readerInit)
    @ccall libZXing.ZXing_CreatorOptions_setReaderInit(
        opts::Ptr{ZXing_CreatorOptions}, readerInit::Bool)::Cvoid
end

function ZXing_CreatorOptions_getReaderInit(opts)
    @ccall libZXing.ZXing_CreatorOptions_getReaderInit(opts::Ptr{ZXing_CreatorOptions})::Bool
end

function ZXing_CreatorOptions_setForceSquareDataMatrix(opts, forceSquareDataMatrix)
    @ccall libZXing.ZXing_CreatorOptions_setForceSquareDataMatrix(
        opts::Ptr{ZXing_CreatorOptions}, forceSquareDataMatrix::Bool)::Cvoid
end

function ZXing_CreatorOptions_getForceSquareDataMatrix(opts)
    @ccall libZXing.ZXing_CreatorOptions_getForceSquareDataMatrix(opts::Ptr{ZXing_CreatorOptions})::Bool
end

function ZXing_CreatorOptions_setEcLevel(opts, ecLevel)
    @ccall libZXing.ZXing_CreatorOptions_setEcLevel(
        opts::Ptr{ZXing_CreatorOptions}, ecLevel::Cstring)::Cvoid
end

function ZXing_CreatorOptions_getEcLevel(opts)
    @ccall libZXing.ZXing_CreatorOptions_getEcLevel(opts::Ptr{ZXing_CreatorOptions})::Cstring
end

# no prototype is found for this function at ZXingC.h:284:22, please use with caution
function ZXing_WriterOptions_new()
    @ccall libZXing.ZXing_WriterOptions_new()::Ptr{ZXing_WriterOptions}
end

function ZXing_WriterOptions_delete(opts)
    @ccall libZXing.ZXing_WriterOptions_delete(opts::Ptr{ZXing_WriterOptions})::Cvoid
end

function ZXing_WriterOptions_setScale(opts, scale)
    @ccall libZXing.ZXing_WriterOptions_setScale(
        opts::Ptr{ZXing_WriterOptions}, scale::Cint)::Cvoid
end

function ZXing_WriterOptions_getScale(opts)
    @ccall libZXing.ZXing_WriterOptions_getScale(opts::Ptr{ZXing_WriterOptions})::Cint
end

function ZXing_WriterOptions_setSizeHint(opts, sizeHint)
    @ccall libZXing.ZXing_WriterOptions_setSizeHint(
        opts::Ptr{ZXing_WriterOptions}, sizeHint::Cint)::Cvoid
end

function ZXing_WriterOptions_getSizeHint(opts)
    @ccall libZXing.ZXing_WriterOptions_getSizeHint(opts::Ptr{ZXing_WriterOptions})::Cint
end

function ZXing_WriterOptions_setRotate(opts, rotate)
    @ccall libZXing.ZXing_WriterOptions_setRotate(
        opts::Ptr{ZXing_WriterOptions}, rotate::Cint)::Cvoid
end

function ZXing_WriterOptions_getRotate(opts)
    @ccall libZXing.ZXing_WriterOptions_getRotate(opts::Ptr{ZXing_WriterOptions})::Cint
end

function ZXing_WriterOptions_setWithHRT(opts, withHRT)
    @ccall libZXing.ZXing_WriterOptions_setWithHRT(
        opts::Ptr{ZXing_WriterOptions}, withHRT::Bool)::Cvoid
end

function ZXing_WriterOptions_getWithHRT(opts)
    @ccall libZXing.ZXing_WriterOptions_getWithHRT(opts::Ptr{ZXing_WriterOptions})::Bool
end

function ZXing_WriterOptions_setWithQuietZones(opts, withQuietZones)
    @ccall libZXing.ZXing_WriterOptions_setWithQuietZones(
        opts::Ptr{ZXing_WriterOptions}, withQuietZones::Bool)::Cvoid
end

function ZXing_WriterOptions_getWithQuietZones(opts)
    @ccall libZXing.ZXing_WriterOptions_getWithQuietZones(opts::Ptr{ZXing_WriterOptions})::Bool
end

function ZXing_CreateBarcodeFromText(data, size, opts)
    @ccall libZXing.ZXing_CreateBarcodeFromText(
        data::Cstring, size::Cint, opts::Ptr{ZXing_CreatorOptions})::Ptr{ZXing_Barcode}
end

function ZXing_CreateBarcodeFromBytes(data, size, opts)
    @ccall libZXing.ZXing_CreateBarcodeFromBytes(
        data::Ptr{Cvoid}, size::Cint, opts::Ptr{ZXing_CreatorOptions})::Ptr{ZXing_Barcode}
end

"""
    ZXing_WriteBarcodeToSVG(barcode, opts)

Note: opts is optional, i.e. it can be NULL, which will imply default settings.
"""
function ZXing_WriteBarcodeToSVG(barcode, opts)
    @ccall libZXing.ZXing_WriteBarcodeToSVG(
        barcode::Ptr{ZXing_Barcode}, opts::Ptr{ZXing_WriterOptions})::Cstring
end

function ZXing_WriteBarcodeToImage(barcode, opts)
    @ccall libZXing.ZXing_WriteBarcodeToImage(
        barcode::Ptr{ZXing_Barcode}, opts::Ptr{ZXing_WriterOptions})::Ptr{ZXing_Image}
end

# no prototype is found for this function at ZXingC.h:313:7, please use with caution
function ZXing_LastErrorMsg()
    @ccall libZXing.ZXing_LastErrorMsg()::Cstring
end

# no prototype is found for this function at ZXingC.h:315:13, please use with caution
function ZXing_Version()
    @ccall libZXing.ZXing_Version()::Cstring
end

function ZXing_free(ptr)
    @ccall libZXing.ZXing_free(ptr::Ptr{Cvoid})::Cvoid
end

# exports
const PREFIXES = ["ZXing_"]
for name in names(@__MODULE__; all = true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
