using ZXingCPP
using Test

@testset "ZXingCPP.jl" begin
    include("barcode_format.jl")
    include("barcode.jl")
    include("creator.jl")
    include("reader.jl")
end
