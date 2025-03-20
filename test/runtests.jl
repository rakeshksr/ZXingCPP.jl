using ZXingCPP
using Test
using OpenCV

using ZXingCPP: # Barcode
                bytes,
                content_type,
                error_type,
                format,
                has_eci,
                is_valid,
                line_count,
                orientation,
                symbology_identifier,
                text,

# Creator
                get_reader_init,
                set_reader_init!,

# Reader
                get_formats,
                get_is_pure,
                get_text_mode,
                get_try_harder,
                set_formats!,
                set_try_harder!

@testset "ZXingCPP.jl" begin
    include("barcode_format.jl")
    include("barcode.jl")
    include("creator.jl")
    include("integration.jl")
    include("reader.jl")
end
