# Run this from repository root, e.g. with
# 
#    julia --color=yes --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()


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
            "man/index.md",
            "man/textcatalog.md"
        ]
    ]
)

deploydocs(
    repo = "github.com/HCMID/EditorsRepo.jl.git",
)    