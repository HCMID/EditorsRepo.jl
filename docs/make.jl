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
        "Walk through: validating work in progress" => [
            "guide/repository.md",
            "guide/cataloging.md",
            "guide/surfaces.md",
            "guide/dsecompleteness.md",
            "guide/dseaccuracy.md",
            "guide/orthography.md"
        ],
        "API documentation" => [
            "man/index.md",
            "man/textcatalog.md",
            "man/texts.md",
            "man/dse.md"
        ]
    ]
)

deploydocs(
    repo = "github.com/HCMID/EditorsRepo.jl.git",
)    