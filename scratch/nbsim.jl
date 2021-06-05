# Simulate a validating notebook.
using EditorsRepo
using CitableText
using CitableObject
using ManuscriptOrthography
using Orthography

treporoot = pwd() * "/docs/data/burney86"
trepo = repository(treporoot; dse = "indextables")

## CATALOGING CHECKS:
cites = citation_df(trepo)
filesmatch(trepo, cites)

# ... document other functions listing discrepancies

## SURFACES FOR MENU
surfs = surfaces(trepo)

surface = Cite2Urn("urn:cite2:hmt:burney86pages.v1:73r")





## DSE RECORDS

sdse = surfaceDse(trepo, surface)
# Use citableimage library to craft URLs to ICT2.

## DSE ACCURACY

row = sdse[1, :]
diplnodetext(trepo, row.passage)

## ORTHOGRAPHY

textconfig = citation_df(trepo)

tidy = EditorsRepo.baseurn(row.passage)

# Get the orthography
ortho = orthographyforurn(textconfig, tidy)
chunks = normednodetext(trepo, row.passage) |> split

validstring(ortho, chunks[1])
