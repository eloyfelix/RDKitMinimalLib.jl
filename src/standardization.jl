
"""
    cleanup(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Standardizes a molecule.

```julia
cleanup(mol)
```
"""
function cleanup(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:cleanup, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

"""
    normalize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Applies a series of standard transformations to correct functional groups and recombine charges.

```julia
normalize(mol)
```
"""
function normalize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:normalize, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

"""
    canonical_tautomer(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Returns the canonical tautomer for a molecule.

```julia
canonical_tautomer(mol)
```
"""
function canonical_tautomer(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:canonical_tautomer, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

"""
    charge_parent(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Returns the uncharged version of the largest fragment.

```julia
charge_parent(mol)
```
"""
function charge_parent(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:charge_parent, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

"""
    reionize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Ensures the strongest acid groups are charged first.

```julia
reionize(mol)
```
"""
function reionize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:reionize, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

"""
    neutralize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Uncharges molecules by adding and/or removing hydrogens.

```julia
neutralize(mol)
```
"""
function neutralize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:neutralize, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

"""
    fragment_parent(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)

Returns the largest fragment after doing a cleanup.

```julia
fragment_parent(mol)
```
"""
function fragment_parent(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:fragment_parent, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end
