
"""
    get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get Morgan (ECFP like) fingerprints.

```julia
mfp = get_morgan_fp(mol)
```

```julia
fp_details = Dict{String, Any}("nBits" => 512, "radius" => 2)
morgan_fp = get_morgan_fp(mol, fp_details)

```
"""
function get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_morgan_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

"""
    get_morgan_fp_as_bytes(mol::Mol)

Get Morgan (ECFP like) fingerprints as bytes.

```julia
morgan_fp_bytes = get_morgan_fp_as_bytes(mol)
```
"""
function get_morgan_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val = ccall((:get_morgan_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    return unsafe_string(pointer(val), n_bytes[])
end

"""
    get_rdkit_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get RDKit fingerprints.

```julia
rfp = get_rdkit_fp(mol)
```
"""
function get_rdkit_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_rdkit_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

"""
    get_rdkit_fp_as_bytes(mol::Mol)

Get RDKit fingerprints as bytes.

```julia
rfp_bytes = get_rdkit_fp_as_bytes(mol)
```
"""
function get_rdkit_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val = ccall((:get_rdkit_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    return unsafe_string(pointer(val), n_bytes[])
end

"""
    get_pattern_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get RDKit Pattern fingerprints.

```julia
pfp = get_pattern_fp(mol)
```
"""
function get_pattern_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_pattern_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

"""
    get_pattern_fp_as_bytes(mol::Mol)

Get RDKit Pattern fingerprints as bytes.

```julia
pfp_bytes = get_pattern_fp_as_bytes(mol)
```
"""
function get_pattern_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val = ccall((:get_pattern_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    return unsafe_string(pointer(val), n_bytes[])
end

"""
    get_descriptors(mol::Mol)

Get physico-chemical descriptors.

```julia
descs = get_descriptors(mol)
```
"""
function get_descriptors(mol::Mol)
    val = ccall((:get_descriptors, librdkitcffi), Cstring, (Cstring, Csize_t), mol.mol[], mol.mol_size[])
    return JSON.parse(unsafe_string(val))
end
