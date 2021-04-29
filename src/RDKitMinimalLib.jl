module RDKitMinimalLib

using RDKit_jll
using JSON

export get_mol,
       get_qmol,
       get_smiles,
       get_smarts,
       get_cxsmiles,
       get_molblock,
       get_v3kmolblock,
       get_json,
       get_inchi,
       get_inchi_for_molblock,
       get_inchikey_for_inchi,
       get_svg,
       # descriptors
       get_morgan_fp,
       get_rdkit_fp,
       get_pattern_fp,
       get_descriptors,
       # standardise
       cleanup,
       normalize,
       canonical_tautomer,
       charge_parent,
       reionize,
       neutralize,
       fragment_parent,
       # transforms
       prefer_coordgen,
       set_2d_coords,
       set_2d_coords_aligned,
       set_3d_coords,
       add_hs,
       remove_all_hs,
       # substruct
       get_substruct_match,
       get_substruct_matches,
       # utils
       enable_logging,
       disable_logging,
       version



include("utils.jl")
include("io.jl")
include("transforms.jl")
include("standardise.jl")
include("substruct.jl")
include("descriptors.jl")

end # module
