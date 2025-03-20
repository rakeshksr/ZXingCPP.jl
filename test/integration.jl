function check(bc::Barcode, fmt::ZXing_BarcodeFormat, txt::String)
    @test is_valid(bc) == true
    @test format(bc) == fmt
    @test text(bc) == txt
    @test bytes(bc) == codeunits(txt)
    @test orientation(bc) == 0
    @test content_type(bc) == ZXing_ContentType_Text
end

@testset "Create, Read and Write" begin
    fmt = ZXing_BarcodeFormat_QRCode
    txt = "Hello World"
    bc = Barcode(txt, CreatorOptions(fmt))
    img = write_barcode_to_image(bc)
    iv = ImageView(img)
    res1 = read_barcodes(iv)[1]

    check(res1, fmt, txt)

    @test symbology_identifier(res1) == "]Q1"
    @test position(res1).topLeft.x == 4

    res2 = read_barcodes(iv, ReaderOptions(; formats = fmt))[1]
    check(res2, fmt, txt)
end

@testset "Empty Barcodes" begin
    iv = ImageView(zeros(UInt8, 0, 0), ZXing_ImageFormat_Lum)
    fmt = ZXing_BarcodeFormat_QRCode
    bcs = read_barcodes(iv, ReaderOptions(; formats = fmt))
    @test length(bcs) == 0
end

@testset "OpenCV" begin
    fmt = ZXing_BarcodeFormat_QRCode
    txt = "Hello World"
    bc = Barcode(txt, CreatorOptions(fmt))
    img = write_barcode_to_image(bc)
    opencv_img = OpenCV.Mat(img)
    check(read_barcodes(opencv_img)[1], fmt, txt)
end
