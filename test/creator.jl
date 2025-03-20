@testset "Creator Options" begin
    co1 = CreatorOptions(ZXing_BarcodeFormat_QRCode)
    @test get_reader_init(co1) == false
    set_reader_init!(co1, true)
    @test get_reader_init(co1) == true

    str = "123456"
    bc1 = Barcode(str, CreatorOptions(ZXing_BarcodeFormat_QRCode; ec_level = "Q"))
    @test is_valid(bc1) == true
    @test format(bc1) == ZXing_BarcodeFormat_QRCode
    @test text(bc1) == str
    @test bytes(bc1) == codeunits(str)
    @test has_eci(bc1) == false
    @test content_type(bc1) == ZXing_ContentType_Text
    @test error_type(bc1) == ZXing_ErrorType_None

    co2 = CreatorOptions(ZXing_BarcodeFormat_QRCode; reader_init = true)
    @test get_reader_init(co2) == true

    data = UInt8[1, 2, 3, 4, 5]
    bc2 = Barcode(data, co2)
    @test is_valid(bc2) == true
    @test format(bc2) == ZXing_BarcodeFormat_QRCode
    @test bytes(bc2) == data
    @test has_eci(bc2) == true
    @test content_type(bc2) == ZXing_ContentType_Binary
    @test error_type(bc2) == ZXing_ErrorType_None
end
