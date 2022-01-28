"""Instantiate a `IIIFservice`` with default settings.
$(SIGNATURES)
"""
function default_iiif()
    baseurl = "https://www.homermultitext.org/iipsrv"
	root = "/project/homer/pyramidal/deepzoom"
	IIIFservice(baseurl, root)
end

"Default value for ImageCitationTool"
DEFAULT_ICT = "https://www.homermultitext.org/ict2/?"

"Default value for instance of a `IIIFservice`."
DEFAULT_IIIF = EditorsRepo.default_iiif()




#= Example of invocation:
linky = linkedMarkdownImage(ict, img, service; ht=500, caption="Proclus")
=#