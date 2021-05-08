
mutable struct Mol
    mol::Ref{Cstring}
    mol_size::Ref{Csize_t}
    function Mol(mol::Cstring, mol_size::Ref{Csize_t})
        objref = Ref{Cstring}(mol)
        x = new(objref, mol_size)
        finalizer(x -> ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), x.mol[]), x)
    end
end

"""
    get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Mol

Get a mol from a molblock (v2000, v3000), SMILES or SMARTS.

```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
```
"""
function get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Mol
    details_json::String = jsonify_details(details)
    mol_size = Ref{Csize_t}(0)
    val = ccall((:get_mol, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), mol_string, mol_size, details_json)
    if val == C_NULL
        error("error parsing the molecule, use enable_logging() to get more info")
    end
    mol = Mol(val, mol_size)
    return mol
end

"""
    get_qmol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Mol

Get a query mol (for substructure search) for a molblock (v2000, v3000), SMILES or SMARTS.

```julia
mol = get_qmol("c1ccccc1")
```
"""
function get_qmol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Mol
    details_json::String = jsonify_details(details)
    mol_size = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_qmol, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), mol_string, mol_size, details_json)
    if val == C_NULL
        error("error parsing the molecule, use enable_logging() to get more info")
    end
    mol = Mol(val, mol_size)
    return mol
end

"""
    get_smiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the SMILES for a mol object.

```julia
smiles = get_smiles(mol)
```
"""
function get_smiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_smiles, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    smiles = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return smiles
end

"""
    get_smarts(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the SMARTS for a mol object.

```julia
smarts = get_smarts(mol)
```
"""
function get_smarts(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_smarts, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    smarts = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return smarts
end

"""
    get_cxsmiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the CXSMILES for a mol object.

```julia
cxsmiles = get_cxsmiles(mol)
```
"""
function get_cxsmiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_cxsmiles, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    cxsmiles = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return cxsmiles
end

"""
    get_molblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the molblock (V2000) for a mol object.

```julia
molblock = get_molblock(mol)
```
"""
function get_molblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_molblock, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    molblock = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return molblock
end

"""
    get_molblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the molblock (V3000) for a mol object.

```julia
v3kmolblock = get_v3kmolblock(mol)
```
"""
function get_v3kmolblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_v3kmolblock, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    v3dmolblock = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return v3dmolblock
end

"""
    get_json(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the json (CommonChem format) for a mol object.

```julia
json = get_json(mol)
```
"""
function get_json(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_json, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    json = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return json
end

"""
    get_inchi(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the InChI for a mol object.

```julia
inchi = get_inchi(mol)
```
"""
function get_inchi(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_inchi, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    inchi = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return inchi
end

"""
    get_inchi_for_molblock(molblock::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get the InChI for a molblock.

```julia
inchi = get_inchi_for_molblock(molblock)
```
"""
function get_inchi_for_molblock(molblock::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_inchi_for_molblock, librdkitcffi), Cstring, (Cstring, Cstring), molblock, details_json)
    inchi = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return inchi
end

"""
    get_inchikey_for_inchi(inchi::AbstractString)

Get the InChIKey for a InChI.

```julia
inchikey = get_inchikey_for_inchi(inchi)
```
"""
function get_inchikey_for_inchi(inchi::AbstractString)
    val::Cstring = ccall((:get_inchikey_for_inchi, librdkitcffi), Cstring, (Cstring,), inchi)
    inchikey = unsafe_string(val)
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), val)
    return inchikey
end
