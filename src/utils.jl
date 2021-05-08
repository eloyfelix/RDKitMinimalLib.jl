
function jsonify_details(details::Union{Dict{String,Any},Nothing})::String
    details_json::String = ""
    if !isnothing(details)
        details_json = JSON.json(details)
    end
    return details_json
end

function unsafe_string_and_free(cstring::Cstring, length::Union{Ref{Csize_t}, Nothing}=nothing)::String
    if isnothing(length)
        str = unsafe_string(cstring)
    else
        str = unsafe_string(pointer(cstring), length[])
    end
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), cstring)
    return str
end

"""
    version()

Get RDKit version.

```julia
version = version()
```
"""
function version()::String
    val = ccall((:version, librdkitcffi), Cstring, ())
    version = unsafe_string_and_free(val)
    return version
end

"""
    enable_logging()

Enable RDKit logging.

```julia
enable_logging()
```
"""
function enable_logging()
    ccall((:enable_logging, librdkitcffi), Cvoid, ())
end

"""
    disable_logging()

Disable RDKit logging.

```julia
disable_logging()
```
"""
function disable_logging()
    ccall((:disable_logging, librdkitcffi), Cvoid, ())
end
