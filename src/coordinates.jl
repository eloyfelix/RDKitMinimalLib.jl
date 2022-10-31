
"""
    prefer_coordgen(val::Int64)

Set to use CoordgenLibs for 2D coordinates generation.

```julia
prefer_coordgen(1)
```
"""
function prefer_coordgen(val::Integer)
    ccall((:prefer_coordgen, librdkitcffi), Cvoid, (Cshort,), Cshort(val))
end

"""
    set_2d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Int16

Generate 2D coordinates.

```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
set_2d_coords(mol)
```
"""
function set_2d_coords(mol::Mol)::Int16
    val::Cshort = ccall((:set_2d_coords, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}), mol.mol, mol.mol_size)
    return val
end

"""
    set_2d_coords_aligned(mol::Mol, template_mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Int16

Generate 2D coordinates aligned to a template mol.

```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
template = get_mol("CC(=O)Nc1ccc(O)cc1")
set_2d_coords(template)
set_2d_coords_aligned(mol, template_mol)
```
"""
function set_2d_coords_aligned(mol::Mol, template_mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Int16
    details_json::String = jsonify_details(details)
    val::Cshort = ccall((:set_2d_coords_aligned, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}, Cstring, Csize_t, Cstring, Ref{Ref{Cstring}}), mol.mol, mol.mol_size, template_mol.mol[], template_mol.mol_size[], details_json, C_NULL)
    return val
end

"""
    set_3d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Int16

Generate 3D coordinates.

```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
set_3d_coords(mol)
```
"""
function set_3d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::Int16
    details_json::String = jsonify_details(details)
    val::Cshort = ccall((:set_3d_coords, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
    return val
end
