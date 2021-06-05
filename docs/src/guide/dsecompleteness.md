# DSE completeness

```@setup dse
docsroot = pwd() |> dirname |> dirname
burney86root = docsroot * "/data/burney86/"
using EditorsRepo
townley = repository(burney86root; dse = "indextables")
```


!!!note
The validator notebook also uses the `CitableImage` library to construct URLs overlaying regions indexed on this page to the HMT image citation tool.  They look like <http://www.homermultitext.org/ict2/?urn=urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f073r@0.1703,0.3014,0.3983,0.03259&>.

