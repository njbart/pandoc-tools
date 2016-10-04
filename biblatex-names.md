# Name parsing in biblatex

## Prefixes

- standard bibtex / biblatex syntax:
  - von Last, First
  - von Last, Jr., First

### Prefixes containing punctuation

- Spaces are required, or else the biber parser does not see a prefix:
  - `{d’ Alembert, Jean}`
- biber bugs:
  - leading punctuations
    - `{'s- Gravesande, Goverdus}`: `'s-` not parsed as prefix
- To remove these spaces in latex output, also after `’-` (`'` is default):
  - `\DeclarePrefChars{'’-}` – see biblatex manual
 
