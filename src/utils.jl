function create_zxing_ptr_struct(jl_struct::Symbol, c_struct::Symbol)
    # Define the struct that wraps around the C struct
    @eval begin
        mutable struct $(jl_struct)
            ptr::Ptr{$(c_struct)}  # A raw pointer to the C struct

            function $(jl_struct)(ptr::Ptr{$(c_struct)})
                obj = new(ptr)
                # Add the finalizer to clean up when the struct is garbage collected
                finalizer(obj) do obj
                    f = Symbol(string($(c_struct), "_delete"))
                    # println("\n")
                    # println(f)
                    # println(typeof(f))
                    # println(eval(f))
                    # println("\n")
                    # Error at eval
                    eval(f)(obj.ptr)
                end
            end
        end
    end
end
