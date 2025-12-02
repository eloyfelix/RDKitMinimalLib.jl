
"""
    get_substruct_match(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}

Gets a substructure match.

# Examples
```julia
pattern = get_qmol("ccO")
mol = get_mol("c1ccccc1O")
smatch = get_substruct_match(mol, pattern)
```
"""
function get_substruct_match(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}
    options_json::String = jsonify_details(options)
    val::Cstring = ccall((:get_substruct_match, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], qmol.mol[], qmol.mol_size[], options_json)
    smatch = JSON.parse(unsafe_string_and_free(val), dicttype = Dict{String, Any})
    return smatch
end

"""
    get_substruct_matches(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}

Gets all substructure matches.

# Examples
```julia
pattern = get_qmol("ccO")
mol = get_mol("c1ccccc1O")
smatches = get_substruct_matches(mol, pattern)
```
"""
function get_substruct_matches(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Union{Dict{String, Any}, Vector{Any}}
    options_json::String = jsonify_details(options)
    val::Cstring = ccall((:get_substruct_matches, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], qmol.mol[], qmol.mol_size[], options_json)
    smatches = JSON.parse(unsafe_string_and_free(val), dicttype = Dict{String, Any})
    return smatches
end
