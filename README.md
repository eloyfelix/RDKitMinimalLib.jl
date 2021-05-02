# RDKitMinimalLib wrapper for the Julia programming language

This is very experimental and it can break (and will probably do). This package contains Julia librdkitcffi wrappers using ccall.

## to install (requires Julia ≥ 1.6):

```julia
julia> import Pkg
julia> Pkg.add(url="https://github.com/eloyfelix/RDKitMinimalLib.jl")
```

## example:

```julia
using RDKitMinimalLib

molblock = """

     RDKit          2D

 13 13  0  0  0  0  0  0  0  0999 V2000
    8.8810   -2.1206    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    8.8798   -2.9479    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    9.5946   -3.3607    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   10.3110   -2.9474    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   10.3081   -2.1170    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
    9.5928   -1.7078    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   11.0210   -1.7018    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   11.7369   -2.1116    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   11.0260   -3.3588    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   11.0273   -4.1837    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   11.7423   -4.5949    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0
   10.3136   -4.5972    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
   11.0178   -0.8769    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
  1  2  2  0
  5  7  1  0
  3  4  2  0
  7  8  2  0
  4  9  1  0
  4  5  1  0
  9 10  1  0
  2  3  1  0
 10 11  1  0
  5  6  2  0
 10 12  2  0
  6  1  1  0
  7 13  1  0
M  END
"""

mol = get_mol(molblock)
qmol = get_qmol("c1ccccc1")

smiles = get_smiles(mol)
descriptors = get_descriptors(mol)

fp_details = Dict{String, Any}("nBits" => 512, "radius" => 2)
morgan_fp = get_morgan_fp(mol, fp_details)

inchi = get_inchi_for_molblock(molblock)
inchi_key = get_inchikey_for_inchi(inchi)

println(smiles)
println(descriptors)
println(morgan_fp)
println(inchi)
println(inchi_key)

smatch = get_substruct_match(mol, qmol)
svg = get_svg(mol, smatch)

open("mol.svg", "w") do file
    write(file, svg)
end

add_hs(mol)
set_3d_coords(mol)
open("3d_coords.mol", "w") do file
    write(file, get_molblock(mol))
end

```
