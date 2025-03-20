@testset "Barcode Format" begin
    @test ZXing_BarcodeFormatsFromString("qrcode") == ZXing_BarcodeFormat_QRCode
    @test ZXing_BarcodeFormatsFromString("qrcode, linearcodes") ==
          ZXing_BarcodeFormat_QRCode | ZXing_BarcodeFormat_LinearCodes
    @test ZXing_BarcodeFormatsFromString("ITF, qrcode") ==
          ZXing_BarcodeFormat_ITF | ZXing_BarcodeFormat_QRCode
end
