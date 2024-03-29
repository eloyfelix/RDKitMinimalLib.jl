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
    @test mol.mol_size[] == 0x000000000000038e
    @test isnothing(get_mol("CC(=O)Oc1cccc1C(=O)O"))
    qmol = get_qmol("c1ccccc1")
    @test qmol.mol_size[] == 0x000000000000023f
    rxn = get_rxn("[CH3:1][OH:2]>>[CH2:1]=[OH0:2]")
    @test rxn.rxn_size[] == 0x0000000000000269
    @test isnothing(get_rxn("[CH3:1][OH:2]>>>[CH2:1]=[OH0:2]"))
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

    mol = get_mol("c1ccccc1")
    qmol = get_qmol("c")
    smatches = get_substruct_matches(mol, qmol)
    @test occursin("width='350px'", get_svg(mol, smatches, Dict{String,Any}("height" => 300, "width" => 350)))

    rxn = get_rxn("[CH3:1][OH:2]>>[CH2:1]=[OH0:2]")
    @test occursin("width='350px'", get_rxn_svg(rxn, Dict{String,Any}("height" => 300, "width" => 350)))
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

    @test get_atom_pair_fp(mol, fp_details) == "1110111011101100110011001110111111111110110000001000100011111110"
    @test count(i -> (i == '1'), get_atom_pair_fp(mol)) == 68
    tb = get_atom_pair_fp_as_bytes(mol)
    @test sum([count_ones(b) for b in tb]) == 68

    @test get_topological_torsion_fp(mol, fp_details) == "1000000000001100100011001000100000001000000010001110100011100000"
    @test count(i -> (i == '1'), get_topological_torsion_fp(mol)) == 18
    tb = get_topological_torsion_fp_as_bytes(mol)
    @test sum([count_ones(b) for b in tb]) == 18

    @test get_descriptors(mol) == Dict{String, Any}("CrippenMR" => 44.7103, "lipinskiHBD" => 1.0, "kappa1" => 9.2496, "kappa3" => 2.29741, "NumHBD" => 1.0, "NumSpiroAtoms" => 0.0, "chi1n" => 3.61745, "FractionCSP3" => 0.11111, "chi0n" => 6.98135, "NumUnspecifiedAtomStereoCenters" => 0.0, "NumAmideBonds" => 0.0, "NumAromaticHeterocycles" => 0.0, "NumAtoms" => 21.0, "tpsa" => 63.6, "NumHeteroatoms" => 4.0, "Phi" => 2.63916, "exactmw" => 180.04225, "hallKierAlpha" => -1.83999, "CrippenClogP" => 1.31009, "chi3v" => 1.37115, "NumSaturatedHeterocycles" => 0.0, "NumAromaticRings" => 1.0, "labuteASA" => 74.75705, "amw" => 180.15899, "NumAliphaticHeterocycles" => 0.0, "NumAtomStereoCenters" => 0.0, "chi4v" => 0.88717, "NumRotatableBonds" => 2.0, "lipinskiHBA" => 4.0, "NumRings" => 1.0, "chi0v" => 6.98135, "NumHeterocycles" => 0.0, "NumHeavyAtoms" => 13.0, "chi3n" => 1.37115, "chi1v" => 3.61745, "NumBridgeheadAtoms" => 0.0, "kappa2" => 3.70925, "chi2n" => 1.37115, "NumHBA" => 3.0, "chi4n" => 0.88717, "NumSaturatedRings" => 0.0, "NumAliphaticRings" => 0.0, "chi2v" => 1.37115)
end

@testset "standardization" begin
    # normalize (sulfoxide)
    mol = get_mol("CS(C)=O")
    normalize(mol)
    smiles = get_smiles(mol)
    @test smiles == "C[S+](C)[O-]"

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
    val = set_3d_coords(mol)
    @test val == 1
    @test occursin("RDKit          3D", get_molblock(mol))
    val = set_2d_coords(mol)
    @test val == 1
    @test occursin("RDKit          2D", get_molblock(mol))

    mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
    set_3d_coords(mol)
    template = get_mol("CC(=O)Nc1ccc(O)cc1")
    set_2d_coords(template)
    val = set_2d_coords_aligned(mol, template)
    @test val == 1
    @test occursin("RDKit          2D", get_molblock(mol))

    @test has_coords(mol) == 1
    mol = get_mol("CC(=O)Oc1ccccc1C(=O)O")
    @test has_coords(mol) == 0
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
    qmol = get_qmol("[CH3]~[CH2]~*")
    mol = get_mol("COc1cc(C=O)ccc1O")
    @test get_substruct_matches(mol, qmol) == Dict{String, Any}()
end


@testset "utils" begin
    @test isempty(version()) == false
end
