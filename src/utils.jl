
function jsonify_details(details::Union{Dict{String,Any},Nothing})::String
    details_json::String = ""
    if !isnothing(details)
        details_json = JSON.json(details)
    end
    return details_json
end

function version()::String
    val = ccall((:version, librdkitcffi), Cstring, ())
    return unsafe_string(val)
end

function enable_logging()
    ccall((:enable_logging, librdkitcffi), Cvoid, ())
end

function disable_logging()
    ccall((:disable_logging, librdkitcffi), Cvoid, ())
end
