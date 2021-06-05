# Simulate a validating notebook.
using EditorsRepo
using CitableText
using CitableObject

treporoot = pwd() * "/docs/data/burney86"
trepo = repository(treporoot; dse = "indextables")

## CATALOGIN:
cites = citation_df(trepo)
filesmatch(trepo, cites)


## SURFACES
surfs = surfaces(trepo)

surface = Cite2Urn("urn:cite2:hmt:burney86pages.v1:73r")