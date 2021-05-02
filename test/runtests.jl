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
    qmol = get_qmol("c1ccccc1")
    smatch = get_substruct_match(mol, qmol)
    @test get_svg(mol, smatch) == "<?xml version='1.0' encoding='iso-8859-1'?>\n<svg version='1.1' baseProfile='full'\n              xmlns='http://www.w3.org/2000/svg'\n                      xmlns:rdkit='http://www.rdkit.org/xml'\n                      xmlns:xlink='http://www.w3.org/1999/xlink'\n                  xml:space='preserve'\nwidth='250px' height='200px' viewBox='0 0 250 200'>\n<!-- END OF HEADER -->\n<rect style='opacity:1.0;fill:#FFFFFF;stroke:none' width='250' height='200' x='0' y='0'> </rect>\n<path d='M 64.8598,72.8902 L 64.8073,109.079' style='fill:none;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:14.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path d='M 64.8598,72.8902 L 95.9961,54.8331' style='fill:none;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:14.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path d='M 64.8073,109.079 L 96.0749,127.136' style='fill:none;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:14.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path d='M 96.0749,127.136 L 127.412,109.057' style='fill:none;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:14.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path d='M 127.412,109.057 L 127.286,72.7327' style='fill:none;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:14.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path d='M 127.286,72.7327 L 95.9961,54.8331' style='fill:none;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:14.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<ellipse cx='64.8598' cy='72.8902' rx='13.1229' ry='13.1229'  style='fill:#FF7F7F;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:1.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<ellipse cx='64.8073' cy='109.079' rx='13.1229' ry='13.1229'  style='fill:#FF7F7F;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:1.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<ellipse cx='96.0749' cy='127.136' rx='13.1229' ry='13.1229'  style='fill:#FF7F7F;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:1.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<ellipse cx='127.412' cy='109.057' rx='13.1229' ry='13.1229'  style='fill:#FF7F7F;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:1.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<ellipse cx='127.286' cy='72.7327' rx='13.1229' ry='13.1229'  style='fill:#FF7F7F;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:1.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<ellipse cx='95.9961' cy='54.8331' rx='13.1229' ry='13.1229'  style='fill:#FF7F7F;fill-rule:evenodd;stroke:#FF7F7F;stroke-width:1.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-0 atom-0 atom-1' d='M 64.8598,72.8902 L 64.8073,109.079' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-0 atom-0 atom-1' d='M 72.7257,78.3299 L 72.6889,103.662' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-11 atom-5 atom-0' d='M 95.9961,54.8331 L 64.8598,72.8902' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-7 atom-1 atom-2' d='M 64.8073,109.079 L 96.0749,127.136' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-2 atom-2 atom-3' d='M 96.0749,127.136 L 127.412,109.057' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-2 atom-2 atom-3' d='M 96.8409,117.604 L 118.777,104.949' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-4 atom-3 atom-8' d='M 127.412,109.057 L 139.401,115.955' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-4 atom-3 atom-8' d='M 139.401,115.955 L 151.389,122.853' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-5 atom-3 atom-4' d='M 127.412,109.057 L 127.286,72.7327' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-1 atom-4 atom-6' d='M 127.286,72.7327 L 158.47,54.5706' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-9 atom-4 atom-5' d='M 127.286,72.7327 L 95.9961,54.8331' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-9 atom-4 atom-5' d='M 118.682,76.8822 L 96.7798,64.3525' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 156.514,57.9873 L 168.522,64.861' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 168.522,64.861 L 180.53,71.7348' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 160.426,51.1539 L 172.434,58.0277' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 172.434,58.0277 L 184.442,64.9014' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-12 atom-6 atom-12' d='M 158.47,54.5706 L 158.416,40.6116' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-12 atom-6 atom-12' d='M 158.416,40.6116 L 158.362,26.6526' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-6 atom-8 atom-9' d='M 158.702,135.219 L 158.724,149.178' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-6 atom-8 atom-9' d='M 158.724,149.178 L 158.746,163.137' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-8 atom-9 atom-10' d='M 158.746,163.137 L 190.022,181.124' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 156.772,159.73 L 144.812,166.659' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 144.812,166.659 L 132.852,173.589' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 160.719,166.543 L 148.759,173.472' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 148.759,173.472 L 136.799,180.402' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path  class='atom-7' d='M 183.388 72.5359\nQ 183.388 69.1895, 185.042 67.3195\nQ 186.695 65.4495, 189.786 65.4495\nQ 192.876 65.4495, 194.53 67.3195\nQ 196.183 69.1895, 196.183 72.5359\nQ 196.183 75.9216, 194.51 77.8507\nQ 192.837 79.7601, 189.786 79.7601\nQ 186.715 79.7601, 185.042 77.8507\nQ 183.388 75.9413, 183.388 72.5359\nM 189.786 78.1853\nQ 191.912 78.1853, 193.053 76.768\nQ 194.215 75.3311, 194.215 72.5359\nQ 194.215 69.7998, 193.053 68.4219\nQ 191.912 67.0243, 189.786 67.0243\nQ 187.66 67.0243, 186.498 68.4022\nQ 185.357 69.7801, 185.357 72.5359\nQ 185.357 75.3508, 186.498 76.768\nQ 187.66 78.1853, 189.786 78.1853\n' fill='#FF0000'/>\n<path  class='atom-8' d='M 152.291 127.092\nQ 152.291 123.746, 153.945 121.876\nQ 155.598 120.006, 158.689 120.006\nQ 161.779 120.006, 163.433 121.876\nQ 165.086 123.746, 165.086 127.092\nQ 165.086 130.478, 163.413 132.407\nQ 161.74 134.316, 158.689 134.316\nQ 155.618 134.316, 153.945 132.407\nQ 152.291 130.498, 152.291 127.092\nM 158.689 132.742\nQ 160.815 132.742, 161.956 131.324\nQ 163.118 129.887, 163.118 127.092\nQ 163.118 124.356, 161.956 122.978\nQ 160.815 121.581, 158.689 121.581\nQ 156.563 121.581, 155.401 122.959\nQ 154.26 124.336, 154.26 127.092\nQ 154.26 129.907, 155.401 131.324\nQ 156.563 132.742, 158.689 132.742\n' fill='#FF0000'/>\n<path  class='atom-11' d='M 121.129 181.264\nQ 121.129 177.917, 122.782 176.047\nQ 124.436 174.177, 127.526 174.177\nQ 130.617 174.177, 132.27 176.047\nQ 133.924 177.917, 133.924 181.264\nQ 133.924 184.649, 132.25 186.579\nQ 130.577 188.488, 127.526 188.488\nQ 124.455 188.488, 122.782 186.579\nQ 121.129 184.669, 121.129 181.264\nM 127.526 186.913\nQ 129.652 186.913, 130.794 185.496\nQ 131.955 184.059, 131.955 181.264\nQ 131.955 178.528, 130.794 177.15\nQ 129.652 175.752, 127.526 175.752\nQ 125.4 175.752, 124.239 177.13\nQ 123.097 178.508, 123.097 181.264\nQ 123.097 184.079, 124.239 185.496\nQ 125.4 186.913, 127.526 186.913\n' fill='#FF0000'/>\n<path  class='atom-12' d='M 151.933 18.5263\nQ 151.933 15.1799, 153.586 13.3099\nQ 155.24 11.4399, 158.33 11.4399\nQ 161.421 11.4399, 163.074 13.3099\nQ 164.727 15.1799, 164.727 18.5263\nQ 164.727 21.912, 163.054 23.8411\nQ 161.381 25.7505, 158.33 25.7505\nQ 155.259 25.7505, 153.586 23.8411\nQ 151.933 21.9317, 151.933 18.5263\nM 158.33 24.1757\nQ 160.456 24.1757, 161.598 22.7584\nQ 162.759 21.3215, 162.759 18.5263\nQ 162.759 15.7902, 161.598 14.4123\nQ 160.456 13.0147, 158.33 13.0147\nQ 156.204 13.0147, 155.043 14.3926\nQ 153.901 15.7705, 153.901 18.5263\nQ 153.901 21.3412, 155.043 22.7584\nQ 156.204 24.1757, 158.33 24.1757\n' fill='#FF0000'/>\n<path  class='atom-12' d='M 166.401 11.5974\nL 168.29 11.5974\nL 168.29 17.5224\nL 175.416 17.5224\nL 175.416 11.5974\nL 177.306 11.5974\nL 177.306 25.5339\nL 175.416 25.5339\nL 175.416 19.0971\nL 168.29 19.0971\nL 168.29 25.5339\nL 166.401 25.5339\nL 166.401 11.5974\n' fill='#FF0000'/>\n</svg>\n"
    @test get_svg(mol) == "<?xml version='1.0' encoding='iso-8859-1'?>\n<svg version='1.1' baseProfile='full'\n              xmlns='http://www.w3.org/2000/svg'\n                      xmlns:rdkit='http://www.rdkit.org/xml'\n                      xmlns:xlink='http://www.w3.org/1999/xlink'\n                  xml:space='preserve'\nwidth='250px' height='200px' viewBox='0 0 250 200'>\n<!-- END OF HEADER -->\n<rect style='opacity:1.0;fill:#FFFFFF;stroke:none' width='250' height='200' x='0' y='0'> </rect>\n<path class='bond-0 atom-0 atom-1' d='M 58.2983,72.8902 L 58.2458,109.079' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-0 atom-0 atom-1' d='M 66.1642,78.3299 L 66.1275,103.662' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-11 atom-5 atom-0' d='M 89.4347,54.8331 L 58.2983,72.8902' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-7 atom-1 atom-2' d='M 58.2458,109.079 L 89.5134,127.136' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-2 atom-2 atom-3' d='M 89.5134,127.136 L 120.851,109.057' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-2 atom-2 atom-3' d='M 90.2794,117.604 L 112.216,104.949' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-4 atom-3 atom-8' d='M 120.851,109.057 L 132.839,115.955' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-4 atom-3 atom-8' d='M 132.839,115.955 L 144.828,122.853' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-5 atom-3 atom-4' d='M 120.851,109.057 L 120.724,72.7327' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-1 atom-4 atom-6' d='M 120.724,72.7327 L 151.909,54.5706' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-9 atom-4 atom-5' d='M 120.724,72.7327 L 89.4347,54.8331' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-9 atom-4 atom-5' d='M 112.121,76.8822 L 90.2183,64.3525' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 149.953,57.9873 L 161.961,64.861' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 161.961,64.861 L 173.969,71.7348' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 153.864,51.1539 L 165.872,58.0277' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-3 atom-6 atom-7' d='M 165.872,58.0277 L 177.881,64.9014' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-12 atom-6 atom-12' d='M 151.909,54.5706 L 151.854,40.6116' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-12 atom-6 atom-12' d='M 151.854,40.6116 L 151.8,26.6526' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-6 atom-8 atom-9' d='M 152.14,135.219 L 152.162,149.178' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-6 atom-8 atom-9' d='M 152.162,149.178 L 152.184,163.137' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-8 atom-9 atom-10' d='M 152.184,163.137 L 183.46,181.124' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 150.211,159.73 L 138.251,166.659' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 138.251,166.659 L 126.291,173.589' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 154.158,166.543 L 142.198,173.472' style='fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path class='bond-10 atom-9 atom-11' d='M 142.198,173.472 L 130.238,180.402' style='fill:none;fill-rule:evenodd;stroke:#FF0000;stroke-width:2.0px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1' />\n<path  class='atom-7' d='M 176.827 72.5359\nQ 176.827 69.1895, 178.48 67.3195\nQ 180.134 65.4495, 183.224 65.4495\nQ 186.315 65.4495, 187.968 67.3195\nQ 189.622 69.1895, 189.622 72.5359\nQ 189.622 75.9216, 187.949 77.8507\nQ 186.275 79.7601, 183.224 79.7601\nQ 180.153 79.7601, 178.48 77.8507\nQ 176.827 75.9413, 176.827 72.5359\nM 183.224 78.1853\nQ 185.35 78.1853, 186.492 76.768\nQ 187.653 75.3311, 187.653 72.5359\nQ 187.653 69.7998, 186.492 68.4219\nQ 185.35 67.0243, 183.224 67.0243\nQ 181.098 67.0243, 179.937 68.4022\nQ 178.795 69.7801, 178.795 72.5359\nQ 178.795 75.3508, 179.937 76.768\nQ 181.098 78.1853, 183.224 78.1853\n' fill='#FF0000'/>\n<path  class='atom-8' d='M 145.73 127.092\nQ 145.73 123.746, 147.383 121.876\nQ 149.037 120.006, 152.127 120.006\nQ 155.218 120.006, 156.871 121.876\nQ 158.525 123.746, 158.525 127.092\nQ 158.525 130.478, 156.852 132.407\nQ 155.178 134.316, 152.127 134.316\nQ 149.057 134.316, 147.383 132.407\nQ 145.73 130.498, 145.73 127.092\nM 152.127 132.742\nQ 154.253 132.742, 155.395 131.324\nQ 156.556 129.887, 156.556 127.092\nQ 156.556 124.356, 155.395 122.978\nQ 154.253 121.581, 152.127 121.581\nQ 150.001 121.581, 148.84 122.959\nQ 147.698 124.336, 147.698 127.092\nQ 147.698 129.907, 148.84 131.324\nQ 150.001 132.742, 152.127 132.742\n' fill='#FF0000'/>\n<path  class='atom-11' d='M 114.567 181.264\nQ 114.567 177.917, 116.221 176.047\nQ 117.874 174.177, 120.965 174.177\nQ 124.055 174.177, 125.709 176.047\nQ 127.362 177.917, 127.362 181.264\nQ 127.362 184.649, 125.689 186.579\nQ 124.016 188.488, 120.965 188.488\nQ 117.894 188.488, 116.221 186.579\nQ 114.567 184.669, 114.567 181.264\nM 120.965 186.913\nQ 123.091 186.913, 124.232 185.496\nQ 125.394 184.059, 125.394 181.264\nQ 125.394 178.528, 124.232 177.15\nQ 123.091 175.752, 120.965 175.752\nQ 118.839 175.752, 117.677 177.13\nQ 116.536 178.508, 116.536 181.264\nQ 116.536 184.079, 117.677 185.496\nQ 118.839 186.913, 120.965 186.913\n' fill='#FF0000'/>\n<path  class='atom-12' d='M 145.371 18.5263\nQ 145.371 15.1799, 147.025 13.3099\nQ 148.678 11.4399, 151.769 11.4399\nQ 154.859 11.4399, 156.513 13.3099\nQ 158.166 15.1799, 158.166 18.5263\nQ 158.166 21.912, 156.493 23.8411\nQ 154.82 25.7505, 151.769 25.7505\nQ 148.698 25.7505, 147.025 23.8411\nQ 145.371 21.9317, 145.371 18.5263\nM 151.769 24.1757\nQ 153.895 24.1757, 155.036 22.7584\nQ 156.198 21.3215, 156.198 18.5263\nQ 156.198 15.7902, 155.036 14.4123\nQ 153.895 13.0147, 151.769 13.0147\nQ 149.643 13.0147, 148.481 14.3926\nQ 147.34 15.7705, 147.34 18.5263\nQ 147.34 21.3412, 148.481 22.7584\nQ 149.643 24.1757, 151.769 24.1757\n' fill='#FF0000'/>\n<path  class='atom-12' d='M 159.839 11.5974\nL 161.729 11.5974\nL 161.729 17.5224\nL 168.855 17.5224\nL 168.855 11.5974\nL 170.744 11.5974\nL 170.744 25.5339\nL 168.855 25.5339\nL 168.855 19.0971\nL 161.729 19.0971\nL 161.729 25.5339\nL 159.839 25.5339\nL 159.839 11.5974\n' fill='#FF0000'/>\n</svg>\n"
end

@testset "calculators" begin
    mol = get_mol(molblockv2000)
    fp_details = Dict{String, Any}("nBits" => 64, "radius" => 2)

    @test get_morgan_fp(mol, fp_details) == "1110010110110100110000110000000001001001000000010010000101001100"
    @test count(i->(i=='1'), get_morgan_fp(mol)) == 24

    @test get_rdkit_fp(mol, fp_details) == "1111111111111111111111111111111111111111111111111111111111111111"
    @test count(i->(i=='1'), get_rdkit_fp(mol)) == 354

    @test get_pattern_fp(mol, fp_details) == "1111111111111101111111111111111011011111111111111111111111111111"
    @test count(i->(i=='1'), get_pattern_fp(mol)) == 173

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
    @test get_substruct_matches(mol, qmol) == Dict{String, Any}("bonds" => Any[4, 5, 6, 7, 8, 12], "atoms" => Any[4, 5, 6, 7, 8, 9])
end
