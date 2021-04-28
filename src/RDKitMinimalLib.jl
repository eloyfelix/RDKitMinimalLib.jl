module RDKitMinimalLib

using RDKit_jll
using JSON

export get_inchi_for_molblock,
       get_inchikey_for_inchi,
       get_mol,
       get_smiles,
       get_morgan_fp,
       get_descriptors,
       get_svg

mutable struct Mol
    mol::Ptr{Cvoid}
    mol_size::Csize_t
    function Mol(mol::Ptr{Cvoid}, mol_size::Csize_t)
        x = new(mol, mol_size)
        finalizer(x -> free_mol_ptr(x.mol), x)
    end
end

function parse_details(details::Union{Dict{String,Any},Nothing})
    if isnothing(details)
        str_details = ""
    else
        str_details = JSON.json(details)
    end
end

function get_inchi_for_molblock(molblock::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = parse_details(details)
    val = ccall((:get_inchi_for_molblock, librdkitcffi), Cstring, (Cstring, Cstring), molblock, details_json)
    return unsafe_string(val)
end

function get_inchikey_for_inchi(inchi::AbstractString)
    val = ccall((:get_inchikey_for_inchi, librdkitcffi), Cstring, (Cstring,), inchi)
    return unsafe_string(val)
end

function get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = parse_details(details)
    mol_size = Ref{Csize_t}(0)
    val = ccall((:get_mol, librdkitcffi), Ptr{Cvoid}, (Cstring, Ptr{Csize_t}, Cstring), mol_string, mol_size, details_json)
    mol = Mol(val, mol_size[])
    return mol
end

function free_mol_ptr(mol::Ptr{Cvoid})
    ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), mol)
end

function get_smiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = parse_details(details)
    val = ccall((:get_smiles, librdkitcffi), Cstring, (Ptr{Cvoid}, Csize_t, Cstring), mol.mol, mol.mol_size, details_json)
    return unsafe_string(val)
end

function get_morgan_fp(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = parse_details(details)
    val = ccall((:get_morgan_fp, librdkitcffi), Cstring, (Ptr{Cvoid}, Csize_t, Cstring), mol.mol, mol.mol_size, details_json)
    return unsafe_string(val)
end

function get_descriptors(mol::Mol)
    val = ccall((:get_descriptors, librdkitcffi), Cstring, (Ptr{Cvoid}, Csize_t), mol.mol, mol.mol_size)
    return JSON.parse(unsafe_string(val))
end

function get_svg(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)
    details_json::String = parse_details(details)
    val = ccall((:get_svg, librdkitcffi), Cstring, (Ptr{Cvoid}, Csize_t, Cstring), mol.mol, mol.mol_size, details_json)
    return unsafe_string(val)
end

end # module
