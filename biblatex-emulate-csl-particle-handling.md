Using `\DeclareSourcemap` (see biblatex manual) and `\AtBeginBibliography{\togglefalse{blx@useprefix}}`, three commands can be defined that emulate the CSL “demote-non-dropping-particle” options. Stripping out leading particles relies on a simple regexp, so it might not be completely robust.

Note that this relies on entries containing `useprefix=true` rather than just `useprefix` to simplify the regexp.

```latex
\documentclass{article}

\begin{filecontents}{testfile.bib}

@book{humb,
  author = {von Humboldt, Alex},
  title = {Title},
  options = {useprefix=false},
  date = {2015},
}

@book{gogh,
  author = {van Gogh, Vincent},
  title = {Title},
  options = {useprefix=true},
  date = {2015},
}

@book{a, author = {a}, title = {Dummy}}
@book{f, author = {f}, title = {Dummy}}
@book{h, author = {h}, title = {Dummy}}
@book{k, author = {k}, title = {Dummy}}
@book{z, author = {z}, title = {Dummy}}
\end{filecontents}

\usepackage[backend=biber, useprefix=false, style=authoryear]{biblatex}
\addbibresource{testfile.bib}

% for all demote-non-dropping-particle commands
\makeatletter
\AtBeginDocument{\toggletrue{blx@useprefix}}
\makeatother

\newcommand{\demotenondroppingparticlenever}{}

\newcommand{\demotenondroppingparticlesortonly}{
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    % The following map removes leading lowercase letters/space/'/’/~/- from author 
    % and writes the rest to sortname
    \map[overwrite]{
       \step[fieldsource=author, final]
       \step[fieldset=sortname, origfieldval]
       \step[fieldsource=sortname,
             match=\regexp{^[a-z\x20'’~-]*[\x20'’-](.*)},
             replace={$1}]
    }
  }
 }
}

\newcommand{\demotenondroppingparticledisplayandsort}{
\makeatletter
\AtBeginBibliography{\togglefalse{blx@useprefix}}% “demotes” particles
\makeatother
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    % The following map strips out “useprefix=true”, this allows demoting of particles
    \map{
       \step[fieldsource=options,
             match=\regexp{useprefix=true},
             replace=\regexp{}]
    }
  }
}
}

% Try one of these:
%\demotenondroppingparticlenever
\demotenondroppingparticlesortonly
%\demotenondroppingparticledisplayandsort

\begin{document}
\renewbibmacro*{begentry}{\midsentence}

\section{Text}

\cite{gogh, humb, a, f, h, k, z}

\printbibliography

\end{document}

% process with these commands:
% rm testfile.bib; pdflatex testfile; biber testfile; pdflatex testfile
```

With `\demotenondroppingparticlenever`

> **1 Text**  
van Gogh 2015; Humboldt 2015; a n.d.; f n.d.; h n.d.; k n.d.; z n.d.  
**References**  
a. *Dummy.*  
f. *Dummy.*  
h. *Dummy.*  
Humboldt, Alex von (2015). *Title.*  
k. *Dummy.*  
van Gogh, Vincent (2015). *Title.*  
z. *Dummy.*

With `\demotenondroppingparticlesortonly`

> **1 Text**  
van Gogh 2015; Humboldt 2015; a n.d.; f n.d.; h n.d.; k n.d.; z n.d.  
**References**  
a. *Dummy.*  
f. *Dummy.*  
van Gogh, Vincent (2015). *Title.*   
h. *Dummy.*  
Humboldt, Alex von (2015). *Title.*   
k. *Dummy.*  
z. *Dummy.*

With `\demotenondroppingparticledisplayandsort`

> **1 Text**  
van Gogh 2015; Humboldt 2015; a n.d.; f n.d.; h n.d.; k n.d.; z n.d.  
**References**  
a. *Dummy.*  
f. *Dummy.*  
Gogh, Vincent van (2015). *Title.*  
h. *Dummy.*  
Humboldt, Alex von (2015). *Title.*  
k. *Dummy.*  
z. *Dummy.*
