# RDKitMinimalLib wrapper for the Julia programming language

See https://github.com/rdkit/rdkit/tree/master/Code/MinimalLib

## to install:

```julia
(@v1.6) pkg> add https://github.com/eloyfelix/RDKitMinimalLib.jl
```

## example:

```julia
using RDKitMinimalLib

mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
smiles = get_smiles(mol)
descriptors = get_descriptors(mol)

fp_details = Dict{String, Any}("nBits" => 512, "radius" => 2)
morgan_fp = get_morgan_fp(mol, fp_details)

inchi = get_inchi_for_molblock(molblock)
inchi_key = get_inchikey_for_inchi(inchi)
svg = get_svg(mol)

println(smiles)
println(descriptors)
println(morgan_fp)
println(inchi)
println(inchi_key)

open("mol.svg", "w") do file
    write(file, svg)
end
```