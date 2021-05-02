
function add_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:add_hs, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}), mol.mol, mol.mol_size)
end

function remove_all_hs(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:remove_all_hs, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}), mol.mol, mol.mol_size)
end
