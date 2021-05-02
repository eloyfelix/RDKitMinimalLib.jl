
function prefer_coordgen(val::Int64)
    ccall((:prefer_coordgen, librdkitcffi), Cvoid, (Cshort,), Cshort(val))
end

function set_2d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:set_2d_coords, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}), mol.mol, mol.mol_size)
end

function set_2d_coords_aligned(mol::Mol, template_mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:set_2d_coords_aligned, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}, Ref{Cstring}, Csize_t), mol.mol, mol.mol_size, template_mol.mol, template_mol.mol_size)
end

function set_3d_coords(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:set_3d_coords, librdkitcffi), Cshort, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end
