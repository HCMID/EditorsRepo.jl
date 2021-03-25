using Pkg
Pkg.activate(".")
Pkg.instantiate()
push!(LOAD_PATH,"../")


using Documenter, DocStringExtensions
using EditorsRepo

makedocs(
    sitename = "EditorsRepo",
    pages = [
        "Home" => "index.md",
        "Guide" => [
            "guide/guide.md"
        ],
        "API documentation" => [
            "man/index.md"
        ]
    ]
)

deploydocs(
    repo = "github.com/HCMID/Orthography.jl.git",
)    