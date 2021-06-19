using EditorsRepo
using CitableText

repos = [
    repository("/Users/nsmith/Desktop/summer-work/burney86-book8"),
    repository("/Users/nsmith/Desktop/summer-work/omega1.12-book8-2021"),
    repository("/Users/nsmith/Desktop/summer-work/upsilon1.1-2021"),
    repository("/Users/nsmith/Desktop/summer-work/va-2021"),
    repository("/Users/nsmith/Desktop/summer-work/vb-2021")
]

function citeconfs(repos)
    composite = citation_df(repos[1])
    for i in 2:length(repos)
        composite = vcat(composite,citation_df(repos[i]) )
    end
    composite
end

citation = citeconfs(repos)
urns = citation[:, :urn]

tokens = []
for r in repos
    for u in urns    
        @warn("Token index: checking $u in repo $r")
        @warn("Already collected $(length(tokens)) tokens.")
        push!(tokens,  lextokens(r, u))
    end
end




hascontent = filter(!isnothing, tokens)
tkncorpus = hascontent |> Iterators.flatten |> collect |> CitableTextCorpus

tknresults = "scholia-tokens.cex"
open(tknresults, "w") do io
    write(io, string("urn|token\n", cex(tkncorpus)))
end


#=
vb = repository("/Users/nsmith/Desktop/summer-work/vb-2021")
textconfig = citation_df(vb)

u = CtsUrn("urn:cts:greekLit:tlg0012.tlg001.msB:10") 
ortho = orthographyforurn(textconfig, u)
normalized = vb |> EditorsRepo.normedpassages
psgs = textpassages(normalized, u)  


cns = EditorsRepo.lexnodesfortokens(ortho.tokenizer(txt), psgs[1].urn)

lextokens(vb, u)
=#