using Pkg
pkg"activate .."
push!(LOAD_PATH,"../src/")


using Documenter, DocStringExtensions, EditorsRepo

makedocs(sitename = "EditorsRepo Documentation")
