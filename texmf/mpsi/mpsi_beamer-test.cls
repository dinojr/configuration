\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{mpsi_beamer}[2012/08/03 Classe perso mpsi pour beamer]

\RequirePackage{xkeyval}
\newif\ifNotesCours
\DeclareOptionX{NotesCours}[true]{\NotesCourstrue}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptionsX

\RequirePackage{etex}

\ifNotesCours
  \PassOptionsToClass{handout}{beamer}
  \RequirePackage{tikz}
  
  \RequirePackage{pgfpages}
  \RequirePackage{floatrow}
  \pgfpagesuselayout{4 on 1}[a4paper,border shrink=5mm,landscape]
\fi


\LoadClass[utf8x,smaller]{beamer}

\RequirePackage[T1]{fontenc}



\RequirePackage{standalone}
\RequirePackage{animate}

\RequirePackage[greek,frenchb]{babel}

\RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}

\uselanguage{French}
\languagepath{French}

\RequirePackage{beamerthemempsi}
\setbeamertemplate{blocks}[rounded][shadow=true]

\setbeamertemplate{footline}{sous licence
   \tiny\url{http://creativecommons.org/licenses/by-nc-nd/2.0/fr/}\hfill \insertframenumber/\inserttotalframenumber}

\setbeamertemplate{section in toc}[sections numbered,circles]
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

\newcommand{\@intro}{}
\newcommand{\introduction}{\renewcommand{\@intro}}


\author{Julien Cubizolles}
\date{\today}
\title{Titre}
\institute{Lycée Louis le Grand}

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
  
  \begin{frame}{}
    \@intro
  \end{frame}

  \begin{frame}{}
    \titlepage
  \end{frame}

  \begin{frame}{}
    \tableofcontents[pausesections,subsectionstyle=show/shaded/hide,subsubsectionstyle=hide/hide/hide]
  \end{frame}
}

\RequirePackage{fp} % pour des calculs


%%%%%%%%%%%%%%%%%%%%
%% Symboles%%%%%%%%%
\RequirePackage{skull}
\RequirePackage{marvosym}
%%%%%%%%%%%%%%%%%%%%


\RequirePackage{pgfplots}
\RequirePackage{floatrow}
\usetikzlibrary{calc}
\usetikzlibrary{patterns}
\usetikzlibrary{intersections}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{arrows}
\pgfplotsset{compat=newest}

\RequirePackage[tight]{units}
\RequirePackage[locale = FR]{siunitx}
\RequirePackage{numprint}
\RequirePackage{icomma}
\RequirePackage[version=3]{mhchem}

\RequirePackage{xspace}

\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{enumerate}

\RequirePackage{esvect,esdiff}

\RequirePackage{bookmark}

\RequirePackage{mathtools}

\input{shortcut}
\input{chimie}


\endinput
