\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mpsi}[2015/07/26 par Julien Cubizolles]
\makeatletter
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Options de classe
%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{xkeyval}

\newif\ifcours
\courstrue
\DeclareOptionX{cours}[true]{\courstrue}

\newif\ifDS
\DeclareOptionX{DS}[false]{\DStrue}

\newif\ifDM
\DeclareOptionX{DM}[false]{\DMtrue}

\newif\ifexos
\DeclareOptionX{exos}[false]{\exostrue}

\newif\ifTP
\DeclareOptionX{TP}[false]{\TPtrue}

\newif\ifCls@mpsi@colonne
\DeclareOptionX{colonne}[true]{\@nameuse{Cls@mpsi@colonne#1}}

\newif\ifcorr
\corrtrue
\DeclareOptionX{nocorr}[false]{\corrfalse}

\newif\ifCls@mpsi@noVersion
\DeclareOptionX{noVersion}[true]{\@nameuse{Cls@mpsi@noVersion#1}}
        
\def\Cls@mpsi@class{extarticle}

\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{\Cls@mpsi@class}}

\ProcessOptionsX

\ifCls@mpsi@colonne
    \PassOptionsToClass{twocolumn,landscape}{\Cls@mpsi@class}
\fi

\LoadClass[a4paper]{\Cls@mpsi@class}

\input{configuration-base.tex}

%% Attention, des conflits entre standalone et pstricks: standalone
%% doit être chargé avant pstricks
%% \item (LaTeX Error: Command \clipbox already defined.
% Or name \end... illegal, see p.192 of the manual.)
\RequirePackage{standalone}

\RequirePackage{pageslts}
\AtBeginDocument{\pagenumbering{arabic}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%    Sections
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{framed}

\RequirePackage[hyperref,framed,thmmarks]{ntheorem}

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

\RequirePackage[framemethod=TikZ,xcolor]{mdframed}
\newmdenv[roundcorner=5pt,backgroundcolor=gray!30,skipabove=5pt]{important}

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

\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\alph{subsubsection}}

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

\newcommand{\dontcount}{
  \addtocounter{page}{-1}
%  \immediate\write\@auxout{\string\newlabel{LastPage}{{}{\thepage}{}{page.\thepage}{}}}%
%  \addtocounter{page}{1}
}

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

\renewcommand{\solproblabel}[1]{\textbf{\large \textsf{Correction du
         problème \textbf{#1}}}}

\renewcommand{\solexolabel}[1]{\textbf{\large \textsf{Correction de
      l'exercice  \textbf{#1}}}}

\renewcommand{\corprob}{\refstepcounter{bogusprob}\oldcorprob}
\renewcommand{\corexo}{\refstepcounter{bogusexo}\oldcorexo}

\let\oldsolprob\solprob
\renewcommand{\solprob}[1]{\oldsolprob{#1}\ \par} 
\let\oldsolexo\solexo
\renewcommand{\solexo}[1]{\oldsolexo{#1}\ \par} 

\@addtoreset{section}{probleme}
\@addtoreset{section}{solprob}

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
  \cleardoublepage
  \Readsolutionfile{mycor}
  \fi
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

\AtBeginDocument{%
  \abovedisplayskip=6pt plus 1.5pt minus 3.5pt
  \belowdisplayskip=\abovedisplayskip
  \flushleft
}

\renewcommand{\footrulewidth}{0.4pt}
\lhead{\@classe \xspace, \@lycee}
\chead{%
  \ifnum\thepage=1 
  \ifCls@mpsi@colonne \LARGE\textbf{\textsf{\@title}}
  \else \large\textbf{\textsf{\@title}}
  \fi
  \else \large\textbf{\textsf{\@title}}
  \fi
}

\rhead{%
    \ifexos \makesemaine  \fi
    \ifDS   \@jour   \fi
    \ifDM \makepourle \fi
    \ifTP \@jour \fi
    \ifcours \@jour \fi
  }
  
  \ifCls@mpsi@colonne
     %%%%%%%%%%%%%%%%%%
     % Si on demande le twocolumn
     %%%%%%%%%%%%%%%%%%
    \RequirePackage[a4paper,margin=1.5cm,includeheadfoot,landscape,headsep=18pt]{geometry}
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
  \RequirePackage[a4paper,margin=1cm,includeheadfoot,headsep=15pt]{geometry}
  \pagestyle{fancy}
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%  Géométrie - fin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Packages nécessaires
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \reserveinserts{28}
%et pour en avoir davantage

% \RequirePackage{ae,aecompl}


%\frenchbsetup{AutoSpacePunctuation=true}
% \RequirePackage{numprint}
% \RequirePackage{psfrag} 

% \RequirePackage[cyr]{aeguill} 


%\RequirePackage{frcursive}
% \RequirePackage[T1]{fontenc}
% \RequirePackage{lmodern}



%\RequirePackage{wrapfig}   %%%%%%% figures

%\RequirePackage{manfnt,mathrsfs} % des fontes


% \input{shortcut}
% \input{chimie}

\makeatother
\endinput
