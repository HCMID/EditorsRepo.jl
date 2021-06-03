#using Pkg
#Pkg.add("ManuscriptOrthography")

using EditorsRepo
using CitableText


psg = CtsUrn("urn:cts:greekLit:tlg0012.tlg001:8.title")

trepo = "/Users/nsmith/Desktop/summer_workspace/burney86-book8"
repo = EditingRepository(trepo, "editions", "dse", "config")



function baseurn(urn::CtsUrn)
	trimmed = CitableText.dropsubref(urn)
	if CitableText.isrange(trimmed)
		psg = CitableText.rangebegin(trimmed)
		CitableText.addpassage(urn,psg)
	else
		urn
	end
end


reduced = baseurn(psg)


using ManuscriptOrthography, Orthography, PolytonicGreek

println("Danger zone:")

textconfig = citation_df(repo)

ortho = orthographyforurn(textconfig, reduced)

println("Now manually:")
s = Meta.parse("msGreek()")
manualortho = eval(s)