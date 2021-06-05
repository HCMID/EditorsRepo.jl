# User's guide

EditorsRepo.jl lets you work with files of editing work in progress in a local file system using more abstract structures such as "a corpus of citable texts" (`CitableText.Corpus`) or "a record associating texts, image and physical surface" (from the `CitablePhysicalText` module).

One important application built with EditorsRepo.jl is the Pluto notebook providing interactive validation and verification of work in progress.  The "User's guide" section of this documentation illustrates most of the functionality of EditorsRepo.jl by walking you through how the MID validator notebook uses the module.