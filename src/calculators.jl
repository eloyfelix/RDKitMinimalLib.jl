
"""
    get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get Morgan (ECFP like) fingerprints.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
mfp = get_morgan_fp(mol)
```

```julia
fp_details = Dict{String, Any}("nBits" => 512, "radius" => 2)
morgan_fp = get_morgan_fp(mol, fp_details)

```
"""
function get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_morgan_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    mfp = unsafe_string_and_free(val)
    return mfp
end

"""
    get_morgan_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}

Get Morgan (ECFP like) fingerprints as bytes.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
morgan_fp_bytes = get_morgan_fp_as_bytes(mol)
```
"""
function get_morgan_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_morgan_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    mfp = unsafe_string_and_free(val, n_bytes)
    return Vector{UInt8}(mfp)
end

"""
    get_rdkit_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get RDKit fingerprints.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
rfp = get_rdkit_fp(mol)
```
"""
function get_rdkit_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_rdkit_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    rfp = unsafe_string_and_free(val)
    return rfp
end

"""
    get_rdkit_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}

Get RDKit fingerprints as bytes.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
rfp_bytes = get_rdkit_fp_as_bytes(mol)
```
"""
function get_rdkit_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_rdkit_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    rfp = unsafe_string_and_free(val, n_bytes)
    return Vector{UInt8}(rfp)
end

"""
    get_pattern_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get RDKit Pattern fingerprints.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
pfp = get_pattern_fp(mol)
```
"""
function get_pattern_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_pattern_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    pfp = unsafe_string_and_free(val)
    return pfp
end

"""
    get_pattern_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}

Get RDKit Pattern fingerprints as bytes.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
pfp_bytes = get_pattern_fp_as_bytes(mol)
```
"""
function get_pattern_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_pattern_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    pfp = unsafe_string_and_free(val, n_bytes)
    return Vector{UInt8}(pfp)
end

"""
    get_atom_pair_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get atom pair fingerprints.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
apfp = get_atom_pair_fp(mol)
```
"""
function get_atom_pair_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_atom_pair_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    apfp = unsafe_string_and_free(val)
    return apfp
end

"""
    get_atom_pair_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}

Get atom pair fingerprints as bytes.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
apfp_bytes = get_atom_pair_fp_as_bytes(mol)
```
"""
function get_atom_pair_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_atom_pair_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    apfp = unsafe_string_and_free(val, n_bytes)
    return Vector{UInt8}(apfp)
end

"""
    get_topological_torsion_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get topological torsion fingerprints.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
ttfp = get_topological_torsion_fp(mol)
```
"""
function get_topological_torsion_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_topological_torsion_fp, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    ttfp = unsafe_string_and_free(val)
    return ttfp
end

"""
    get_topological_torsion_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}

Get topological torsion fingerprints as bytes.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
ttfp_bytes = get_topological_torsion_fp_as_bytes(mol)
```
"""
function get_topological_torsion_fp_as_bytes(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Vector{UInt8}
    details_json::String = jsonify_details(details)
    n_bytes = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_topological_torsion_fp_as_bytes, librdkitcffi), Cstring, (Cstring, Csize_t, Ref{Csize_t}, Cstring), mol.mol[], mol.mol_size[], n_bytes, details_json)
    ttfp = unsafe_string_and_free(val, n_bytes)
    return Vector{UInt8}(ttfp)
end

"""
    get_descriptors(mol::Mol)::Dict{String, Any}

Get physico-chemical descriptors.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
descs = get_descriptors(mol)
```
"""
function get_descriptors(mol::Mol)::Dict{String, Any}
    val::Cstring = ccall((:get_descriptors, librdkitcffi), Cstring, (Cstring, Csize_t), mol.mol[], mol.mol_size[])
    json = JSON.parse(unsafe_string_and_free(val), dicttype = Dict{String, Any})
    return json
end
