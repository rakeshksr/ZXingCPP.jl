@testset "Creator Options" begin
    co = CreatorOptions(ZXing_BarcodeFormat_QRCode)
    @test get_options(co) == ""
    set_options!(co, "version:1")
    @test get_options(co) == "version:1"
    @test get_format(co) == ZXing_BarcodeFormat_QRCode
    set_format!(co, ZXing_BarcodeFormat_MicroQRCode)
    @test get_format(co) == ZXing_BarcodeFormat_MicroQRCode

end

@testset "Creator String" begin
    str = "123456"
    bc = Barcode(str, CreatorOptions(ZXing_BarcodeFormat_QRCode; options="ec_level:Q"))
    @test is_valid(bc) == true
    @test format(bc) == ZXing_BarcodeFormat_QRCode
    @test text(bc) == str
    @test bytes(bc) == codeunits(str)
    @test has_eci(bc) == false
    @test content_type(bc) == ZXing_ContentType_Text
    @test error_type(bc) == ZXing_ErrorType_None
end

@testset "Creator Data" begin
    co = CreatorOptions(ZXing_BarcodeFormat_PDF417)
    data = UInt8[1, 2, 3, 4, 5]
    bc = Barcode(data, co)

    @test is_valid(bc) == true
    @test format(bc) == ZXing_BarcodeFormat_PDF417
    @test bytes(bc) == data
    @test has_eci(bc) == true
    @test content_type(bc) == ZXing_ContentType_Binary
    @test error_type(bc) == ZXing_ErrorType_None
end
