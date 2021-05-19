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
    @test occursin("width='350px'", get_svg(mol, Dict{String,Any}("height" => 300, "width" => 350)))

    qmol = get_qmol("c1ccccc1")
    smatch = get_substruct_match(mol, qmol)
    @test occursin("fill:#FF7F7F", get_svg(mol, smatch))
end

@testset "calculators" begin
    mol = get_mol(molblockv2000)
    fp_details = Dict{String,Any}("nBits" => 64, "radius" => 2)

    @test get_morgan_fp(mol, fp_details) == "1110010110110100110000110000000001001001000000010010000101001100"
    @test count(i -> (i == '1'), get_morgan_fp(mol)) == 24
    tb = get_morgan_fp_as_bytes(mol)
    @test sum([count_ones(b) for b in tb]) == 24

    @test get_rdkit_fp(mol, fp_details) == "1111111111111111111111111111111111111111111111111111111111111111"
    @test count(i -> (i == '1'), get_rdkit_fp(mol)) == 354
    tb = get_rdkit_fp_as_bytes(mol)
    @test sum([count_ones(b) for b in tb]) == 354

    @test get_pattern_fp(mol, fp_details) == "1111111111111101111111111111111011011111111111111111111111111111"
    @test count(i -> (i == '1'), get_pattern_fp(mol)) == 173
    tb = get_pattern_fp_as_bytes(mol)
    @test sum([count_ones(b) for b in tb]) == 173

    @test get_descriptors(mol) == Dict{String,Any}("lipinskiHBA" => 4.0, "lipinskiHBD" => 1.0, "NumAromaticRings" => 1.0, "NumRings" => 1.0, "NumAromaticHeterocycles" => 0.0, "CrippenMR" => 44.7103, "labuteASA" => 74.75705, "NumHeterocycles" => 0.0, "chi0v" => 6.98135, "tpsa" => 63.6, "kappa1" => 9.2496, "chi3n" => 1.37115, "NumHeteroatoms" => 4.0, "chi1v" => 3.61745, "NumBridgeheadAtoms" => 0.0, "NumHBD" => 1.0, "kappa2" => 3.70925, "kappa3" => 2.29741, "NumSpiroAtoms" => 0.0, "Phi" => 2.63916, "chi1n" => 3.61745, "chi2n" => 1.37115, "NumHBA" => 3.0, "FractionCSP3" => 0.11111, "chi4n" => 0.88717, "chi0n" => 6.98135, "NumUnspecifiedAtomStereoCenters" => 0.0, "exactmw" => 180.04225, "amw" => 180.15899, "NumSaturatedRings" => 0.0, "NumAliphaticHeterocycles" => 0.0, "hallKierAlpha" => -1.83999, "NumAtomStereoCenters" => 0.0, "CrippenClogP" => 1.31009, "chi4v" => 0.88717, "NumAliphaticRings" => 0.0, "NumRotatableBonds" => 2.0, "chi2v" => 1.37115, "NumAmideBonds" => 0.0, "NumSaturatedHeterocycles" => 0.0, "chi3v" => 1.37115)
end

@testset "standardization" begin
    # cleanup
    mol = get_mol("[Pt]CCN(=O)=O", Dict{String,Any}("sanitize" => false))
    smiles = get_smiles(mol)
    @test smiles == "O=N(=O)CC[Pt]"
    cleanup(mol)
    smiles = get_smiles(mol)
    @test smiles == "[CH2-]C[N+](=O)[O-].[Pt+]"

    # fragment_parent
    fragment_parent(mol)
    smiles = get_smiles(mol)
    @test smiles == "[CH2-]C[N+](=O)[O-]"

    # charge_parent
    charge_parent(mol)
    smiles = get_smiles(mol)
    @test smiles == "CC[N+](=O)[O-]"

    mol = get_mol("[Pt]CCN(=O)=O", Dict{String,Any}("sanitize" => false))
    charge_parent(mol)
    smiles = get_smiles(mol)
    @test smiles == "CC[N+](=O)[O-]"

    mol = get_mol("[Pt]CCN(=O)=O", Dict{String,Any}("sanitize" => false))
    charge_parent(mol, Dict{String,Any}("skipStandardize" => true))
    smiles = get_smiles(mol)
    @test smiles == "[CH2-]C[N+](=O)[O-].[Pt+]"

    # neutralize
    mol = get_mol("[CH2-]CN(=O)=O", Dict{String,Any}("sanitize" => false))
    neutralize(mol)
    smiles = get_smiles(mol)
    @test smiles == "CCN(=O)=O"

    # reionize
    mol = get_mol("[O-]c1cc(C(=O)O)ccc1")
    reionize(mol)
    smiles = get_smiles(mol)
    @test smiles == "O=C([O-])c1cccc(O)c1"

    # canonical_tautomer
    mol = get_mol("OC(O)C(=N)CO")
    canonical_tautomer(mol)
    smiles = get_smiles(mol)
    @test smiles == "NC(CO)C(=O)O"
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
    @test get_substruct_match(mol, qmol) == Dict{String,Any}("bonds" => Any[4, 5, 6, 7, 8, 12], "atoms" => Any[4, 5, 6, 7, 8, 9])
    @test get_substruct_matches(mol, qmol) == Any[Dict{String,Any}("bonds" => Any[4, 5, 6, 7, 8, 12], "atoms" => Any[4, 5, 6, 7, 8, 9])]
end
