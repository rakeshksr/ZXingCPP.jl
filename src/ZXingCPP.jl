module ZXingCPP
using ZXing_CPP_jll
using Reexport

const libdir = joinpath(@__DIR__, "..", "lib")
include(joinpath(libdir, "libZXingCpp.jl"))

@reexport using .libZXingCpp

include("show.jl")

include("barcode_format.jl")
export BarcodeFormats

include("barcode.jl")
export Barcode, Barcodes

include("image.jl")
export Image, ImageView

include("creator.jl")
export CreatorOptions

include("reader.jl")
export ReaderOptions, read_barcodes

include("writer.jl")
export WriterOptions, write_barcode_to_image, write_barcode_to_svg

include("precompile.jl")

end # module ZXingCPP
