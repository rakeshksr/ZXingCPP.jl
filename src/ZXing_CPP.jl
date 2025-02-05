module ZXing_CPP
using ZXing_CPP_jll

libdir = joinpath(@__DIR__, "..", "lib")
include(joinpath(libdir, "libZXingCpp.jl"))

include("barcode.jl")
export Barcode, Barcodes

include("image.jl")
export Image, ImageView

include("reader.jl")
export ReaderOptions, read_bar_codes

end # module ZXing_CPP
