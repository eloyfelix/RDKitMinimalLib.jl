
function get_substruct_match(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::String
    options_json::String = jsonify_details(options)
    val = ccall((:get_substruct_match, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], qmol.mol[], qmol.mol_size[], options_json)
    return JSON.parse(unsafe_string(val))
end

function get_substruct_matches(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::String
    options_json::String = jsonify_details(options)
    val = ccall((:get_substruct_matches, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], qmol.mol[], qmol.mol_size[], options_json)
    return JSON.parse(unsafe_string(val))
end
