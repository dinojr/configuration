\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{mpsi_standalone}[2013/09/03 Classe perso mpsi pour standalone]

% pour un passage à LuaTeX, il faudra revoir les options concernan
% l'encodage et le choix des polices

% rajouter xcolor=pst dans les options de LoadClass pour faire du
% pstricks ainsi que dvips (pour passer l'option à hyperref)

\LoadClass[tikz,crop=true]{standalone}
% Les options suivantes font planter animate
% \LoadClass[tikz,crop=true]{standalone}

\RequirePackage[utf8]{inputenc}
% utf8x plutôt que utf8 pour pouvoir taper du grec directement

% À changer pour passer à luatex
\RequirePackage[T1]{fontenc}

\RequirePackage{etex}

% \RequirePackage{pstricks}
% \RequirePackage{pstricks,pstricks-add,pst-coil}

% Option dangereuse, trop de code tapé sans algebraic
%\psset{algebraic=true}

% \RequirePackage{gensymb} % pour \micro, \mu
% \RequirePackage[greek,frenchb]{babel}


\RequirePackage[narrowiints,partialup]{kpfonts}
% \RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}

\RequirePackage{mathtools}
% pour DeclarePairedDelimiter et co.

\RequirePackage{tikz,pgfplots}
\usetikzlibrary{calc}
\usetikzlibrary{patterns}
\usetikzlibrary{intersections}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{decorations.pathreplacing}
\usetikzlibrary{arrows}
\usetikzlibrary{positioning}

\pgfplotsset{compat=newest}

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

\input{shortcut}
\input{chimie}
\input{wilk-tikz-circuits}
\endinput
