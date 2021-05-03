
"""
    get_svg(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get a SVG depiction of the mol.

```julia
svg = get_svg(mol)
```
"""
function get_svg(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_svg, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end
