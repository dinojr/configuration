\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpsi-beamerarticle}[]

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Indispensable pour pouvoir taper des accents dans ce fichier
\RequirePackage[utf8]{inputenc}
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Options de classe
%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xkeyval}

\newif\ifCls@mpsi@noVersion
\DeclareOptionX{noVersion}[true]{\@nameuse{Cls@mpsi@noVersion#1}}

\newif\ifeleves
\DeclareOptionX{eleves}[false]{\elevestrue}

\ProcessOptionsX

\LoadClass[a4paper,twocolumn,landscape]{extarticle}

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Options de classe - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[pdftex]{hyperref}

\RequirePackage{graphicx}

% \RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}
% \RequirePackage[noamsthm]{beamerarticle}


%% Attention, des conflits entre standalone et pstricks: standalone
%% doit être chargé avant pstricks
%% \item (LaTeX Error: Command \clipbox already defined.
% Or name \end... illegal, see p.192 of the manual.)
\RequirePackage{standalone}


%\RequirePackage{lastpage} % pour avoir un compteur 1/3...
\RequirePackage{pageslts}
\AtBeginDocument{\pagenumbering{arabic}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%    Sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                    {-1.75ex \@plus -.5ex \@minus -.1ex}%
                                    {2.3ex \@plus.2ex}%
                                    {\normalfont\Large\bfseries\sffamily}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                        {-1.625ex\@plus -.5ex \@minus -.1ex}%
                                        {1.5ex \@plus .2ex}%
                                        {\normalfont\large\bfseries\sffamily}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                        {-1.625ex\@plus -.5ex \@minus -.1ex}%
                                        {1.5ex \@plus .2ex}%
                                        {\normalfont\normalsize\bfseries\sffamily}}


\ifeleves
% On ne veut pas les titres de section dans les notes aux élèves
\renewcommand\section[1]{\empty}
\renewcommand\subsection[1]{\empty}
\renewcommand\subsubsection[1]{\empty}
% \renewcommand\paragraph[1]{\empty} 

% Il faut cependant laisser l'option pour \paragraph qui est utilisé
% par beamerarticle pour les frames
\renewcommand\subparagraph[1]{\empty}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Variables, fonctions 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\@classe{MPSI2}
\newcommand\classe[1]{\renewcommand\@classe{#1}}
\newcommand\@lycee{Louis le Grand}
\newcommand\lycee[1]{\renewcommand\@lycee{#1}}
\newcommand\@auteur{Julien Cubizolles}
\newcommand\auteur[1]{\renewcommand\@auteur{#1}}
\newcommand\@titre{Mettre un titre}
\newcommand\titre[1]{\renewcommand\@titre{#1}}
\RequirePackage{url}
\newcommand\@licence{sous licence \tiny\url{http://creativecommons.org/licenses/by-nc-nd/2.0/fr/}.}
\newcommand\licence[1]{\renewcommand\@licence{#1}}
\newcommand\@anneesco{2013-2014}
\newcommand\anneesco[1]{\renewcommand\@anneesco{#1}}


\RequirePackage{calc}
\newcounter{hours}
\newcounter{minutes}
\newcommand{\printtime}{%
  \setcounter{hours}{\time/60}%
  \setcounter{minutes}{\time-(\value{hours}*60)}
  \thehours h \theminutes min}

\newcommand{\mois}{%
    \ifcase\month
        \or janvier%
        \or février%
        \or mars%
        \or avril%
        \or mai%
        \or juin%
        \or juillet%
        \or août%
        \or septembre%
        \or octobre%
        \or novembre%
        \or décembre%
    \fi
}
\newcommand{\aujourdhui}{\the\day~\mois~\the\year}
%\newcommand{\timestamp}{\aujourdhui, à \printtime}
\newcommand{\timestamp}{\aujourdhui}
\newcommand{\@jour}{\aujourdhui}
\newcommand{\jour}[1]{\renewcommand{\@jour}{#1}}
\newcommand{\@pourle}{\aujourdhui}
\newcommand{\pourle}[1]{\renewcommand{\@pourle}{#1}}
\newcommand{\makepourle}{Pour le \@pourle}

\renewcommand{\thefootnote}{\roman{footnote}}

\def\maketitle{%
  \par
  \begingroup
  \twocolumn[\@maketitle]
  \endgroup
  \setcounter{footnote}{0}
  \let\maketitle\relax%
  \let\@maketitle\relax%
}

\def\@maketitle{%
  \newpage
  \null
  \vskip 2em 
  \begin{center}
    {\LARGE \textsf{\textbf{ \@title}} \par} % Changer ici pour le style de fonte
  \end{center}
  \par
  \vskip 1.5em
}

\renewcommand{\labelitemi}{$\bullet$}
\renewcommand{\emph}{\textbf}


\newcommand{\dontcount}{
  \addtocounter{page}{-1}
%  \immediate\write\@auxout{\string\newlabel{LastPage}{{}{\thepage}{}{page.\thepage}{}}}%
%  \addtocounter{page}{1}
}
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Variables, fonctions  - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Géométrie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\RequirePackage{fancybox}
%\RequirePackage[\Cls@mpsi@driver]{graphicx}

\AtBeginDocument{%
  \abovedisplayskip=6pt plus 1.5pt minus 3.5pt
  \belowdisplayskip=\abovedisplayskip
  % \flushleft
}

\renewcommand{\footrulewidth}{0.4pt}
\lhead{\@classe \xspace, \@lycee}
\chead{%
  \ifnum\thepage=1 
  \LARGE\textbf{\textsf{\@title}}
  \else \large\textbf{\textsf{\@title}}
  \fi
}

\rhead{%
  \@date
}
  
\RequirePackage[a4paper,margin=1.5cm,includeheadfoot,landscape,headsep=18pt,pdftex]{geometry}
\columnseprule=.8pt
\pagestyle{fancy}

%%%%%%%%%%%%%%%%%% 
%% Header/footage
%%%%%%%%%%%%%%%%%% 
\lfoot{%
  \ifCls@mpsi@noVersion
  \else
  \unitlength=1cm
  \begin{picture}(0,0)
    \put(-.5,0){%
      \rotatebox[origin=tl]{90}{%
        \tiny\textsl{\texttt{\jobname.tex},version du \timestamp}}}
  \end{picture}
  \fi
  \@auteur,\xspace \@licence
}
    
\cfoot{\textsc{\thepage}/\textsc{\pageref{VeryLastPage}}}

\rfoot{\@anneesco}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Géométrie - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Packages nécessaires
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{etex}
% Pour ne jamais manquer de compteurs
\reserveinserts{28}
%et pour en avoir davantage

\RequirePackage{ae,aecompl}

\RequirePackage{array,booktabs,tabularx,multicol,multirow}

\RequirePackage[frenchb]{babel}
%\frenchbsetup{AutoSpacePunctuation=true}
\RequirePackage{numprint}
\RequirePackage{xspace} %%% pour gérer correctement les espaces
                        %%% avant/après les macros
\RequirePackage{setspace} %pour avoir double/simple espacement



% \RequirePackage{enumerate,enumitem,psfrag}
% Conflit entre beamerarticle, enumitem et les environments description
\RequirePackage{enumerate,psfrag}


\RequirePackage[version=3]{mhchem}

\RequirePackage[cyr]{aeguill}


%\RequirePackage{frcursive}
\RequirePackage[T1]{fontenc}
% \RequirePackage{lmodern}
\RequirePackage{esvect,esdiff}


%\RequirePackage{wrapfig}   %%%%%%% figures

%\RequirePackage{manfnt,mathrsfs} % des fontes

\RequirePackage{fp}

\RequirePackage{mathtools}
% pour DeclarePairedDelimiter et co.


\RequirePackage{marvosym}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Tikz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\PassOptionsToPackage{override}{xcolor} % pour le chargement de xcolor par beamerarticle
\RequirePackage{tikz,pgfplots}
\usetikzlibrary{calc}
\usetikzlibrary{patterns}
\usetikzlibrary{intersections}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{arrows}
\usetikzlibrary{positioning}


\RequirePackage[locale = FR]{siunitx}
\sisetup{%
  inter-unit-separator = \ensuremath{{} \cdot {}},
  output-decimal-marker = {,},
  exponent-product = \ensuremath{{} \cdot {}},
  group-four-digits = false,
  per-mode = reciprocal,
  separate-uncertainty = true,
  multi-part-units = single}

% \RequirePackage{icomma}

% \RequirePackage[frenchstyle,narrowiints,partialup,noamsmath]{kpfonts}

\RequirePackage[]{beamerarticle}
\RequirePackage{beamerthemempsi}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[framemethod=TikZ,xcolor]{mdframed}
\mdfdefinestyle{mpsilightframe}{nobreak,roundcorner=5pt,skipabove=\baselineskip,skipbelow=\baselineskip,outerlinewidth=1pt}

\mdfdefinestyle{mpsiframe}{nobreak,roundcorner=5pt,backgroundcolor=gray!30,skipabove=\baselineskip,skipbelow=\baselineskip,outerlinewidth=2pt,backgroundcolor=gray!10}

\newtheoremstyle{breaknoname}% name
  {3pt}%      Space above
  {3pt}%      Space below
  {\rmfamily}%         Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\sffamily\upshape\bfseries}% Thm head font
  {}%        Punctuation after thm head
  { }%     Space after thm head: " " = normal interword space;
           % \newline = linebreak
  {\rlap{\vbox{\hbox{\thmname{#3}}\hbox{\strut}}}}%         Thm head spec (can be left empty, meaning `normal')
\theoremstyle{breaknoname}
\newtheorem*{Consequence}{\empty}
\surroundwithmdframed[style=mpsiframe]{Consequence}


\newtheoremstyle{breaknonamenotitle}% name
  {3pt}%      Space above
  {3pt}%      Space below
  {\rmfamily}%         Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\sffamily\upshape\bfseries}% Thm head font
  {}%        Punctuation after thm head
  { }%     Space after thm head: " " = normal interword space;
           % \newline = linebreak
  {\rlap{\vbox{\hbox{\thmname{#1}: \thmname{#3}}\hbox{\strut}}}}%         Thm head spec (can be left empty, meaning `normal')
\theoremstyle{breaknonamenotitle}

\newtheorem*{Exemple}{Exemple}
\surroundwithmdframed[style=mpsilightframe]{Exemple}

\newtheorem*{Demonstration}{Démonstration}
\surroundwithmdframed[style=mpsilightframe]{Demonstration}

\newtheoremstyle{break}% name
  {3pt}%      Space above
  {3pt}%      Space below
  {\rmfamily}%         Body font
  {}%         Indent amount (empty = no indent, \parindent = para indent)
  {\sffamily\upshape\bfseries}% Thm head font
  {}%        Punctuation after thm head
  { }%     Space after thm head: " " = normal interword space;
        %       \newline = linebreak
  {\rlap{\vbox{\hbox{\thmname{#1} : \itshape #3}\hbox{\strut}}}}%         Thm head spec (can be left empty, meaning `normal')
\theoremstyle{break}

\newtheorem*{Theoreme}{Théorème}
\surroundwithmdframed[style=mpsiframe]{Theoreme}
% for backward-compatibility
\surroundwithmdframed[style=mpsiframe]{theorem}

\newtheorem*{Loi}{Loi}
\surroundwithmdframed[style=mpsiframe]{Loi}
% for backward-compatibility
\surroundwithmdframed[style=mpsiframe]{loi}

\newtheorem*{DefiniTion}{Définition}

\surroundwithmdframed[style=mpsiframe]{DefiniTion}
% for backward-compatibility
\surroundwithmdframed[style=mpsiframe]{definition}



\newenvironment{indispensable}{%
   \begin{center}
     \begin{minipage}{.6\linewidth}
       \centering
       \textsf{\textbf{\Large Indispensable}}\\
     }
     {\end{minipage}\end{center}}

\surroundwithmdframed[style=mpsilightframe]{indispensable}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnement - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

\RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}
\RequirePackage{skull}
\input{shortcut}
\renewenvironment{columns}{\relax}{\relax}
\renewenvironment{column}[1]{\begin{minipage}{#1}}{\end{minipage}}


\AtBeginDocument{\renewcommand{\labelitemi} {$\bullet$}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Vestiges
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\newcommand{\rem}{\textbf{Remarques :\xspace}}
\newcommand{\parking}[2]{
  \begin{minipage}[t]{.5\columnwidth}
    \flushleft \large \textit{\color {red} Schéma de #1\xspace}
  \end{minipage}\hfill\vspace{#2\baselineskip}
}
\newcommand{\oral}[1]{%
  \begin{center}
      \color{red} \begin{minipage}{.8\columnwidth} \textsf{\large \bfseries #1}\end{minipage}
  \end{center}
  \color{black}
}
\endinput
