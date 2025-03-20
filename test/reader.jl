@testset "Reader Options" begin
    ro1 = ReaderOptions()

    @test get_formats(ro1) == ZXing_BarcodeFormat_None
    @test get_try_harder(ro1) == true

    set_formats!(ro1, ZXing_BarcodeFormat_EAN8)
    @test get_formats(ro1) == ZXing_BarcodeFormat_EAN8

    set_try_harder!(ro1, false)
    @test get_try_harder(ro1) == false

    ro2 = ReaderOptions(; is_pure = true, text_mode = ZXing_TextMode_Hex)

    @test get_formats(ro2) == ZXing_BarcodeFormat_None
    @test get_try_harder(ro2) == true

    @test get_is_pure(ro2) == true
    @test get_text_mode(ro2) == ZXing_TextMode_Hex
end
