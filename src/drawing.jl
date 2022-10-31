"""
    get_svg(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get a SVG depiction of the mol.

#Examples
```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
svg = get_svg(mol, Dict{String,Any}("height" => 300, "width" => 350))
```

```julia
mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
svg = get_svg(mol, Dict{String,Any}("height" => 300, "width" => 350))
```

"""
function get_svg(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_svg, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    svg = unsafe_string_and_free(val)
    return svg
end

"""
    get_svg(mol::Mol, smatches::Vector, details::Dict=Dict{String,Any}())::String

Get a SVG depiction of the mol with multiple substructre matches.

#Examples
```julia
mol = get_mol("c1ccccc1")
qmol = get_qmol("c")
smatches = get_substruct_matches(mol, qmol)
svg = get_svg(mol, smatches)
```
"""
function get_svg(mol::Mol, smatches::Vector, details::Dict=Dict{String,Any}())::String
    all_matches = Dict{String,Any}([
        "bonds" => reduce(vcat, match["bonds"] for match in smatches) 
        "atoms" => reduce(vcat, match["atoms"] for match in smatches)
    ])
    return get_svg(mol, merge(details, all_matches))
end

"""
    get_rxn_svg(rxn::Reaction, details::Union{Dict{String,Any},Nothing}=nothing)::String

Get a SVG depiction of the reaction.

#Examples
```julia
svg = get_rxn_svg(rxn)
rxn = get_rxn("[CH3:1][OH:2]>>[CH2:1]=[OH0:2]")
rxn_svg = get_rxn_svg(rxn, Dict{String,Any}("height" => 300, "width" => 500))
```
"""
function get_rxn_svg(rxn::Reaction, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val::Cstring = ccall((:get_rxn_svg, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), rxn.rxn[], rxn.rxn_size[], details_json)
    svg = unsafe_string_and_free(val)
    return svg
end
