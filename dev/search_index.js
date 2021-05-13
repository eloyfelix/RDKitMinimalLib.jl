var documenterSearchIndex = {"docs":
[{"location":"substructure/","page":"Substructure","title":"Substructure","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"substructure/","page":"Substructure","title":"Substructure","text":"get_substruct_match\nget_substruct_matches","category":"page"},{"location":"substructure/#RDKitMinimalLib.get_substruct_match","page":"Substructure","title":"RDKitMinimalLib.get_substruct_match","text":"get_substruct_match(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}\n\nGets a substructure match.\n\nsmatch = get_substruct_match(mol)\n\n\n\n\n\n","category":"function"},{"location":"substructure/#RDKitMinimalLib.get_substruct_matches","page":"Substructure","title":"RDKitMinimalLib.get_substruct_matches","text":"get_substruct_matches(mol::Mol, qmol::Mol, options::Union{Dict{String,Any},Nothing}=nothing)::Dict{String, Any}\n\nGets all substructure matches.\n\nsmatches = get_substruct_matches(mol)\n\n\n\n\n\n","category":"function"},{"location":"modification/","page":"Modification","title":"Modification","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"modification/","page":"Modification","title":"Modification","text":"add_hs\nremove_all_hs","category":"page"},{"location":"modification/#RDKitMinimalLib.add_hs","page":"Modification","title":"RDKitMinimalLib.add_hs","text":"add_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)\n\nAdds Hydrogens to the molecule.\n\nadd_hs(mol)\n\n\n\n\n\n","category":"function"},{"location":"modification/#RDKitMinimalLib.remove_all_hs","page":"Modification","title":"RDKitMinimalLib.remove_all_hs","text":"remove_all_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)\n\nRemoves all Hydrogens from the molecule.\n\nremove_all_hs(mol)\n\n\n\n\n\n","category":"function"},{"location":"calculators/","page":"Calculators","title":"Calculators","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"calculators/","page":"Calculators","title":"Calculators","text":"get_morgan_fp\nget_morgan_fp_as_bytes\nget_rdkit_fp\nget_rdkit_fp_as_bytes\nget_pattern_fp\nget_pattern_fp_as_bytes\nget_descriptors","category":"page"},{"location":"calculators/#RDKitMinimalLib.get_morgan_fp","page":"Calculators","title":"RDKitMinimalLib.get_morgan_fp","text":"get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet Morgan (ECFP like) fingerprints.\n\nmfp = get_morgan_fp(mol)\n\nfp_details = Dict{String, Any}(\"nBits\" => 512, \"radius\" => 2)\nmorgan_fp = get_morgan_fp(mol, fp_details)\n\n\n\n\n\n\n","category":"function"},{"location":"calculators/#RDKitMinimalLib.get_morgan_fp_as_bytes","page":"Calculators","title":"RDKitMinimalLib.get_morgan_fp_as_bytes","text":"get_morgan_fp_as_bytes(mol::Mol)\n\nGet Morgan (ECFP like) fingerprints as bytes.\n\nmorgan_fp_bytes = get_morgan_fp_as_bytes(mol)\n\n\n\n\n\n","category":"function"},{"location":"calculators/#RDKitMinimalLib.get_rdkit_fp","page":"Calculators","title":"RDKitMinimalLib.get_rdkit_fp","text":"get_rdkit_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet RDKit fingerprints.\n\nrfp = get_rdkit_fp(mol)\n\n\n\n\n\n","category":"function"},{"location":"calculators/#RDKitMinimalLib.get_rdkit_fp_as_bytes","page":"Calculators","title":"RDKitMinimalLib.get_rdkit_fp_as_bytes","text":"get_rdkit_fp_as_bytes(mol::Mol)\n\nGet RDKit fingerprints as bytes.\n\nrfp_bytes = get_rdkit_fp_as_bytes(mol)\n\n\n\n\n\n","category":"function"},{"location":"calculators/#RDKitMinimalLib.get_pattern_fp","page":"Calculators","title":"RDKitMinimalLib.get_pattern_fp","text":"get_pattern_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet RDKit Pattern fingerprints.\n\npfp = get_pattern_fp(mol)\n\n\n\n\n\n","category":"function"},{"location":"calculators/#RDKitMinimalLib.get_pattern_fp_as_bytes","page":"Calculators","title":"RDKitMinimalLib.get_pattern_fp_as_bytes","text":"get_pattern_fp_as_bytes(mol::Mol)\n\nGet RDKit Pattern fingerprints as bytes.\n\npfp_bytes = get_pattern_fp_as_bytes(mol)\n\n\n\n\n\n","category":"function"},{"location":"calculators/#RDKitMinimalLib.get_descriptors","page":"Calculators","title":"RDKitMinimalLib.get_descriptors","text":"get_descriptors(mol::Mol)\n\nGet physico-chemical descriptors.\n\ndescs = get_descriptors(mol)\n\n\n\n\n\n","category":"function"},{"location":"coordinates/","page":"Coordinates","title":"Coordinates","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"coordinates/","page":"Coordinates","title":"Coordinates","text":"prefer_coordgen\nset_2d_coords\nset_2d_coords_aligned\nset_3d_coords","category":"page"},{"location":"coordinates/#RDKitMinimalLib.prefer_coordgen","page":"Coordinates","title":"RDKitMinimalLib.prefer_coordgen","text":"prefer_coordgen(val::Int64)\n\nSet to use CoordgenLibs for 2D coordinates generation.\n\nprefer_coordgen(1)\n\n\n\n\n\n","category":"function"},{"location":"coordinates/#RDKitMinimalLib.set_2d_coords","page":"Coordinates","title":"RDKitMinimalLib.set_2d_coords","text":"set_2d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)\n\nGenerate 2D coordinates.\n\nset_2d_coords(mol)\n\n\n\n\n\n","category":"function"},{"location":"coordinates/#RDKitMinimalLib.set_2d_coords_aligned","page":"Coordinates","title":"RDKitMinimalLib.set_2d_coords_aligned","text":"set_2d_coords_aligned(mol::Mol, template_mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)\n\nGenerate 2D coordinates aligned to a template mol.\n\nset_2d_coords_aligned(mol, template_mol)\n\n\n\n\n\n","category":"function"},{"location":"coordinates/#RDKitMinimalLib.set_3d_coords","page":"Coordinates","title":"RDKitMinimalLib.set_3d_coords","text":"set_3d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)\n\nGenerate 3D coordinates.\n\nset_3d_coords(mol)\n\n\n\n\n\n","category":"function"},{"location":"drawing/","page":"Drawing","title":"Drawing","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"drawing/","page":"Drawing","title":"Drawing","text":"get_svg","category":"page"},{"location":"drawing/#RDKitMinimalLib.get_svg","page":"Drawing","title":"RDKitMinimalLib.get_svg","text":"get_svg(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet a SVG depiction of the mol.\n\nsvg = get_svg(mol)\n\n\n\n\n\n","category":"function"},{"location":"#RDKitMinimalLib.jl","page":"Home","title":"RDKitMinimalLib.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Welcome to the RDKitMinimalLib.jl documentation!","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"io/","page":"I/O","title":"I/O","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"io/","page":"I/O","title":"I/O","text":"get_mol\nget_qmol\nget_smiles\nget_smarts\nget_molblock\nget_v3kmolblock\nget_inchi\nget_inchi_for_molblock\nget_inchikey_for_inchi","category":"page"},{"location":"io/#RDKitMinimalLib.get_mol","page":"I/O","title":"RDKitMinimalLib.get_mol","text":"get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Mol,Nothing}\n\nGet a mol from a molblock (v2000, v3000), SMILES or SMARTS.\n\nmol = get_mol(\"CC(=O)Oc1ccccc1C(=O)O\")\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_qmol","page":"I/O","title":"RDKitMinimalLib.get_qmol","text":"get_qmol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Union{Mol,Nothing}\n\nGet a query mol (for substructure search) for a molblock (v2000, v3000), SMILES or SMARTS.\n\nmol = get_qmol(\"c1ccccc1\")\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_smiles","page":"I/O","title":"RDKitMinimalLib.get_smiles","text":"get_smiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet the SMILES for a mol object.\n\nsmiles = get_smiles(mol)\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_smarts","page":"I/O","title":"RDKitMinimalLib.get_smarts","text":"get_smarts(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet the SMARTS for a mol object.\n\nsmarts = get_smarts(mol)\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_molblock","page":"I/O","title":"RDKitMinimalLib.get_molblock","text":"get_molblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet the molblock (V2000) for a mol object.\n\nmolblock = get_molblock(mol)\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_v3kmolblock","page":"I/O","title":"RDKitMinimalLib.get_v3kmolblock","text":"get_molblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet the molblock (V3000) for a mol object.\n\nv3kmolblock = get_v3kmolblock(mol)\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_inchi","page":"I/O","title":"RDKitMinimalLib.get_inchi","text":"get_inchi(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet the InChI for a mol object.\n\ninchi = get_inchi(mol)\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_inchi_for_molblock","page":"I/O","title":"RDKitMinimalLib.get_inchi_for_molblock","text":"get_inchi_for_molblock(molblock::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::String\n\nGet the InChI for a molblock.\n\ninchi = get_inchi_for_molblock(molblock)\n\n\n\n\n\n","category":"function"},{"location":"io/#RDKitMinimalLib.get_inchikey_for_inchi","page":"I/O","title":"RDKitMinimalLib.get_inchikey_for_inchi","text":"get_inchikey_for_inchi(inchi::AbstractString)\n\nGet the InChIKey for a InChI.\n\ninchikey = get_inchikey_for_inchi(\"InChI=1S/C9H8O4/c1-6(10)13-8-5-3-2-4-7(8)9(11)12/h2-5H,1H3,(H,11,12)\")\n\n\n\n\n\n","category":"function"},{"location":"utils/","page":"Utils","title":"Utils","text":"CurrentModule = RDKitMinimalLib","category":"page"},{"location":"utils/","page":"Utils","title":"Utils","text":"version\nenable_logging\ndisable_logging","category":"page"},{"location":"utils/#RDKitMinimalLib.version","page":"Utils","title":"RDKitMinimalLib.version","text":"version()\n\nGet RDKit version.\n\nversion = version()\n\n\n\n\n\n","category":"function"},{"location":"utils/#RDKitMinimalLib.enable_logging","page":"Utils","title":"RDKitMinimalLib.enable_logging","text":"enable_logging()\n\nEnable RDKit logging.\n\nenable_logging()\n\n\n\n\n\n","category":"function"},{"location":"utils/#RDKitMinimalLib.disable_logging","page":"Utils","title":"RDKitMinimalLib.disable_logging","text":"disable_logging()\n\nDisable RDKit logging.\n\ndisable_logging()\n\n\n\n\n\n","category":"function"}]
}
