
![build](https://github.com/HCMID/EditorsRepo.jl/actions/workflows/Documentation.yml/badge.svg)


# EditorsRepo.jl

A Julia module for working with an editorial repository organized following HCMID conventions.

This package provides most of the functionality used in HC MID's Pluto notebook for validating editorial work.  You can find documentation and a template editorial repository including the current release version of the Pluto notebook for validation at <https://github.com/HCMID/validatormodel>.


## Roadmap to 1.0

See the [issue tracker](https://github.com/HCMID/EditorsRepo.jl/issues) to read or file issues tagged by release.


- [x] `v0.15.x`:  ground-up rewrite using CITE architecture traits. `v0.15.0` is inadequately tested and documented, but going into hands-on use with HC MID in January, 2022.
- [ ] `v1.0.0`:  comprehensive validation of:
    - configuration and cataloging of texts in repository, related to editions in repository
    - referential integrity of DSE indexing. (Note that some of these issues may properly belong in the CitablePhysicalText package.)


