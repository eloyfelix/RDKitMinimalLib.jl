
function get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_morgan_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_morgan_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::string
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val = ccall((:get_morgan_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    return unsafe_string(val)
end

function get_rdkit_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_rdkit_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_rdkit_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::string
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val = ccall((:get_rdkit_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    return unsafe_string(val)
end

function get_pattern_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_pattern_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_pattern_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val = ccall((:get_pattern_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    return unsafe_string(val)
end

function get_descriptors(mol::Mol)
    val = ccall((:get_descriptors, librdkitcffi), Cstring, (Cstring, Csize_t), mol.mol[], mol.mol_size[])
    return JSON.parse(unsafe_string(val))
end
