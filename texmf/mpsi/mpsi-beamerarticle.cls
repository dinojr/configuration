\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpsi-beamerarticle}[]
\makeatletter
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

% \renewcommand\section{\@startsection {section}{1}{\z@}%
%                                     {-1.75ex \@plus -.5ex \@minus -.1ex}%
%                                     {2.3ex \@plus.2ex}%
%                                     {\normalfont\Large\bfseries\sffamily}}
% \renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
%                                         {-1.625ex\@plus -.5ex \@minus -.1ex}%
%                                         {1.5ex \@plus .2ex}%
%                                         {\normalfont\large\bfseries\sffamily}}
% \renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
%                                         {-1.625ex\@plus -.5ex \@minus -.1ex}%
%                                         {1.5ex \@plus .2ex}%
%                                         {\normalfont\normalsize\bfseries\sffamily}}


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
\newcommand\@anneesco{2014-2015}
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

\PassOptionsToPackage{override,dvipsnames}{xcolor} % pour le chargement de xcolor par beamerarticle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\input{configuration-base.tex}
\input{configuration-sections.tex} % à inclure avant beamerarticle, conflit avec titlesec sinon

\RequirePackage[noamsthm]{beamerarticle}
\RequirePackage{beamerthemempsi}

\RequirePackage{ntheorem}
\RequirePackage{xcolor}
\RequirePackage[framemethod=TikZ]{mdframed}
\mdfdefinestyle{mpsilightframe}{nobreak,roundcorner=5pt,skipabove=\baselineskip,skipbelow=\baselineskip,outerlinewidth=1pt}

\mdfdefinestyle{mpsiframe}{nobreak,roundcorner=5pt,backgroundcolor=gray!30,skipabove=\baselineskip,skipbelow=\baselineskip,outerlinewidth=2pt,backgroundcolor=gray!10}

\newtheoremstyle{nonumbernonamebreak}%
 {\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont}\hbox{\strut}}}]}%
 {\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont ##3}\hbox{\strut}}}]}%

\theoremstyle{nonumbernonamebreak}
\theoremheaderfont{\sffamily\upshape\bfseries}
\theorembodyfont{\rmfamily}

\newtheorem{Consequence}{\empty}
\surroundwithmdframed[style=mpsiframe]{Consequence}

\renewenvironment<>{Consequence}
{\begin{actionenv}#1\begin{originalConsequence}}
{\end{originalConsequence}\end{actionenv}}

\theoremstyle{nonumberbreak}
\theoremheaderfont{\sffamily\upshape\bfseries}
\theorembodyfont{\rmfamily}

\newtheorem{Exemple}{Exemple}
\surroundwithmdframed[style=mpsilightframe]{Exemple}
\renewenvironment<>{Exemple}
{\begin{actionenv}#1\begin{originalExemple}}
{\end{originalExemple}\end{actionenv}}

\newtheorem{Demonstration}{Démonstration}
\surroundwithmdframed[style=mpsilightframe]{Demonstration}
\renewenvironment<>{Demonstration}
{\begin{actionenv}#1\begin{originalDemonstration}}
{\end{originalDemonstration}\end{actionenv}}

\newtheorem{DefiniTion}{Définition}
\surroundwithmdframed[style=mpsiframe]{DefiniTion}
% for backward-compatibility
\surroundwithmdframed[style=mpsiframe]{definition}
\renewenvironment<>{DefiniTion}
{\begin{actionenv}#1\begin{originalDefiniTion}}
{\end{originalDefiniTion}\end{actionenv}}
\renewenvironment<>{definition}
{\begin{actionenv}#1\begin{originaldefinition}}
{\end{originaldefinition}\end{actionenv}}


\theoremheaderfont{\sffamily\itshape\bfseries}


\newtheorem{Theoreme}{Théorème}
\surroundwithmdframed[style=mpsiframe]{Theoreme}
% for backward-compatibility
\surroundwithmdframed[style=mpsiframe]{theorem}
\renewenvironment<>{Theoreme}
{\begin{actionenv}#1\begin{originalTheoreme}}
{\end{originalTheoreme}\end{actionenv}}

\newtheorem{Loi}{Loi}
\surroundwithmdframed[style=mpsiframe]{Loi}
\renewenvironment<>{Loi}
{\begin{actionenv}#1\begin{originalLoi}}
{\end{originalLoi}\end{actionenv}}

% for backward-compatibility
\surroundwithmdframed[style=mpsiframe]{loi}
\renewenvironment<>{loi}
{\begin{actionenv}#1\begin{originalloi}}
{\end{originalloi}\end{actionenv}}

\newenvironment<>{indispensable}{%
  \begin{actionenv}#1%
   \begin{center}
     \begin{minipage}{.8\linewidth}
       \centering
       \textsf{\textbf{\Large Indispensable}}\\
     \end{minipage}\end{center}}
     {\end{actionenv}}

\surroundwithmdframed[style=mpsiframe]{indispensable}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnement - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

\renewenvironment{columns}{\relax}{\relax}
\renewenvironment{column}[1]{\begin{minipage}{#1}}{\end{minipage}}

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
\makeatother
\endinput
