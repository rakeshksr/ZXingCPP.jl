@testset "Barcode Format" begin
    format = ZXing_BarcodeFormat("Micro PDF417")
    s = symbology(format)
    @test format == ZXing_BarcodeFormat_MicroPDF417
    @test string(format) == "MicroPDF417"
    @test s == ZXing_BarcodeFormat_PDF417
    @test string(s) == "PDF417"
end

@testset "Barcode Formats String" begin
    formats = BarcodeFormats("qrcode,Aztec")
    @test formats == [ZXing_BarcodeFormat_QRCode, ZXing_BarcodeFormat_Aztec]
    @test length(formats) == 2
    @test ZXing_BarcodeFormat_QRCode ∈ formats
    @test ZXing_BarcodeFormat_Aztec ∈ formats
    @test ZXing_BarcodeFormat_EAN8 ∉ formats
    @test BarcodeFormats("qrcoder,Aztec") == []
end

@testset "Barcode Formats List" begin
    formats = BarcodeFormats(ZXing_BarcodeFormat_AllReadable)
    @test length(formats) > 25
    @test ZXing_BarcodeFormat_QRCode ∈ formats
    @test ZXing_BarcodeFormat_Aztec ∈ formats
    @test ZXing_BarcodeFormat_EAN5 ∉ formats
end
