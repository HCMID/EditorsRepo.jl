# Run this from repository root, e.g. with
# 
#    julia --color=yes --project=docs/ docs/make.jl
#
# Serve from repository root with:
#
#   julia -e 'using LiveServer; serve(dir="docs/build"' 
# 
using Pkg
Pkg.activate(".")
Pkg.instantiate()


using Documenter, DocStringExtensions
using EditorsRepo

makedocs(
    sitename = "EditorsRepo",
    pages = [
        "Home" => "index.md"
      
    ]
)

deploydocs(
    repo = "github.com/HCMID/EditorsRepo.jl.git",
)    