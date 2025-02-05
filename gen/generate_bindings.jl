using Clang.Generators
using ZXing_CPP_jll

include_dir = normpath(ZXing_CPP_jll.artifact_dir, "include", "ZXing")

# wrapper generator options
options = load_options(joinpath(@__DIR__, "generator.toml"))

options["general"]["output_file_path"] = normpath(@__DIR__, "../lib/libZXingCpp.jl")

# add compiler flags, e.g. "-DXXXXXXXXX"
args = get_default_args()
push!(args, "-I$include_dir", "-DZXING_EXPERIMENTAL_API=ON")

headers = [joinpath(include_dir, "ZXingC.h")]

# create context
ctx = create_context(headers, args, options)

# run generator
build!(ctx)
