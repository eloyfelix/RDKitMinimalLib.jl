module RDKitMinimalLib

using RDKit_jll
using JSON

export # io
       get_mol,
       get_qmol,
       get_rxn,
       get_smiles,
       get_smarts,
       get_cxsmiles,
       get_molblock,
       get_v3kmolblock,
       get_json,
       get_inchi,
       get_inchi_for_molblock,
       get_inchikey_for_inchi,
       # drawing
       get_svg,
       get_rxn_svg,
       # calculators
       get_morgan_fp,
       get_rdkit_fp,
       get_pattern_fp,
       get_morgan_fp_as_bytes,
       get_rdkit_fp_as_bytes,
       get_pattern_fp_as_bytes,
       get_atom_pair_fp,
       get_atom_pair_fp_as_bytes,
       get_topological_torsion_fp,
       get_topological_torsion_fp_as_bytes,
       get_descriptors,
       # standardization
       cleanup,
       normalize,
       canonical_tautomer,
       charge_parent,
       reionize,
       neutralize,
       fragment_parent,
       # coordinates
       prefer_coordgen,
       set_2d_coords,
       set_2d_coords_aligned,
       set_3d_coords,
       # modification
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
include("drawing.jl")
include("calculators.jl")
include("standardization.jl")
include("coordinates.jl")
include("modification.jl")
include("substructure.jl")

end # module
