module libZXingCpp

using ZXing_CPP_jll
export ZXing_CPP_jll

using CEnum: CEnum, @cenum

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
    @ccall libZXing.ZXing_ImageView_new(data::Ptr{UInt8}, width::Cint, height::Cint, format::ZXing_ImageFormat, rowStride::Cint, pixStride::Cint)::Ptr{ZXing_ImageView}
end

function ZXing_ImageView_new_checked(data, size, width, height, format, rowStride, pixStride)
    @ccall libZXing.ZXing_ImageView_new_checked(data::Ptr{UInt8}, size::Cint, width::Cint, height::Cint, format::ZXing_ImageFormat, rowStride::Cint, pixStride::Cint)::Ptr{ZXing_ImageView}
end

function ZXing_ImageView_delete(iv)
    @ccall libZXing.ZXing_ImageView_delete(iv::Ptr{ZXing_ImageView})::Cvoid
end

function ZXing_ImageView_crop(iv, left, top, width, height)
    @ccall libZXing.ZXing_ImageView_crop(iv::Ptr{ZXing_ImageView}, left::Cint, top::Cint, width::Cint, height::Cint)::Cvoid
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
    ZXing_BarcodeFormat_Invalid = 65535
    ZXing_BarcodeFormat_None = 0
    ZXing_BarcodeFormat_All = 10794
    ZXing_BarcodeFormat_AllReadable = 29226
    ZXing_BarcodeFormat_AllCreatable = 30506
    ZXing_BarcodeFormat_AllLinear = 27690
    ZXing_BarcodeFormat_AllMatrix = 27946
    ZXing_BarcodeFormat_AllGS1 = 18218
    ZXing_BarcodeFormat_AllRetail = 21034
    ZXing_BarcodeFormat_AllIndustrial = 18730
    ZXing_BarcodeFormat_Codabar = 8262
    ZXing_BarcodeFormat_Code39 = 8257
    ZXing_BarcodeFormat_Code39Std = 29505
    ZXing_BarcodeFormat_Code39Ext = 25921
    ZXing_BarcodeFormat_Code32 = 12865
    ZXing_BarcodeFormat_PZN = 28737
    ZXing_BarcodeFormat_Code93 = 8263
    ZXing_BarcodeFormat_Code128 = 8259
    ZXing_BarcodeFormat_ITF = 8265
    ZXing_BarcodeFormat_ITF14 = 13385
    ZXing_BarcodeFormat_DataBar = 8293
    ZXing_BarcodeFormat_DataBarOmni = 28517
    ZXing_BarcodeFormat_DataBarStk = 29541
    ZXing_BarcodeFormat_DataBarStkOmni = 20325
    ZXing_BarcodeFormat_DataBarLtd = 27749
    ZXing_BarcodeFormat_DataBarExp = 25957
    ZXing_BarcodeFormat_DataBarExpStk = 17765
    ZXing_BarcodeFormat_EANUPC = 8261
    ZXing_BarcodeFormat_EAN13 = 12613
    ZXing_BarcodeFormat_EAN8 = 14405
    ZXing_BarcodeFormat_EAN5 = 13637
    ZXing_BarcodeFormat_EAN2 = 12869
    ZXing_BarcodeFormat_ISBN = 26949
    ZXing_BarcodeFormat_UPCA = 24901
    ZXing_BarcodeFormat_UPCE = 25925
    ZXing_BarcodeFormat_Telepen = 8258
    ZXing_BarcodeFormat_TelepenAlpha = 12354
    ZXing_BarcodeFormat_TelepenNumeric = 12610
    ZXing_BarcodeFormat_OtherBarcode = 8280
    ZXing_BarcodeFormat_DXFilmEdge = 30808
    ZXing_BarcodeFormat_PDF417 = 8268
    ZXing_BarcodeFormat_CompactPDF417 = 25420
    ZXing_BarcodeFormat_MicroPDF417 = 27980
    ZXing_BarcodeFormat_Aztec = 8314
    ZXing_BarcodeFormat_AztecCode = 25466
    ZXing_BarcodeFormat_AztecRune = 29306
    ZXing_BarcodeFormat_QRCode = 8273
    ZXing_BarcodeFormat_QRCodeModel1 = 12625
    ZXing_BarcodeFormat_QRCodeModel2 = 12881
    ZXing_BarcodeFormat_MicroQRCode = 27985
    ZXing_BarcodeFormat_RMQRCode = 29265
    ZXing_BarcodeFormat_DataMatrix = 8292
    ZXing_BarcodeFormat_MaxiCode = 8277
end

function ZXing_BarcodeFormatSymbology(format)
    @ccall libZXing.ZXing_BarcodeFormatSymbology(format::ZXing_BarcodeFormat)::ZXing_BarcodeFormat
end

function ZXing_BarcodeFormatFromString(str)
    @ccall libZXing.ZXing_BarcodeFormatFromString(str::Cstring)::ZXing_BarcodeFormat
end

function ZXing_BarcodeFormatToString(format)
    @ccall libZXing.ZXing_BarcodeFormatToString(format::ZXing_BarcodeFormat)::Cstring
end

function ZXing_BarcodeFormatsList(filter, outCount)
    @ccall libZXing.ZXing_BarcodeFormatsList(filter::ZXing_BarcodeFormat, outCount::Ptr{Cint})::Ptr{ZXing_BarcodeFormat}
end

function ZXing_BarcodeFormatsFromString(str, outCount)
    @ccall libZXing.ZXing_BarcodeFormatsFromString(str::Cstring, outCount::Ptr{Cint})::Ptr{ZXing_BarcodeFormat}
end

function ZXing_BarcodeFormatsToString(formats, count)
    @ccall libZXing.ZXing_BarcodeFormatsToString(formats::Ptr{ZXing_BarcodeFormat}, count::Cint)::Cstring
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

function ZXing_Barcode_symbology(barcode)
    @ccall libZXing.ZXing_Barcode_symbology(barcode::Ptr{ZXing_Barcode})::ZXing_BarcodeFormat
end

function ZXing_Barcode_contentType(barcode)
    @ccall libZXing.ZXing_Barcode_contentType(barcode::Ptr{ZXing_Barcode})::ZXing_ContentType
end

function ZXing_Barcode_bytes(barcode, len)
    @ccall libZXing.ZXing_Barcode_bytes(barcode::Ptr{ZXing_Barcode}, len::Ptr{Cint})::Ptr{UInt8}
end

function ZXing_Barcode_bytesECI(barcode, len)
    @ccall libZXing.ZXing_Barcode_bytesECI(barcode::Ptr{ZXing_Barcode}, len::Ptr{Cint})::Ptr{UInt8}
end

function ZXing_Barcode_text(barcode)
    @ccall libZXing.ZXing_Barcode_text(barcode::Ptr{ZXing_Barcode})::Cstring
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

function ZXing_Barcode_sequenceIndex(barcode)
    @ccall libZXing.ZXing_Barcode_sequenceIndex(barcode::Ptr{ZXing_Barcode})::Cint
end

function ZXing_Barcode_sequenceSize(barcode)
    @ccall libZXing.ZXing_Barcode_sequenceSize(barcode::Ptr{ZXing_Barcode})::Cint
end

function ZXing_Barcode_sequenceId(barcode)
    @ccall libZXing.ZXing_Barcode_sequenceId(barcode::Ptr{ZXing_Barcode})::Cstring
end

function ZXing_Barcode_extra(barcode, key)
    @ccall libZXing.ZXing_Barcode_extra(barcode::Ptr{ZXing_Barcode}, key::Cstring)::Cstring
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
    @ccall libZXing.ZXing_Barcodes_at(barcodes::Ptr{ZXing_Barcodes}, i::Cint)::Ptr{ZXing_Barcode}
end

function ZXing_Barcodes_move(barcodes, i)
    @ccall libZXing.ZXing_Barcodes_move(barcodes::Ptr{ZXing_Barcodes}, i::Cint)::Ptr{ZXing_Barcode}
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
    ZXing_TextMode_Escaped = 3
    ZXing_TextMode_Hex = 4
    ZXing_TextMode_HexECI = 5
end

# no prototype is found for this function at ZXingC.h:196:22, please use with caution
function ZXing_ReaderOptions_new()
    @ccall libZXing.ZXing_ReaderOptions_new()::Ptr{ZXing_ReaderOptions}
end

function ZXing_ReaderOptions_delete(opts)
    @ccall libZXing.ZXing_ReaderOptions_delete(opts::Ptr{ZXing_ReaderOptions})::Cvoid
end

function ZXing_ReaderOptions_setTryHarder(opts, tryHarder)
    @ccall libZXing.ZXing_ReaderOptions_setTryHarder(opts::Ptr{ZXing_ReaderOptions}, tryHarder::Bool)::Cvoid
end

function ZXing_ReaderOptions_setTryRotate(opts, tryRotate)
    @ccall libZXing.ZXing_ReaderOptions_setTryRotate(opts::Ptr{ZXing_ReaderOptions}, tryRotate::Bool)::Cvoid
end

function ZXing_ReaderOptions_setTryInvert(opts, tryInvert)
    @ccall libZXing.ZXing_ReaderOptions_setTryInvert(opts::Ptr{ZXing_ReaderOptions}, tryInvert::Bool)::Cvoid
end

function ZXing_ReaderOptions_setTryDownscale(opts, tryDownscale)
    @ccall libZXing.ZXing_ReaderOptions_setTryDownscale(opts::Ptr{ZXing_ReaderOptions}, tryDownscale::Bool)::Cvoid
end

function ZXing_ReaderOptions_setIsPure(opts, isPure)
    @ccall libZXing.ZXing_ReaderOptions_setIsPure(opts::Ptr{ZXing_ReaderOptions}, isPure::Bool)::Cvoid
end

function ZXing_ReaderOptions_setValidateOptionalChecksum(opts, validateOptionalChecksum)
    @ccall libZXing.ZXing_ReaderOptions_setValidateOptionalChecksum(opts::Ptr{ZXing_ReaderOptions}, validateOptionalChecksum::Bool)::Cvoid
end

function ZXing_ReaderOptions_setReturnErrors(opts, returnErrors)
    @ccall libZXing.ZXing_ReaderOptions_setReturnErrors(opts::Ptr{ZXing_ReaderOptions}, returnErrors::Bool)::Cvoid
end

function ZXing_ReaderOptions_setFormats(opts, formats, count)
    @ccall libZXing.ZXing_ReaderOptions_setFormats(opts::Ptr{ZXing_ReaderOptions}, formats::Ptr{ZXing_BarcodeFormat}, count::Cint)::Cvoid
end

function ZXing_ReaderOptions_setBinarizer(opts, binarizer)
    @ccall libZXing.ZXing_ReaderOptions_setBinarizer(opts::Ptr{ZXing_ReaderOptions}, binarizer::ZXing_Binarizer)::Cvoid
end

function ZXing_ReaderOptions_setEanAddOnSymbol(opts, eanAddOnSymbol)
    @ccall libZXing.ZXing_ReaderOptions_setEanAddOnSymbol(opts::Ptr{ZXing_ReaderOptions}, eanAddOnSymbol::ZXing_EanAddOnSymbol)::Cvoid
end

function ZXing_ReaderOptions_setTextMode(opts, textMode)
    @ccall libZXing.ZXing_ReaderOptions_setTextMode(opts::Ptr{ZXing_ReaderOptions}, textMode::ZXing_TextMode)::Cvoid
end

function ZXing_ReaderOptions_setMinLineCount(opts, n)
    @ccall libZXing.ZXing_ReaderOptions_setMinLineCount(opts::Ptr{ZXing_ReaderOptions}, n::Cint)::Cvoid
end

function ZXing_ReaderOptions_setMaxNumberOfSymbols(opts, n)
    @ccall libZXing.ZXing_ReaderOptions_setMaxNumberOfSymbols(opts::Ptr{ZXing_ReaderOptions}, n::Cint)::Cvoid
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

function ZXing_ReaderOptions_getValidateOptionalChecksum(opts)
    @ccall libZXing.ZXing_ReaderOptions_getValidateOptionalChecksum(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getReturnErrors(opts)
    @ccall libZXing.ZXing_ReaderOptions_getReturnErrors(opts::Ptr{ZXing_ReaderOptions})::Bool
end

function ZXing_ReaderOptions_getFormats(opts, outCount)
    @ccall libZXing.ZXing_ReaderOptions_getFormats(opts::Ptr{ZXing_ReaderOptions}, outCount::Ptr{Cint})::Ptr{ZXing_BarcodeFormat}
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

# Returns
NULL in case of an error (e.g. invalid image or out of memory), otherwise a pointer to a [`ZXing_Barcodes`](@ref) object, which may contain zero or more barcodes. Freeing the empty [`ZXing_Barcodes`](@ref) object is optional.
"""
function ZXing_ReadBarcodes(iv, opts)
    @ccall libZXing.ZXing_ReadBarcodes(iv::Ptr{ZXing_ImageView}, opts::Ptr{ZXing_ReaderOptions})::Ptr{ZXing_Barcodes}
end

function ZXing_CreatorOptions_new(format)
    @ccall libZXing.ZXing_CreatorOptions_new(format::ZXing_BarcodeFormat)::Ptr{ZXing_CreatorOptions}
end

function ZXing_CreatorOptions_delete(opts)
    @ccall libZXing.ZXing_CreatorOptions_delete(opts::Ptr{ZXing_CreatorOptions})::Cvoid
end

function ZXing_CreatorOptions_setFormat(opts, format)
    @ccall libZXing.ZXing_CreatorOptions_setFormat(opts::Ptr{ZXing_CreatorOptions}, format::ZXing_BarcodeFormat)::Cvoid
end

function ZXing_CreatorOptions_getFormat(opts)
    @ccall libZXing.ZXing_CreatorOptions_getFormat(opts::Ptr{ZXing_CreatorOptions})::ZXing_BarcodeFormat
end

function ZXing_CreatorOptions_setOptions(opts, options)
    @ccall libZXing.ZXing_CreatorOptions_setOptions(opts::Ptr{ZXing_CreatorOptions}, options::Cstring)::Cvoid
end

function ZXing_CreatorOptions_getOptions(opts)
    @ccall libZXing.ZXing_CreatorOptions_getOptions(opts::Ptr{ZXing_CreatorOptions})::Cstring
end

function ZXing_CreateBarcodeFromText(data, size, opts)
    @ccall libZXing.ZXing_CreateBarcodeFromText(data::Cstring, size::Cint, opts::Ptr{ZXing_CreatorOptions})::Ptr{ZXing_Barcode}
end

function ZXing_CreateBarcodeFromBytes(data, size, opts)
    @ccall libZXing.ZXing_CreateBarcodeFromBytes(data::Ptr{Cvoid}, size::Cint, opts::Ptr{ZXing_CreatorOptions})::Ptr{ZXing_Barcode}
end

# no prototype is found for this function at ZXingC.h:264:22, please use with caution
function ZXing_WriterOptions_new()
    @ccall libZXing.ZXing_WriterOptions_new()::Ptr{ZXing_WriterOptions}
end

function ZXing_WriterOptions_delete(opts)
    @ccall libZXing.ZXing_WriterOptions_delete(opts::Ptr{ZXing_WriterOptions})::Cvoid
end

function ZXing_WriterOptions_setScale(opts, scale)
    @ccall libZXing.ZXing_WriterOptions_setScale(opts::Ptr{ZXing_WriterOptions}, scale::Cint)::Cvoid
end

function ZXing_WriterOptions_getScale(opts)
    @ccall libZXing.ZXing_WriterOptions_getScale(opts::Ptr{ZXing_WriterOptions})::Cint
end

function ZXing_WriterOptions_setRotate(opts, rotate)
    @ccall libZXing.ZXing_WriterOptions_setRotate(opts::Ptr{ZXing_WriterOptions}, rotate::Cint)::Cvoid
end

function ZXing_WriterOptions_getRotate(opts)
    @ccall libZXing.ZXing_WriterOptions_getRotate(opts::Ptr{ZXing_WriterOptions})::Cint
end

function ZXing_WriterOptions_setAddHRT(opts, addHRT)
    @ccall libZXing.ZXing_WriterOptions_setAddHRT(opts::Ptr{ZXing_WriterOptions}, addHRT::Bool)::Cvoid
end

function ZXing_WriterOptions_getAddHRT(opts)
    @ccall libZXing.ZXing_WriterOptions_getAddHRT(opts::Ptr{ZXing_WriterOptions})::Bool
end

function ZXing_WriterOptions_setAddQuietZones(opts, addQuietZones)
    @ccall libZXing.ZXing_WriterOptions_setAddQuietZones(opts::Ptr{ZXing_WriterOptions}, addQuietZones::Bool)::Cvoid
end

function ZXing_WriterOptions_getAddQuietZones(opts)
    @ccall libZXing.ZXing_WriterOptions_getAddQuietZones(opts::Ptr{ZXing_WriterOptions})::Bool
end

"""
    ZXing_WriteBarcodeToSVG(barcode, opts)

Note: opts is optional, i.e. it can be NULL, which will imply default settings.
"""
function ZXing_WriteBarcodeToSVG(barcode, opts)
    @ccall libZXing.ZXing_WriteBarcodeToSVG(barcode::Ptr{ZXing_Barcode}, opts::Ptr{ZXing_WriterOptions})::Cstring
end

function ZXing_WriteBarcodeToImage(barcode, opts)
    @ccall libZXing.ZXing_WriteBarcodeToImage(barcode::Ptr{ZXing_Barcode}, opts::Ptr{ZXing_WriterOptions})::Ptr{ZXing_Image}
end

# no prototype is found for this function at ZXingC.h:286:7, please use with caution
function ZXing_LastErrorMsg()
    @ccall libZXing.ZXing_LastErrorMsg()::Cstring
end

# no prototype is found for this function at ZXingC.h:288:13, please use with caution
function ZXing_Version()
    @ccall libZXing.ZXing_Version()::Cstring
end

function ZXing_free(ptr)
    @ccall libZXing.ZXing_free(ptr::Ptr{Cvoid})::Cvoid
end

const ZXING_ENABLE_1D = 1

const ZXING_ENABLE_AZTEC = 1

const ZXING_ENABLE_DATAMATRIX = 1

const ZXING_ENABLE_MAXICODE = 1

const ZXING_ENABLE_PDF417 = 1

const ZXING_ENABLE_QRCODE = 1

const ZXING_VERSION_MAJOR = 3

const ZXING_VERSION_MINOR = 1

const ZXING_VERSION_PATCH = 0

const ZXING_VERSION_SUFFIX = ""

const ZXING_VERSION_STR = "3.1.0"

# Skipping MacroDefinition: X ( NAME , SYM , VAR , FLAGS , ZINT , ENABLED , HRI ) ZXing_BarcodeFormat_ ## NAME = ZX_BCF_ID ( SYM , VAR ) ,

# exports
const PREFIXES = ["ZXing_"]
for name in names(@__MODULE__; all=true), prefix in PREFIXES
    if startswith(string(name), prefix)
        @eval export $name
    end
end

end # module
