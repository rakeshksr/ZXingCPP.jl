module ZXing_CPP
using ZXing_CPP_jll

libdir = joinpath(@__DIR__, "..", "lib")
include(joinpath(libdir, "libZXingCpp.jl"))

include("barcode.jl")
export Barcode, Barcodes

include("image.jl")
export Image, ImageView

include("creator.jl")
export CreatorOptions

include("reader.jl")
export ReaderOptions, read_bar_codes

include("writer.jl")
export WriterOptions, write_barcode_to_svg, write_barcode_to_image

end # module ZXing_CPP
