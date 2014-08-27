\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpsi}[2012/09/03 Classe perso mpsi, adapté de lycee.cls
de Christophe Jorssen,par Julien Cubizolles]

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% à faire : 
% chimie et le nouveau
% de l'ordre dans les shortcuts
% des package différents suivant les chapitres
% l'intégration avec les exercices à finir...
% lien fixme/answers et options de classe
% Regrouper les headers, on n'a pas besoin de tout ça...
%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Indispensable pour pouvoir taper des accents dans ce fichier
\RequirePackage[utf8]{inputenc}
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Options de classe
%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xkeyval}

\newif\ifCls@mpsi@marge
\DeclareOptionX{marge}[true]{\@nameuse{Cls@mpsi@marge#1}}

\newif\ifcours
\DeclareOptionX{cours}[true]{\courstrue}

\newif\ifeleves
\DeclareOptionX{eleves}[false]{\elevestrue}

\newif\ifDS
\DeclareOptionX{DS}[false]{\DStrue}

\newif\ifDM
\DeclareOptionX{DM}[false]{\DMtrue}

\newif\ifexos
\DeclareOptionX{exos}[false]{\exostrue}

\newif\ifTP
\DeclareOptionX{TP}[false]{\TPtrue}

% conflit avec animate
%\newif\ifdraft
%\DeclareOptionX{draft}[false]{\drafttrue}

\newif\ifCls@mpsi@colonne
\DeclareOptionX{colonne}[true]{\@nameuse{Cls@mpsi@colonne#1}}

\newif\ifcorr
\corrtrue
\DeclareOptionX{nocorr}[false]{\corrfalse}

\newif\ifCls@mpsi@noPS
\DeclareOptionX{noPS}[true]{\@nameuse{Cls@mpsi@noPS#1}}

\newif\ifCls@mpsi@noVersion
\DeclareOptionX{noVersion}[true]{\@nameuse{Cls@mpsi@noVersion#1}}

\newif\ifPstricks
\DeclareOptionX{Pstricks}[false]{\Pstrickstrue}

% \newif\iftoc \toctrue
% \DeclareOptionX{notoc}[false]{\tocfalse}

\newif\ifbeamerarticle
\DeclareOptionX{beamerarticle}[false]{\beamerarticletrue}

\DeclareOptionX{class}{\def\Cls@mpsi@class{#1}}
  \def\Cls@mpsi@class{extarticle}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{\Cls@mpsi@class}}

%\newcommand{\mpsi@doc}{cours}
\define@key{mpsi}{doc}[cours]{\newcommand{\mpsi@doc}#1}

% \define@key{mpsi}{doc}{\let\mpsi@doc=#1}
% \define@key{mpsi}{c}[]{\let\mpsi@doc=c}
% \define@key{mpsi}{e}[]{\let\mpsi@doc=e}
% \define@key{mpsi}{T}[]{\let\mpsi@doc=T}

\ProcessOptionsX

\ifCls@mpsi@colonne
    \PassOptionsToClass{twocolumn,landscape}{\Cls@mpsi@class}
\fi

%\ifdraft
%    \PassOptionsToClass{draft}{\Cls@mpsi@class}
%    \else
%    \PassOptionsToClass{final}{\Cls@mpsi@class}
%\fi

\LoadClass[a4paper]{\Cls@mpsi@class}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  Choix du driver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ifpdf}

\ifpdf
  \Cls@mpsi@noPStrue
  \ClassWarning{mpsi}{%
      Utilisation de pdfLaTeX : pas de PS\MessageBreak
      `\string\Cls@mpsi@noPS' mis a la valeur `true'}
  \def\Cls@mpsi@driver{pdftex}
\else
  \def\Cls@mpsi@driver{dvips}
\fi

\ifCls@mpsi@noPS
  \RequirePackage[pdftex]{hyperref}
\else
  \RequirePackage[dvips]{hyperref}
\fi

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

\RequirePackage{framed}

\RequirePackage[hyperref,framed,thmmarks]{ntheorem}


\ifcours
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
\fi

\ifTP
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
% \newcommand\important[1]{\begin{center}\begin{minipage}{.7\linewidth}\begin{center}\textit{#1}\end{center}\end{minipage}\end{center}} 

% Nécessaire dans tous les cas pour le shaded theorem
\RequirePackage{pstricks}

\RequirePackage[framemethod=TikZ,xcolor]{mdframed}
\newmdenv[roundcorner=5pt,backgroundcolor=gray!30,skipabove=5pt]{important}

\definecolor{gris}{gray}{0.9}
\shadecolor{gris}
\theoremstyle{empty}
%\theoremindent
\newshadedtheorem{impthm}{}
%\quoteindent=20pt

% \newenvironment{impquote}
%                 {\list{}{\setlength\rightmargin{.1\linewidth}%
%                     \setlength\leftmargin{.1\linewidth}}%
%                  \item\relax}
%                 {\endlist}

% \newenvironment{important}{\begin{impthm}\begin{impquote}}{\end{impquote}\end{impthm}}
% \newenvironment{important}{\begin{impthm}}{\end{impthm}}

%\noindent\fcolorbox{gris}{gris25}{\makebox[\textwidth][c]{Activités :}}
\newcommand{\bouton}[1]{\textbf{#1}}
\fi


\ifDS
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-1.75ex \@plus -.5ex \@minus -.1ex}%
  {2.3ex \@plus.2ex}%
  {\normalfont\large\bfseries\sffamily}}
\renewcommand{\thesection}{\textsf{\bfseries\Roman{section}}}
\newcommand{\withsections}{
  \renewcommand\theenumi{\textsf{\bfseries\thesection.\arabic{enumi}}}
  \renewcommand\theenumii{\textsf{\bfseries\alph{enumii}}}
}
\newcommand{\withoutsections}{
  \renewcommand\theenumi{\textsf{\bfseries\arabic{enumi}}}
  \renewcommand\theenumii{\textsf{\bfseries\alph{enumii}}}}
\withoutsections
\fi

\ifDM
\renewcommand\section{\@startsection {section}{1}{\z@}%
  {-1.75ex \@plus -.5ex \@minus -.1ex}%
  {2.3ex \@plus.2ex}%
  {\normalfont\large\bfseries\sffamily}}
\renewcommand{\thesection}{\textsf{\bfseries\Roman{section}}}
\newcommand{\withsections}{
  \renewcommand\theenumi{\textsf{\bfseries\thesection.\arabic{enumi}}}
  \renewcommand\theenumii{\textsf{\bfseries\alph{enumii}}}
}
\newcommand{\withoutsections}{
  \renewcommand\theenumi{\textsf{\bfseries\arabic{enumi}}}
  \renewcommand\theenumii{\textsf{\bfseries\alph{enumii}}}}
\withoutsections
\fi

%\renewcommand\thesection{\@Roman\c@section}
\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\alph{subsubsection}}


\ifeleves
\renewcommand\section[1]{\empty}
\renewcommand\subsection[1]{\empty}
\renewcommand\subsubsection[1]{\empty}
\renewcommand\paragraph[1]{\empty}
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

\RequirePackage[inline,nomargin]{fixme}
\AtBeginDocument{%
  %\vskip \baselineskip 
  \listoffixmes
}

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
  \if@twocolumn
  \twocolumn[\@maketitle]
  \else \newpage
  \global\@topnum\z@ 
  \@maketitle
  \fi
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
\newcommand{\AN}{\textit{Application numérique :}\xspace}

\newcommand{\dontcount}{
  \addtocounter{page}{-1}
%  \immediate\write\@auxout{\string\newlabel{LastPage}{{}{\thepage}{}{page.\thepage}{}}}%
%  \addtocounter{page}{1}
}
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Variables, fonctions  - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\theoremheaderfont{\sffamily\upshape\bfseries}

\theoremstyle{empty}
\theorembodyfont{\rmfamily}
\theoremsymbol{}
\theoremstyle{emptybreak}
%\theorembodyfont{\itshape}
\newframedtheorem{consequence}{}

\theoremstyle{nonumberbreak}
\theoremseparator{ :}
\theorembodyfont{\itshape}
%\newshadedtheorem{theoreme}{Théorème}
\newframedtheorem{theoreme}{Théorème}

\newframedtheorem{definition}{Définition}
\newframedtheorem{modele}{Modèle}
\newframedtheorem{loi}{Loi}
\newframedtheorem{principe}{Principe}
\newframedtheorem{postulat}{Postulat}
\newtheorem{protocole}{Protocole}
\newtheorem{exploitation}{Exploitation}
\newtheorem{manip}{Manipulations}
\newtheorem{materiel}{Matériel}
\newtheorem{question}{Questions}

\theoremsymbol{$\bullet$}

%\theoremsymbol{$\bullet$}
\newtheorem{application}{Application}
\newtheorem{observation}{Observations}
\RequirePackage{skull}
%\newtheorem{attention}{$\skull$ Attention $ \skull$}

\theorembodyfont{\rmfamily}
\newtheorem{exemple}{Exemple}
\newtheorem{example}{Exemple}

\theoremsymbol{\leavevmode\bfseries \sffamily \tiny Fin}
\newtheorem{demo}{Démonstration}
\theoremsymbol{}
\newtheorem{objectif}{Objectifs}


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

\newcommand{\rem}{\textbf{Remarques :\xspace}}


\RequirePackage{calc}
\RequirePackage{psfrag}
%\RequirePackage[\Cls@mpsi@driver]{graphicx}
\RequirePackage{graphicx}

\def\schema{\@ifnextchar [{\@ischema}{\@ischema[.45\columnwidth]}}

\def\@ischema[#1]#2{%
  \gdef\@fichier{#2}
  \def\@largeur@schema{.95\linewidth-#1}
  \begin{minipage}[t]{#1}
    }
    \def\endschema{%
    \end{minipage}\hfill\begin{minipage}[t]{\@largeur@schema}
      \centering \ifpdf \IfFileExists{\@fichier.pdf}{%
        \raisebox{\dimexpr-\height+\baselineskip\relax}{\includegraphics[clip,width=\linewidth]{\@fichier}}
      }{\color{red} $\skull$ \sffamily Le fichier \@fichier.pdf\xspace
        n'existe pas $\skull $} \else \IfFileExists{\@fichier.eps}{%
        \raisebox{\dimexpr-\height+\baselineskip\relax}{\includegraphics[clip,width=\linewidth]{\@fichier}}
      }{\color{red} $\skull$ \sffamily Le fichier \@fichier.eps\xspace
        n'existe pas $\skull $} \fi
  \end{minipage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnement d'exos, réponses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


\RequirePackage[hyperref,thmmarks,framed]{ntheorem}
\theoremheaderfont{\sffamily\upshape\bfseries}

\renewtheoremstyle{break}%
% {\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
%         ##1\ ##2\theorem@separator}\hbox{\strut}}}]}%
% {\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
%         ##1\ ##2 : ##3\theorem@separator}\hbox{\strut}}}]}
{\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
        ##1\ ##2\theorem@separator}\hbox{\strut}}}]}%
{\item[\rlap{\vbox{\hbox{\hskip\labelsep \theorem@headerfont
        ##1\ ##2 : ##3\theorem@separator}\hbox{\strut}}}]}%
\theoremseparator{}
\theoremstyle{break}
\theoremsymbol{}

\theorembodyfont{\rmfamily}

\ifCls@mpsi@colonne
\theoremheaderfont{\sffamily\upshape\bfseries\large}
\else \theoremheaderfont{\Large \sffamily\upshape\bfseries}
\fi 

\ifDM
\theoremprework{\vskip \baselineskip
}
\theorempostwork{%\vskip \baselineskip
  \begin{center} 
    \begin{minipage}{.5\columnwidth}
      \strut
      \hrule%\strut
    \end{minipage}
  \end{center}
  } 
\fi
\ifDS
\theoremprework{\vskip \baselineskip
  } 
\theorempostwork{%\vskip \baselineskip
  \begin{center} 
    \begin{minipage}{.5\columnwidth}
      \strut 
      \hrule
    \end{minipage}
  \end{center}
  } 

% Pour avoir des notes de marges dans les minipages
\RequirePackage{mpgmpar}
\newenvironment{minipagemarg}{\begin{minipagewithmarginpars}}{\end{minipagewithmarginpars}}
\newcommand{\points}[1]{\marginpar{\fbox{\textbf{\tiny #1}}}}
\newcommand{\total}[1]{\textit{Noté sur~#1\xspace points\strut}}
% \newcommand{\@total}{xx\xspace}
% \newcommand{\total}[1]{\renewcommand{\@total}{#1\xspace}}
\fi

\newtheorem{exercice}{Exercice}

%%%%%%%% Pourquoi faut-il le répéter ?
\ifDM
\theoremprework{\vskip \baselineskip
}
\theorempostwork{\strut
  \begin{center} 
    \begin{minipage}{.5\columnwidth}
      \strut\hrule
    \end{minipage}
  \end{center}
  } 
\fi
\ifDS
\theoremprework{\vskip \baselineskip%
%  \setcounter{section}{0}
  } 
\theorempostwork{\strut
  \begin{center} 
    \begin{minipage}{.5\columnwidth}
      \strut 
      \hrule
    \end{minipage}
  \end{center}
  } 
\fi
\newtheorem{probleme}{Problème}

%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Les réponses
%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{answers}

\Newassociation{corprob}{solprob}{mycor}
\Newassociation{corexo}{solexo}{mycor}
\let\oldcorprob\corprob
\let\oldcorexo\corexo
\Newassociation{commentaires}{comm}{mycor}
\newcounter{bogusprob}
\newcounter{bogusexo}

% \renewenvironment{solprob}[1]{
%   % \setcounter{section}{0}
%   \begin{trivlist} \item \textbf{\large \textsf{Correction du problème
%         \emph{#1}}}%
%   }{\end{trivlist}}

% \renewenvironment{solexo}[1]{
%   % \setcounter{section}{0}
%   \begin{trivlist} \item \textbf{\large \textsf{Correction de
%         l'exercice \emph{#1}}}%
%   }{\end{trivlist}}

\renewcommand{\solproblabel}[1]{\textbf{\large \textsf{Correction du
         problème \emph{#1}}}}

\renewcommand{\solexolabel}[1]{\textbf{\large \textsf{Correction de
      l'exercice  \emph{#1}}}}

\renewcommand{\corprob}{\refstepcounter{bogusprob}\oldcorprob}
\renewcommand{\corexo}{\refstepcounter{bogusexo}\oldcorexo}

\let\oldsolprob\solprob
\renewcommand{\solprob}[1]{\oldsolprob{#1}\ \par} 
\let\oldsolexo\solexo
\renewcommand{\solexo}[1]{\oldsolexo{#1}\ \par} 

\@addtoreset{section}{probleme}
\@addtoreset{section}{solprob}
% \@addtoreset{section}{solexo}
% \@addtoreset{section}{exercice}




% \renewenvironment{comm}[1]{%
%    \textbf{\large \textsf{Remarques générales :\newline}}\strut}

%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%% Les réponses
%%%%%%%%%%%%%%%%%%%%%% 
\RequirePackage{answers}
\AtBeginDocument{
  \Opensolutionfile{mycor}
}
\AtEndDocument{%
  \Closesolutionfile{mycor}
  \ifcorr
  \ifcours \newpage
  \else \cleardoublepage
  \fi
  \Readsolutionfile{mycor}
  \fi
  % \ifcours\relax
  % \else
  % \immediate\write\@auxout{\string\newlabel{LastPage}{{}{\thepage}{}{page.\thepage}{}}}% 
  % \fi
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Environnement d'exos, réponses : fins
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


\ifDS
%%%%%%%% Pour un DS
  \newcommand{\@titlecor}{DS \@title : corrigé}
  \newcommand{\titlecor}[1]{\renewcommand{\@titlecor}{#1}}
\fi

\ifDM
%%%%%%%% Pour un DM
  \newcommand{\@titlecor}{DM \@title : corrigé}
  \newcommand{\titlecor}[1]{\renewcommand{\@titlecor}{#1}}
  \newcommand{\@sujet}{sujet}
  \newcommand{\sujet}[1]{\renewcommand{\@sujet}{#1}}
  \newcommand{\makesujet}{%
    \begin{center}
      \textsf{\textbf{\Large \@sujet}}
    \end{center}
  }
\fi

\ifcours
 %%%%%%%% pour une feuille de cours
  \newenvironment{preparation}{%
   \par\textsf{\textbf{\sffamily \bfseries \large Préparation}} :\newline}{%
   \begin{center}
     \begin{minipage}[t]{.5\linewidth}
       \hrule
     \end{minipage}
     \par
   \end{center}
 }
 \newenvironment{indispensable}{%
   \vskip 3\baselineskip
   \hrule
   \begin{center}
     \begin{minipage}{.6\linewidth}
       \centering
       \textsf{\textbf{\Large Indispensable}}\\
     }
     {\end{minipage}\end{center}}
 % \RequirePackage{ifpdf}
 % \ifpdf%
 % \RequirePackage{pdflscape}
%  \else 6
%  \RequirePackage{lscape}
%  \fi

% \iftoc
%   \RequirePackage{tocloft}
%   \tocloftpagestyle{empty}
%   \ifCls@mpsi@colonne  
% %  \RequirePackage{rotating}
%   \RequirePackage{fancybox}
%   \fi
%   \AtEndDocument{%
%     \renewcommand{\cfttoctitlefont}{\bfseries \sffamily \Huge}%
%     \renewcommand{\contentsname}{Plan : \@title }%
%     \renewcommand{\cftsecfont}{\bfseries \sffamily \Huge}%
%     \renewcommand{\cftsubsecfont}{\LARGE \sffamily}%
%     \renewcommand{\cftsubsubsecfont}{\Large \sffamily}%
%     \setlength \cftparskip{.5\baselineskip}%
%     \setlength{\cftsecnumwidth}{1cm}%
%     \setlength{\cftsubsecnumwidth}{1cm}%
%      \clearpage
%      \addtocounter{page}{-1}
%      \immediate\write\@auxout{\string\newlabel{LastPage}{{}{\thepage}{}{page.\thepage}{}}}%
%      \addtocounter{page}{1}
% %     \dontcount
%     \ifCls@mpsi@colonne
%     \onecolumn%
%     \begin{LandScape}{\rotateright}
%       \large
%       \tableofcontents
%     \end{LandScape}
%     \else
%     \tableofcontents
%     \fi
%   }
% \fi
%\else \RequirePackage{lastpage}
\fi


\ifexos
  %%%%%%%%% si on fait une feuille d'exos
  \let\maketitle\relax
  \newcommand{\@titlecor}{\@title : corrigé}
  \newcommand{\titlecor}[1]{\renewcommand{\@titlecor}{#1}}
  \newcommand{\semaine}[2]{%
  \newcommand{\@semaine@debut}{#1}\newcommand{\@semaine@fin}{#2}}
  \newcommand{\makesemaine}{Semaine du \@semaine@debut\xspace au \@semaine@fin}
   \def\maketitlecor{%
     \par
     \begingroup
     \if@twocolumn
     \twocolumn[\@maketitlecor]
     \else \newpage
     \global\@topnum\z@ 
     \@maketitlecor
     \fi
     \endgroup
     \setcounter{footnote}{0}
     \let\maketitle\relax%
     \let\@maketitlecor\relax%
    \gdef\@titlecor{}%
   }
   \def\@maketitlecor{%
     \newpage
     \null
     \vskip 2em 
     \begin{center}
       {\LARGE \bf  \upshape \@titlecor \par} % Changer ici pour le style de fonte
     \end{center}
     \par
     \vskip 1.5em
   }

\def\theme{\@ifnextchar [{\@itheme}{\@itheme[.5\columnwidth]}}
\def\@itheme[#1]#2{%
  \begin{center}
    \begin{minipage}[t]{#1}
      \begin{center} \hrule \vspace \baselineskip
        \textbf{\sffamily \Large \protect{#2}}
      \end{center} \hrule
    \end{minipage}
  \end{center}
}


   \newcommand{\@classifu}{}
   \newcommand{\classifu}{\renewcommand{\@classifu}}
   \newcommand{\@classifd}{}
   \newcommand{\classifd}{\renewcommand{\@classifd}}
   \newcommand{\@classift}{}
   \newcommand{\classift}{\renewcommand{\@classift}}
   
   \newcommand{\classification}[1]{
     \begin{center}
       \begin{minipage}[t]{.8\linewidth}
         \hrule\vskip .5\baselineskip
         \itshape \protect{#1}
         \normalfont
         \begin{description}
         \item[Exercices d'application :] \@classifu
         \item[Culture en sciences physiques :] \@classifd
         \item[Corrigés en TD :] \@classift
         \end{description}
         \hrule
       \end{minipage}
     \end{center}
   }
\fi % fin du paramétrage des feuilles d'exos




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Géométrie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\RequirePackage{fancybox}
%\RequirePackage[\Cls@mpsi@driver]{graphicx}

\AtBeginDocument{%
  \abovedisplayskip=6pt plus 1.5pt minus 3.5pt
  \belowdisplayskip=\abovedisplayskip
  \flushleft
}

\ifCls@mpsi@marge
  %%%%%%%%%%%%%%%%%%% 
   %% Si on demande les marges
   %%%%%%%%%%%%%%%%%%% 
  \reversemarginpar
  \ifCls@mpsi@colonne
  \RequirePackage[a4paper,margin=1cm,landscape,marginparwidth=2cm,%headsep=10pt,
  includeall,\Cls@mpsi@driver]{geometry}
  \else \RequirePackage[a4paper,margin=1cm,marginparwidth=2cm,%headsep=10pt,
  includeall,\Cls@mpsi@driver]{geometry}
  \fi

  \def\Cls@mpsi@epaisseur@marge{.8pt}

   \def\Cls@mpsi@classe@lycee@anneesco{%
     \shortstack{\textbf{\@classe}\\ \scriptsize\@lycee \\
       \scriptsize\@anneesco}
   }

%   \def\Cls@mpsi@titre@mis@en@forme{\Large\textbf{\@title}}

  \RequirePackage{calc}

  %%%%%%%%%%%%%%%%%%%%%%%% 
  %%%%%%% Calcul des tailles
  %%%%%%%%%%%%%%%%%%%%%%%% 
  \def\@dimtonum#1#2{\edef#2{\@@dimtonum#1}}
  \def\@@dimtonum#1{\expandafter\@@@dimtonum\the#1}
  {\catcode`\p=12 \catcode`\t=12 \global\@namedef{@@@dimtonum}#1pt{#1}}

  \newlength\Cls@mpsi@longueur@
  \newlength\Cls@mpsi@longueur@@
    
  \Cls@mpsi@longueur@=.8\marginparsep
  \setlength{\Cls@mpsi@longueur@@}{\Cls@mpsi@longueur@}
  \@dimtonum{\Cls@mpsi@longueur@}{\Cls@mpsi@separation@marge@texte}
  
  \Cls@mpsi@longueur@=0pt
% \advance\Cls@lycee@longueur@\headheight
  \advance\Cls@mpsi@longueur@\headsep
  \advance\Cls@mpsi@longueur@\textheight
  \advance\Cls@mpsi@longueur@\footskip
  \@dimtonum{\Cls@mpsi@longueur@}{\Cls@mpsi@hauteur@marge}
  
  \setlength{\Cls@mpsi@longueur@}{%
      (1in+\hoffset+\oddsidemargin+\widthof{\Cls@mpsi@classe@lycee@anneesco}-\Cls@mpsi@longueur@@)/2}
  \@dimtonum{\Cls@mpsi@longueur@}{\Cls@mpsi@positionx@classe@lycee@anneesco}

  \setlength{\Cls@mpsi@longueur@}{%
      (\heightof{\Cls@mpsi@classe@lycee@anneesco})/2}
  \@dimtonum{\Cls@mpsi@longueur@}{\Cls@mpsi@positiony@classe@lycee@anneesco}

  \setlength{\Cls@mpsi@longueur@}{%
      1in+\hoffset+\oddsidemargin-\marginparsep}
  \@dimtonum{\Cls@mpsi@longueur@}{\Cls@mpsi@position@version}

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  %%%%%%%%% Définitions des heades/footers
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  \def\Cls@mpsi@pagestyle@marge{%
    \def\headrulewidth{0cm}

    \lhead{%
      \unitlength=1pt
      \begin{picture}(0,0)
        \put(-\Cls@mpsi@separation@marge@texte,-\Cls@mpsi@hauteur@marge){%
          \linethickness{\Cls@mpsi@epaisseur@marge}
          \line(0,\headheight){\Cls@mpsi@hauteur@marge}
        }
        \put(-\Cls@mpsi@positionx@classe@lycee@anneesco,-\Cls@mpsi@positiony@classe@lycee@anneesco){%
          \Cls@mpsi@classe@lycee@anneesco}
      \end{picture}%
    }
    \chead{\Large \textbf{\textsf{\@title}}
    }
    \rhead{}
    \cfoot{\textsc{\thepage}/\textsc{\pageref{VeryLastPage}}}
    \lfoot{%
      \ifCls@mpsi@noVersion
      \else
      \unitlength=1pt
      \begin{picture}(0,0)
        \put(-\Cls@mpsi@position@version,0){%
          \rotatebox[origin=tl]{90}{%
            \tiny\textsl{\texttt{\jobname.tex},version du \timestamp}
          }
        }
      \end{picture}
      \fi
    }

  }
  \Cls@mpsi@pagestyle@marge
  \pagestyle{fancy}
  \fancypagestyle{plain}{\Cls@mpsi@pagestyle@marge}
  \else

  %%%%%%%%%%%%%%%%%%%%%%
  %% Si on ne demande pas de  marges
  %%%%%%%%%%%%%%%%%%%%%%
  \renewcommand{\footrulewidth}{0.4pt}
  \lhead{\@classe \xspace, \@lycee}
  \chead{%
    \ifnum\thepage=1 
    \ifCls@mpsi@colonne \LARGE\textbf{\textsf{\@title}}
    \else \large\textbf{\textsf{\@title}}
    \fi
    \else \large\textbf{\textsf{\@title}}
    \fi
    %
    % \ifx\@title\@empty
    % \else
    % \ifnum\thepage=1
    % \else 
    % \fi
    % \fi
  }

  \rhead{%
    % \ifx \mpsi@doc exos
    % \makesemaine
    % \else
    % \jour
    % \fi
    \ifexos \makesemaine  \fi
    \ifDS   \@jour   \fi
    \ifDM \makepourle \fi
    \ifcours \@jour \fi
    \ifTP \@jour \fi
  }
  
  \ifCls@mpsi@colonne
     %%%%%%%%%%%%%%%%%%
     % Si on demande le twocolumn
     %%%%%%%%%%%%%%%%%%
    \RequirePackage[a4paper,margin=1.5cm,includeheadfoot,landscape,\Cls@mpsi@driver,headsep=18pt]{geometry}
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
     
  \else
  %%%%%%%%%%%%%%%%%%%%%%
  % Si on ne demande pas le twocolumn
  %%%%%%%%%%%%%%%%%%%%%%
  \RequirePackage[a4paper,margin=1cm,includeheadfoot,\Cls@mpsi@driver,headsep=15pt]{geometry}
  \pagestyle{fancy}
%  \def\headrulewidth{0cm}
  \lfoot{%
    \ifCls@mpsi@noVersion
    \else
    \unitlength=1cm
    \begin{picture}(0,0)
      \put(-.5,0){%
        \rotatebox[origin=tl]{90}{%
          \tiny\textsl{\texttt{\jobname.tex},version du \timestamp}
        }
      }
    \end{picture}
    \fi
    \@auteur\xspace
  }
  \cfoot{\textsc{\thepage}/\textsc{\pageref{VeryLastPage}}}
  \rfoot{\@licence}
  \fi
\fi

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



\RequirePackage{enumerate,enumitem,psfrag}


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Pstricks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifPstricks
\RequirePackage{pstricks}
\RequirePackage{pstricks-add}
\RequirePackage{pst-plot,pst-grad,pst-node,multido,pst-coil,pst-eucl,pst-math}
\RequirePackage{auto-pst-pdf} % pour compiler avec pdflatex du code
                              % pstricks

% Workaround pour une incompatibilité entre psgraph et auto-pst-pdf
\RequirePackage{ifpdf}
\ifpdf
  \let\psgraph=\postscript
  \let\endpsgraph=\endpostscript
% \else
%   \PreviewEnvironment{psgraph}
\fi
\fi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

\ifbeamerarticle
\RequirePackage[frenchstyle,narrowiints,partialup,noamsmath]{kpfonts}
\RequirePackage[noamsthm]{beamerarticle}
\else
\RequirePackage[frenchstyle,narrowiints,partialup]{kpfonts}
\fi


% les lignes suivantes ne sont pas nécessaires si on utilise kpfonts
%\RequirePackage{amssymb}
%\RequirePackage{amsmath} 
%\RequirePackage{wasysym} %pour les intégrales doubles fermées
% \usepackage[sc]{mathpazo}
%\linespread{1.05}
%\usepackage[mdugm]{mathdesign}
%\usepackage{concmath}
%\usepackage[adobe-utopia]{mathdesign}

%\DeclareMathSymbol{\upOmega}{\mathord}{letters}{010}
%\RequirePackage[Omega]{gensymb_wilk}
\RequirePackage[Omega]{gensymb}
\RequirePackage[loose]{units}
\RequirePackage[locale = FR]{siunitx}
\sisetup{%
  inter-unit-separator = \ensuremath{{} \cdot {}},
  output-decimal-marker = {,},
  exponent-product = \ensuremath{{} \cdot {}},
  group-four-digits = false,
  per-mode = reciprocal,
  separate-uncertainty = true,
  multi-part-units = single}
%\RequirePackage{textcomp,icomma,fixmath}
\RequirePackage{icomma}
%\RequirePackage{upgreek}
\newcommand{\valeur}[2][]{\unit[\nombre{#1}]{#2}}

% (gensymb_wilk à cause d'un conflit sur \degres, units pour taper
% correctement des valeurs numériques, icomma aussi et fixmath pour avoir
% des grecques italiques quand ce sont des variables)
% apparemment, il n'y a plus de conflit...

\input{shortcut}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Restes...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% \RequirePackage{warning,pifont}

% \def\unding{\ding{202}}%
% \def\deuxding{\ding{203}}%
% \def\troisding{\ding{204}}%
% \def\quantreding{\ding{205}}%
% \def\cinqding{\ding{206}}%
% \def\sixding{\ding{207}}%
% \def\septding{\ding{208}}%
% \def\huitding{\ding{209}}%
% \def\neufding{\ding{210}}%


% % Complément de D.Arsenault (janv 04 ctt)
% \def\wrapfill{\par
%   \ifx\parshape\WF@fudgeparshape
%     \nobreak
%     \ifnum\c@WF@wrappedlines>\@ne
%       \advance\c@WF@wrappedlines\m@ne
%       \vskip\c@WF@wrappedlines\baselineskip
%       \global\c@WF@wrappedlines\z@
%     \fi
%     \allowbreak
%     \WF@finale
%   \fi
% }

\endinput
