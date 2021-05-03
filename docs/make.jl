push!(LOAD_PATH,"../src/")
using Documenter, RDKitMinimalLib


makedocs(
    sitename="RDKitMinimalLib.jl",
    pages=[
        "Home" => "index.md",
        "RDKitMinimalLib" => [
            "I/O" => "io.md",
            "Calculators" => "calculators.md",
            "Coordinates" => "coordinates.md",
            "Drawing" => "drawing.md",
            "Modification" => "modification.md",
            "Substructure" => "substructure.md",
            "Utils" => "utils.md",
        ],
    ],
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true"
    )
)

deploydocs(
    #options
    repo="github.com/eloyfelix/RDKitMinimalLib.jl.git",
    devbranch = "main"
)
