
"""Compute a list of `OrthographicToken`s based on the normalized edition of all texts in the repository.
$(SIGNATURES)
"""
function tokens(r::EditingRepository)
       corpora = []
       for u in texturns(r)
              tokenlist = []
              ortho = orthography(r, u)
              bldr = normalizedbuilder(r, u)

              fname = joinpath(editionsdir(r), filename(r, u))
              normalized = readcitable(fname, u, o2converter(r, u), FileReader)
              for t in map(cn -> cn.text, normalized)
                     push!(tokenlist, tokenize(t, ortho))
              end
              flattokens = tokenlist |> Iterators.flatten |> collect
              push!(corpora, flattokens)
       end
       rslt = OrthographicToken[]
       rslt = corpora |> Iterators.flatten |> collect
end

