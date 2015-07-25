\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{mpsi_beamer}[2012/08/03 Classe perso mpsi pour beamer]

\input{configuration-base.tex}

% \RequirePackage{etex}

% \RequirePackage{xkeyval}
\newif\ifNotesCours
\DeclareOptionX{NotesCours}[true]{\NotesCourstrue}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptionsX

% pour un passage à LuaTeX, il faudra revoir les options concernant
% l'encodage et le choix des polices

% \DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{beamer}}


% rajouter xcolor=pst dans les options de LoadClass pour faire du
% pstricks ainsi que dvips (pour passer l'option à hyperref)
%\LoadClass[utf8x,xcolor=pst,smaller]{beamer}
\ifNotesCours
  \PassOptionsToClass{handout}{beamer}
\fi

\LoadClass[utf8x,smaller,mathserif]{beamer}
% utf8x plutôt que utf8 pour pouvoir taper du grec directement

% À changer pour passer à luatex
% \RequirePackage[T1]{fontenc}
                          
%% Attention, des conflits entre standalone et pstricks: standalone
%% doit être chargé avant pstricks
%% \item (LaTeX Error: Command \clipbox already defined.
% Or name \end... illegal, see p.192 of the manual.)
\RequirePackage{standalone}
\RequirePackage{animate}

\RequirePackage{beamerthemempsi}

% \RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}

\setbeamertemplate{blocks}[rounded][shadow=true]

\setbeamertemplate{footline}{sous licence
   \tiny\url{http://creativecommons.org/licenses/by-nc-nd/2.0/fr/}\hfill \insertframenumber/\inserttotalframenumber}


\setbeamertemplate{section in toc}[sections numbered]
\setbeamertemplate{subsection in toc}[subsections numbered]
\setbeamertemplate{enumerate item}{\insertenumlabel}
\setbeamertemplate{enumerate subitem}{\alph{enumii}}

\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\arabic{subsection}}
\renewcommand{\thesubsubsection}{\alph{subsubsection}}
\renewcommand\theenumi{\textsf{\bfseries\arabic{enumi}}}
\renewcommand\theenumii{\textsf{\bfseries\alph{enumii}}}

%\renewcommand<>{\emph}[1]{{\only#2{\color{emphColor}#1}}
\renewcommand{\emph}[1]{{\color{titleColor}\sl{#1}}}

\ifNotesCours
  \RequirePackage{tikz,pgfplots}% à mettre absolument avant pgfpages
  \RequirePackage{pgfpages}
  \pgfpagesuselayout{4 on 1}[a4paper,border shrink=5mm,landscape]
  \definecolor{normalBlockColor}{RGB}{240,240,240}
  \definecolor{sectionColor}{RGB}{240,200,200}
  \definecolor{subsectionColor}{RGB}{200,200,200}
  \definecolor{sectionTextColor}{RGB}{0,0,0}
  \definecolor{subsectionTextColor}{RGB}{0,0,0}
  \definecolor{normalTitleBlockColor}{RGB}{250,255,220}
  \definecolor{normalBlockTitleTextColor}{RGB}{0,0,0}
  \definecolor{titleColor}{RGB}{200,200,250}
  \definecolor{titleTextColor}{RGB}{0,0,0}
\fi


% Environnements à redéfinir éventuellement plus tard, avec
% \newtheorem et en recopiant/adaptant les styles utilisés dans Beamer
\newenvironment<>{DefiniTion}[1][]{\begin{definition}[#1]#2}{\end{definition}}
% \Definition est déjà défini ailleurs, donc CamelCase
\newenvironment<>{Consequence}[1][]{\begin{block}#2{#1}}{\end{block}}
\newenvironment<>{Block}{\begin{block}#1{}}{\end{block}}
\newenvironment<>{Theoreme}[1][]{\begin{theorem}[#1]#2}{\end{theorem}}
\newenvironment<>{Exemple}[1][]{\begin{example}[#1]#2}{\end{example}}
\newenvironment<>{indispensable}[1][]{\relax}{\relax}

\author{Julien Cubizolles}
\date{\today}
\title{Titre}
\institute{Lycée Louis le Grand}
\setbeamertemplate{section in toc}[sections numbered]
\AtBeginSection[]{
  \begin{frame}{}
  \tableofcontents[currentsection,subsectionstyle=hide/hide/hide,subsubsectionstyle=hide/hide/hide]
  \end{frame} 
}

\AtBeginSubsection[]{
  \begin{frame}{}
  \tableofcontents[currentsection, subsectionstyle=show/shaded/hide,subsubsectionstyle=hide/hide/hide]
  \end{frame} 
}

\AtBeginSubsubsection[]{
  \begin{frame}{}
  \tableofcontents[currentsection, subsectionstyle=show/shaded/hide,subsubsectionstyle=show/shaded/hide]
  \end{frame} 
}

\AtBeginDocument{
  \maketitle
}

\uselanguage{French}
\languagepath{French}

\endinput
