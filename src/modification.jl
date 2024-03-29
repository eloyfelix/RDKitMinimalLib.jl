
"""
    add_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Adds Hydrogens to the molecule.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
add_hs(mol)
```
"""
function add_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:add_hs, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}), mol.mol, mol.mol_size)
end

"""
    remove_all_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Removes all Hydrogens from the molecule.

# Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
remove_all_hs(mol)
```
"""
function remove_all_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:remove_all_hs, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}), mol.mol, mol.mol_size)
end
