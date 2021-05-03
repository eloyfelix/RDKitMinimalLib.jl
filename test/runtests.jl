using Test, RDKitMinimalLib

molblockv2000 = """

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

molblockv3000 = """

     RDKit          2D

  0  0  0  0  0  0  0  0  0  0999 V3000
M  V30 BEGIN CTAB
M  V30 COUNTS 13 13 0 0 0
M  V30 BEGIN ATOM
M  V30 1 C 8.881000 -2.120600 0.000000 0
M  V30 2 C 8.879800 -2.947900 0.000000 0
M  V30 3 C 9.594600 -3.360700 0.000000 0
M  V30 4 C 10.311000 -2.947400 0.000000 0
M  V30 5 C 10.308100 -2.117000 0.000000 0
M  V30 6 C 9.592800 -1.707800 0.000000 0
M  V30 7 C 11.021000 -1.701800 0.000000 0
M  V30 8 O 11.736900 -2.111600 0.000000 0
M  V30 9 O 11.026000 -3.358800 0.000000 0
M  V30 10 C 11.027300 -4.183700 0.000000 0
M  V30 11 C 11.742300 -4.594900 0.000000 0
M  V30 12 O 10.313600 -4.597200 0.000000 0
M  V30 13 O 11.017800 -0.876900 0.000000 0
M  V30 END ATOM
M  V30 BEGIN BOND
M  V30 1 2 1 2
M  V30 2 1 5 7
M  V30 3 2 3 4
M  V30 4 2 7 8
M  V30 5 1 4 9
M  V30 6 1 4 5
M  V30 7 1 9 10
M  V30 8 1 2 3
M  V30 9 1 10 11
M  V30 10 2 5 6
M  V30 11 2 10 12
M  V30 12 1 6 1
M  V30 13 1 7 13
M  V30 END BOND
M  V30 END CTAB
M  END
"""

@testset "io" begin
    mol = get_mol(molblockv2000)
    @test mol.mol_size[] == 0x000000000000042a
    qmol = get_qmol("c1ccccc1")
    @test qmol.mol_size[] == 0x00000000000001eb 
    @test get_smiles(mol) == "CC(=O)Oc1ccccc1C(=O)O"
    @test get_smarts(qmol) == "c1ccccc1"
    @test get_cxsmiles(mol) == "CC(=O)Oc1ccccc1C(=O)O |(11.7423,-4.5949,;11.0273,-4.1837,;10.3136,-4.5972,;11.026,-3.3588,;10.311,-2.9474,;9.5946,-3.3607,;8.8798,-2.9479,;8.881,-2.1206,;9.5928,-1.7078,;10.3081,-2.117,;11.021,-1.7018,;11.7369,-2.1116,;11.0178,-0.8769,)|"
    @test occursin("V2000", get_molblock(mol))
    @test occursin("V3000", get_v3kmolblock(mol))
    @test occursin("commonchem", get_json(mol))
    @test get_inchi(mol) == "InChI=1S/C9H8O4/c1-6(10)13-8-5-3-2-4-7(8)9(11)12/h2-5H,1H3,(H,11,12)"
    @test get_inchi_for_molblock(molblockv2000) == "InChI=1S/C9H8O4/c1-6(10)13-8-5-3-2-4-7(8)9(11)12/h2-5H,1H3,(H,11,12)"
    @test get_inchikey_for_inchi("InChI=1S/C9H8O4/c1-6(10)13-8-5-3-2-4-7(8)9(11)12/h2-5H,1H3,(H,11,12)") == "BSYNRYMUTXBXSQ-UHFFFAOYSA-N"
end

@testset "drawing" begin
    mol = get_mol(molblockv2000)
    @test occursin("width='350px'", get_svg(mol, Dict{String, Any}("height" => 300, "width" => 350)))

    qmol = get_qmol("c1ccccc1")
    smatch = get_substruct_match(mol, qmol)
    @test occursin("fill:#FF7F7F", get_svg(mol, smatch))
end

@testset "calculators" begin
    mol = get_mol(molblockv2000)
    fp_details = Dict{String, Any}("nBits" => 64, "radius" => 2)

    @test get_morgan_fp(mol, fp_details) == "1110010110110100110000110000000001001001000000010010000101001100"
    @test count(i->(i=='1'), get_morgan_fp(mol)) == 24
    @test length(get_morgan_fp_as_bytes(mol)) == 256

    @test get_rdkit_fp(mol, fp_details) == "1111111111111111111111111111111111111111111111111111111111111111"
    @test count(i->(i=='1'), get_rdkit_fp(mol)) == 354
    @test length(get_rdkit_fp_as_bytes(mol)) == 256

    @test get_pattern_fp(mol, fp_details) == "1111111111111101111111111111111011011111111111111111111111111111"
    @test count(i->(i=='1'), get_pattern_fp(mol)) == 173
    @test length(get_pattern_fp_as_bytes(mol)) == 256

    @test get_descriptors(mol) == Dict{String, Any}("lipinskiHBA" => 4.0, "lipinskiHBD" => 1.0, "NumAromaticRings" => 1.0, "NumRings" => 1.0, "NumAromaticHeterocycles" => 0.0, "CrippenMR" => 44.7103, "labuteASA" => 74.75705, "NumHeterocycles" => 0.0, "chi0v" => 6.98135, "tpsa" => 63.6, "kappa1" => 9.2496, "chi3n" => 1.37115, "NumHeteroatoms" => 4.0, "chi1v" => 3.61745, "NumBridgeheadAtoms" => 0.0, "NumHBD" => 1.0, "kappa2" => 3.70925, "kappa3" => 2.29741, "NumSpiroAtoms" => 0.0, "Phi" => 2.63916, "chi1n" => 3.61745, "chi2n" => 1.37115, "NumHBA" => 3.0, "FractionCSP3" => 0.11111, "chi4n" => 0.88717, "chi0n" => 6.98135, "NumUnspecifiedAtomStereoCenters" => 0.0, "exactmw" => 180.04225, "amw" => 180.15899, "NumSaturatedRings" => 0.0, "NumAliphaticHeterocycles" => 0.0, "hallKierAlpha" => -1.83999, "NumAtomStereoCenters" => 0.0, "CrippenClogP" => 1.31009, "chi4v" => 0.88717, "NumAliphaticRings" => 0.0, "NumRotatableBonds" => 2.0, "chi2v" => 1.37115, "NumAmideBonds" => 0.0, "NumSaturatedHeterocycles" => 0.0, "chi3v" => 1.37115)
end

@testset "coordinates" begin
    mol = get_mol(molblockv2000)
    set_3d_coords(mol)
    @test occursin("RDKit          3D", get_molblock(mol))
    set_2d_coords(mol)
    @test occursin("RDKit          2D", get_molblock(mol))
end

@testset "modification" begin
    mol = get_mol(molblockv2000)
    hcount = occursin("H", get_molblock(mol))
    add_hs(mol)
    @test occursin("H", get_molblock(mol)) > hcount

    remove_all_hs(mol)
    @test occursin("H", get_molblock(mol)) == hcount
end

@testset "substructure" begin
    mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
    qmol = get_qmol("c1ccccc1")
    @test get_substruct_match(mol, qmol) == Dict{String, Any}("bonds" => Any[4, 5, 6, 7, 8, 12], "atoms" => Any[4, 5, 6, 7, 8, 9])
    @test get_substruct_matches(mol, qmol) == Any[Dict{String, Any}("bonds" => Any[4, 5, 6, 7, 8, 12], "atoms" => Any[4, 5, 6, 7, 8, 9])]
end
