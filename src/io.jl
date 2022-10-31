
mutable struct Mol
    mol::Ref{Cstring}
    mol_size::Ref{Csize_t}
    function Mol(mol::Cstring, mol_size::Ref{Csize_t})
        objref = Ref{Cstring}(mol)
        x = new(objref, mol_size)
        finalizer(x -> ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), x.mol[]), x)
    end
end

mutable struct Reaction
    rxn::Ref{Cstring}
    rxn_size::Ref{Csize_t}
    function Reaction(rxn::Cstring, rxn_size::Ref{Csize_t})
        objref = Ref{Cstring}(rxn)
        x = new(objref, rxn_size)
        finalizer(x -> ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), x.rxn[]), x)
    end
end

"""
    get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Mol,Nothing}

Get a mol from a molblock (v2000, v3000), SMILES or SMARTS.

```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
```
"""
function get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Mol,Nothing}
    details_json::String = jsonify_details(details)
    mol_size = Ref{Csize_t}(0)
    val = ccall((:get_mol, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), mol_string, mol_size, details_json)
    if val == C_NULL
        mol = nothing
    else
        mol = Mol(val, mol_size)
    end
    return mol
end

"""
    get_qmol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Mol,Nothing}

Get a query mol (for substructure search) for a molblock (v2000, v3000), SMILES or SMARTS.

```julia
mol = get_qmol("c1ccccc1")
```
"""
function get_qmol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Mol,Nothing}
    details_json::String = jsonify_details(details)
    mol_size = Ref{Csize_t}(0)
    val::Cstring = ccall((:get_qmol, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), mol_string, mol_size, details_json)
    if val == C_NULL
        mol = nothing
    else
        mol = Mol(val, mol_size)
    end
    return mol
end

"""
    get_rxn(rxn_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Reaction,Nothing}

Get a Reaction object from SMARTS. It can only be currently used for depiction purposes.

```julia
rxn = get_rxn("[CH3:1][OH:2]>>[CH2:1]=[OH0:2]")
```
"""
function get_rxn(rxn_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Reaction,Nothing}
    details_json::String = jsonify_details(details)
    rxn_size = Ref{Csize_t}(0)
    val = ccall((:get_rxn, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), rxn_string, rxn_size, details_json)
    if val == C_NULL
        rxn = nothing
    else
        rxn = Reaction(val, rxn_size)
    end
    return rxn
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
    smiles = unsafe_string_and_free(val)
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
    smarts = unsafe_string_and_free(val)
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
    cxsmiles = unsafe_string_and_free(val)
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
    molblock = unsafe_string_and_free(val)
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
    v3dmolblock = unsafe_string_and_free(val)
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
    json = unsafe_string_and_free(val)
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
    inchi = unsafe_string_and_free(val)
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
    inchi = unsafe_string_and_free(val)
    return inchi
end

"""
    get_inchikey_for_inchi(inchi::AbstractString)

Get the InChIKey for a InChI.

```julia
inchikey = get_inchikey_for_inchi("InChI=1S/C9H8O4/c1-6(10)13-8-5-3-2-4-7(8)9(11)12/h2-5H,1H3,(H,11,12)")
```
"""
function get_inchikey_for_inchi(inchi::AbstractString)
    val::Cstring = ccall((:get_inchikey_for_inchi, librdkitcffi), Cstring, (Cstring,), inchi)
    inchikey = unsafe_string_and_free(val)
    return inchikey
end
