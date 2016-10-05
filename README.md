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

## pandoc-citeproc bugs

- cheater syntax
  - does not parse line-entry cheater syntax
  - does not parse dates and date ranges in cheater syntax
  - does not parse names in cheater syntax
- EDTF
- hanging indent in reference section

## pandoc-citeproc projects

- improve support for shortDOI 
  - on the fly (like pandoc-zotxt-shortdoi.r) but with cache, and with DBs other than zotxt?
  - handle DOIs from cheater syntax, too!
