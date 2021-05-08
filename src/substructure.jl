
"""
    get_substruct_match(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}

Gets a substructure match.

```julia
smatch = get_substruct_match(mol)
```
"""
function get_substruct_match(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}
    options_json::String = jsonify_details(options)
    val::Cstring = ccall((:get_substruct_match, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], qmol.mol[], qmol.mol_size[], options_json)
    smatch = JSON.parse(unsafe_string_and_free(val))
    return smatch
end

"""
    get_substruct_matches(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}

Gets all substructure matches.

```julia
smatches = get_substruct_matches(mol)
```
"""
function get_substruct_matches(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Vector{Any}
    options_json::String = jsonify_details(options)
    val::Cstring = ccall((:get_substruct_matches, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], qmol.mol[], qmol.mol_size[], options_json)
    smatches = JSON.parse(unsafe_string_and_free(val))
    return smatches
end
