@testset "Barcode Format" begin
    formats = ZXing_BarcodeFormatsFromString("qrcode,linearcodes")
    value = ZXing_BarcodeFormat_QRCode | ZXing_BarcodeFormat_LinearCodes
    @test formats == value
end