# pandoc-tools

Collection of tools, scripts, and useful knowledge for pandoc, pandoc-citeproc, CSL, etc.

## Tips & Tricks

- Cite all entries from a bib file, and set `reference-section-title`:

```
---
nocite: '@*'
reference-section-title: References
...
```

## some awkward CSL issues

- no support for non-English month-day/day-month combos ([discussion](https://forums.zotero.org/discussion/33959/style-error-chicago-author-date-csl-localized-date#latest))
- no official support for `volume-title` (supported by pandoc-citeproc & citeproc-js since about 2013)
- no support for review of more than one work
- no support for 


## some awkward pandoc-citeproc issues

- EDTF (not supported yet)
- Capitalise first letter of subtitle if using apa.csl (citeproc-js does this)
- author name as part of narrative with multiple items
- [Titles as part of narrative need to be moved in front of parenthetical citation](https://github.com/jgm/pandoc-citeproc/issues/136)
- [Caps-protection in biblatex to CSL JSON/CSL YAML conversion](https://github.com/jgm/pandoc-citeproc/issues/189)
- [Author-date citations with page references not separated by a semicolon](https://github.com/jgm/pandoc-citeproc/issues/324)
- [Emphasis in titles trips up double→single quotation marks conversion if using JSON db](https://github.com/jgm/pandoc-citeproc/issues/373)
- [Incorrect sorting with mixed Y, YMD, and YMD-YMD dates](https://github.com/jgm/pandoc-citeproc/issues/416)

## pandoc-citeproc issues that have been resolved

- cheater syntax [docs](https://citeproc-js.readthedocs.io/en/latest/csl-json/markup.html#cheater-syntax-for-odd-fields)
  - src/Text/CSL/Reference.hs: parseSuppFields
  - does not parse line-entry cheater syntax
  - does not parse dates and date ranges in cheater syntax
    - example: `original-date: 2001-12-15/2001-12-31`
  - does not parse names in cheater syntax
    - example: `editor: Thompson || Hunter S.` (cumulative!)
  - **no longer a huge problem since BBT exports clean (i.e., non-cheater) CSL JSON and CSL YAML**
- hanging indent in reference section
  - fixed in https://github.com/jgm/pandoc/commit/0fe635d3ecdc362f11c380c2e0b9518aa03424e9

## pandoc-citeproc projects

- improve support for shortDOI 
  - on the fly (like pandoc-zotxt-shortdoi.r) but with cache, and with DBs other than zotxt?
  - handle DOIs from cheater syntax, too!
