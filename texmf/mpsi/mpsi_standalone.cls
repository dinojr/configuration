\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{mpsi_standalone}[2013/09/03 Classe perso mpsi pour fichiers standalone]

\RequirePackage{xkeyval}

\newif\ifPstricks
\DeclareOptionX{Pstricks}[false]{\Pstrickstrue}

\newif\ifTikz
\DeclareOptionX{Tikz}[true]{\Tikztrue}

\ifPstricks
   \PassOptionsToClass{pspicture=true}{standalone}
   \Tikzfalse
\fi

\ifTikz
   \PassOptionsToClass{tikz=true}{standalone}
\fi



\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{standalone}}

\ProcessOptionsX

\LoadClass[crop=true]{standalone}


\RequirePackage[utf8]{inputenc}
% utf8x plutôt que utf8 pour pouvoir taper du grec directement

% À changer pour passer à luatex
\RequirePackage[T1]{fontenc}

\RequirePackage{etex}

% Option dangereuse, trop de code tapé sans algebraic
%\psset{algebraic=true}

% \RequirePackage{gensymb} % pour \micro, \mu
\RequirePackage[greek,frenchb]{babel}


% \RequirePackage[narrowiints,partialup]{kpfonts}
\RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}


\RequirePackage{graphicx}
\DeclareGraphicsExtensions{.pdf,.png,.jpg,.gif}

\RequirePackage{mathtools}
% pour DeclarePairedDelimiter et co.

\ifTikz
  \RequirePackage{tikz,pgfplots}
  \usetikzlibrary{calc}
  \usetikzlibrary{patterns}
  \usetikzlibrary{intersections}
  \usetikzlibrary{decorations.markings}
  \usetikzlibrary{decorations.pathreplacing}
  \usetikzlibrary{arrows}
  \usetikzlibrary{arrows.meta}
  \usetikzlibrary{positioning}
  
  \pgfplotsset{compat=newest}
\fi

\ifPstricks
  \RequirePackage{pstricks,pstricks-add,pst-coil}
\fi

\AtBeginDocument{%
  \@ifpackageloaded{babel}{%
    \let\xCJtikz@tikzpicture\tikzpicture
    \def\tikzpicture{%
      \iflanguage{french}{%
        \shorthandoff{:;?!}}{}%
      \xCJtikz@tikzpicture}%
    \let\xCJtikz@tikzexternal@tikzpicture@replacement%
        \tikzexternal@tikzpicture@replacement
    \def\tikzexternal@tikzpicture@replacement{%
      \iflanguage{french}{%
        \shorthandoff{:;?!}}{}%
      \xCJtikz@tikzexternal@tikzpicture@replacement}}{}}

\RequirePackage{animate}

\RequirePackage[locale = FR]{siunitx}
\sisetup{%
  inter-unit-separator = \ensuremath{{} \cdot {}},
  output-decimal-marker = {,},
  exponent-product = \ensuremath{{} \cdot {}},
  group-four-digits = false,
  per-mode = reciprocal,
  separate-uncertainty = true,
  multi-part-units = single}
\RequirePackage{numprint}
\RequirePackage{icomma}
\RequirePackage[version=3]{mhchem}

\RequirePackage{xspace}

\RequirePackage{esvect,esdiff}

\input{chimie}

\ifTikz
  \input{shortcut}
  \input{wilk-tikz-circuits}
\fi
\endinput
