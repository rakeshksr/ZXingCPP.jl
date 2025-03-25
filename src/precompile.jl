using PrecompileTools

@setup_workload begin
    @compile_workload begin
        f = ZXing_BarcodeFormat_QRCode

        co = CreatorOptions(f)
        bc = Barcode("HELLO WORLD", co)

        wo = WriterOptions(; scale = 10)
        write_barcode_to_image(bc, wo)

        ro = ReaderOptions(; formats = f)
    end
end
