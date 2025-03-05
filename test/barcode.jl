using ZXingCPP:
    bytes,
    content_type,
    error_type,
    format,
    has_eci,
    is_valid,
    line_count,
    orientation,
    text

@testset "Barcodes" begin
    data_str = "0000101000101101011110111101011011101010100111011100101000100101110010100000"
    data_len = length(data_str)
    data = zeros(UInt8, data_len)
    for (idx, ch) in enumerate(data_str)
        if ch == '0'
            data[idx] = 255
        end
    end
    expected = "96385074"

    iv = ImageView(data, data_len, 1, ZXing_ImageFormat_Lum)
    ro = ReaderOptions(; binarizer=ZXing_Binarizer_BoolCast)
    bcs = read_barcodes(iv, ro)
    bc = bcs[1]

    @test length(bcs) == 1
    @test is_valid(bc) == true
    @test format(bc) == ZXing_BarcodeFormat_EAN8
    @test text(bc) == expected
    @test bytes(bc) == codeunits(expected)
    @test has_eci(bc) == false
    @test content_type(bc) == ZXing_ContentType_Text
    @test orientation(bc) == 0
    @test position(bc).topLeft == ZXing_PointI(4, 0)
    @test line_count(bc) == 1
    @test error_type(bc) == ZXing_ErrorType_None
end