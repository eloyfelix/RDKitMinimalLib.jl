
function cleanup(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:cleanup, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

function normalize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:normalize, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

function canonical_tautomer(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:canonical_tautomer, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

function charge_parent(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:charge_parent, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

function reionize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:reionize, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

function neutralize(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:neutralize, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end

function fragment_parent(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = jsonify_details(details)
    ccall((:fragment_parent, librdkitcffi), Cvoid, (Ref{Cstring}, Ref{Csize_t}, Cstring), mol.mol, mol.mol_size, details_json)
end
