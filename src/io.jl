
mutable struct Mol
    mol::Ref{Cstring}
    mol_size::Ref{Csize_t}
    function Mol(mol::Cstring, mol_size::Ref{Csize_t})
        objref = Ref{Cstring}(mol)
        x = new(objref, mol_size)
        finalizer(x -> ccall((:free_ptr, librdkitcffi), Cvoid, (Cstring,), x.mol[]), x)
    end
end

function get_mol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Mol
    details_json::String = jsonify_details(details)
    mol_size = Ref{Csize_t}()
    val = ccall((:get_mol, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), mol_string, mol_size, details_json)
    if val == C_NULL
        error("error parsing the molecule, use enable_logging() to get more info")
    end
    mol = Mol(val, mol_size)
    return mol
end

function get_qmol(mol_string::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::Mol
    details_json::String = jsonify_details(details)
    mol_size = Ref{Csize_t}()
    val = ccall((:get_qmol, librdkitcffi), Cstring, (Cstring, Ref{Csize_t}, Cstring), mol_string, mol_size, details_json)
    if val == C_NULL
        error("error parsing the molecule, use enable_logging() to get more info")
    end
    mol = Mol(val, mol_size)
    return mol
end

function get_smiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_smiles, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_smarts(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_smarts, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_cxsmiles(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_cxsmiles, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_molblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_molblock, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_v3kmolblock(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_v3kmolblock, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_json(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_json, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_inchi(mol::Mol, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_inchi, librdkitcffi), Cstring, (Cstring, Csize_t, Cstring), mol.mol[], mol.mol_size[], details_json)
    return unsafe_string(val)
end

function get_inchi_for_molblock(molblock::AbstractString, details::Union{Dict{String,Any},Nothing}=nothing)::String
    details_json::String = jsonify_details(details)
    val = ccall((:get_inchi_for_molblock, librdkitcffi), Cstring, (Cstring, Cstring), molblock, details_json)
    return unsafe_string(val)
end

function get_inchikey_for_inchi(inchi::AbstractString)
    val = ccall((:get_inchikey_for_inchi, librdkitcffi), Cstring, (Cstring,), inchi)
    return unsafe_string(val)
end
