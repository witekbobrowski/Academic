%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% File:     config.cls           (LaTeX Document class option "config")
%
% Author:  Marcin Szpyrka     (mszpyrka@agh.edu.pl)
%          Grzegorz J. Nalepa (gjn@agh.edu.pl)
%          AGH University of Science and Technology, Krak�w, POLAND
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\message{*** [config.cls] ---  (MSz, GJN)  v0.22 <05.04.2011>  ***}

\newif\ifpdflatex\pdflatexfalse
\NeedsTeXFormat{LaTeX2e} %
\ProvidesClass{config}
\DeclareOption{pdflatex}{\pdflatextrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\LoadClass[a4paper,oneside]{report}


\RequirePackage{times}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage[usenames]{color}
\RequirePackage{fancyhdr}
\RequirePackage{url}
\RequirePackage{titlesec}
\RequirePackage{tocloft}

\usepackage[utf8]{inputenc}
\usepackage{polski}

\geometry{lmargin=30mm, rmargin=20mm, tmargin=25mm, bmargin=25mm, foot=10mm, head=10mm}
\definecolor{Green}{rgb}{0.1,0.5,0.1}

\def\shorttitlePL#1   {\gdef\@shorttitlePL{#1}}
\def\shorttitleEN#1   {\gdef\@shorttitleEN{#1}}
\def\shortauthor#1    {\gdef\@shortauthor{#1}}
\def\titlePL#1        {\gdef\@titlePL{#1}}
\def\titleEN#1        {\gdef\@titleEN{#1}}
\def\facultyEN#1      {\gdef\@facultyEN{#1}}
\def\facultyPL#1      {\gdef\@facultyPL{#1}}
\def\supervisorPL#1   {\gdef\@supervisorPL{#1}}
\def\supervisorEN#1   {\gdef\@supervisorEN{#1}}
\def\acknowledgements#1   {\gdef\@acknowledgements{#1}}

% \thesisheaders
%
% \pagestyle{fancy}

%\bibliographystyle{abbrv}
\linespread{1.3}
\renewcommand{\labelitemi}{$\bullet$}

%------------------------------------------------------------------------------
\usepackage{hyperref}

%------------------------------------------------------------------------------

\usepackage{listings}
\usepackage{color}
\definecolor{lightgray}{rgb}{.9,.9,.9}
\definecolor{darkgray}{rgb}{.4,.4,.4}
\definecolor{purple}{rgb}{0.65, 0.12, 0.82}
\definecolor{maroon}{rgb}{0.5,0,0}
\definecolor{darkgreen}{rgb}{0,0.5,0}
\definecolor{darkblue}{rgb}{0,0,.3}
\definecolor{swift-keyword}{rgb}{0.66,0.05,0.56}
\definecolor{swift-comment}{rgb}{0,0.45,0}
\definecolor{swift-type}{rgb}{0.24,0.43,0.45}
\definecolor{swift-string}{rgb}{0.76,0.10,0.08}
%
% \lstset{identifierstyle=\idstyle}
%
% \makeatletter
% \newcommand*\idstyle{%
%         \expandafter\id@style\the\lst@token\relax
% }
% \def\id@style#1#2\relax{%
%         \ifcat#1\relax\else
%                 \ifnum`#1=\uccode`#1%
%                         \color{swift-type}\bfseries
%                 \fi
%         \fi
% }
% \makeatother
%
\lstdefinelanguage{JavaScript}{
  keywords={typeof, new, true, false, catch, function, return, null, catch, switch, var, if, in, while, do, else, case, break},
  keywordstyle=\color{blue}\bfseries,
  ndkeywords={class, export, boolean, throw, implements, import, this},
  ndkeywordstyle=\color{darkgray}\bfseries,
  identifierstyle=\color{black},
  sensitive=false,
  comment=[l]{//},
  morecomment=[s]{/*}{*/},
  commentstyle=\color{purple}\ttfamily,
  stringstyle=\color{red}\ttfamily,
  morestring=[b]',
  morestring=[b]"
}

\lstdefinelanguage{swift}{
  backgroundcolor=\color{white},
  keywords={associatedtype, class, deinit, enum, extension, fileprivate, func, import, init, inout, internal, let, open, operator, private, protocol, public, static, struct, subscript, typealias, var, break, case, continue, default, defer, do, else, fallthrough, for, guard, if, in, repeat, return, switch, where, while, as, Any, catch, false, is, nil, rethrows, super, self, Self, throw, throws, true, try},
  comment=[l]{//},
  morecomment=[s]{/*}{*/},
  keywordstyle=\color{swift-keyword}\bfseries,
  commentstyle=\color{swift-comment}\ttfamily,
  stringstyle=\color{swift-string}\ttfamily,
  morestring=[b]',
  morestring=[b]"
}

\lstdefinelanguage{swift-reference}{
  numbers=none,
  backgroundcolor=\color{white},
  keywords={associatedtype, class, deinit, enum, extension, fileprivate, func, import, init, inout, internal, let, open, operator, private, protocol, public, static, struct, subscript, typealias, var, break, case, continue, default, defer, do, else, fallthrough, for, guard, if, in, repeat, return, switch, where, while, as, Any, catch, false, is, nil, rethrows, super, self, Self, throw, throws, true, try},
  comment=[l]{//},
  morecomment=[s]{/*}{*/},
  keywordstyle=\color{swift-keyword}\bfseries,
  commentstyle=\color{swift-comment}\ttfamily,
  stringstyle=\color{swift-string}\ttfamily,
  morestring=[b]',
  morestring=[b]"
}

\lstset{
   language=JavaScript,
   backgroundcolor=\color{lightgray},
   extendedchars=true,
   basicstyle=\footnotesize\ttfamily,
   showstringspaces=false,
   showspaces=false,
   numbers=left,
   numberstyle=\footnotesize,
   numbersep=9pt,
   tabsize=2,
   breaklines=true,
   showtabs=false,
   captionpos=b
}

%--------------------------

\newcommand{\titlepages}{%

\newpage \titlepage

\begin{center}

{\sffamily{\LARGE{\textsc Uniwersytet Jagielloński w Krakowie}}

\vspace*{1mm}

{\Large \@facultyPL}}\\\vspace*{2mm}

\ifpdflatex\includegraphics[scale=0.3]{uj}
\else\includegraphics[scale=0.7]{uj}
\fi
\vspace*{1cm}

{\LARGE\bfseries\scshape \@author}\\\vspace*{1mm}
{\large{\scshape Numer albumu: 1115454}}\\\vspace*{2cm}

{\huge{\bfseries\scshape \@titlePL}}\\\vspace*{2mm}
{\large{\scshape Praca licencjacka na kierunku Informatyka}}\\\vspace*{3cm}

\begin{flushright}
\begin{minipage}[!h]{7cm}
\large{\scshape Praca wykonana pod kierunkiem:}\\ \@supervisorPL \\ Zakład Technologii Informatycznych
\end{minipage}
\end{flushright}

\vfill{\large Kraków 2017}

\end{center}

\clearpage \titlepage  \vspace*{3cm}

%%%%%%%%%%%%%%%%%%%%%%%%%% strona z oswiadczeniami:

\begin{flushleft}
\textbf{\Large Oświadczenie autora pracy}
\end{flushleft}

{\large
Świadom odpowiedzialności prawnej oświadczam, że niniejsza
praca dyplomowa została napisana przeze mnie samodzielnie
i nie zawiera treści uzyskanych w sposób niezgodny
z obowiązującymi przepisami.

Oświadczam również, że przedstawiona praca nie była wcześniej
przedmiotem procedur związanych z uzyskaniem tytułu
zawodowego w wyższej uczelni.

\vspace{1.5cm}
\begin{flushleft}
Kraków, dnia \hfill Podpis autora pracy
\end{flushleft}}

\vspace{3cm}
\begin{flushleft}
\textbf{\Large Oświadczenie kierującego pracą}
\end{flushleft}

{\large
Potwierdzam, że niniejsza praca została przygotowana
pod moim kierunkiem i kwalifikuje się do przedstawienia jej
w postępowaniu o nadanie tytułu zawodowego.

\vspace{1.5cm}
\begin{flushleft}
Kraków, dnia  \hfill Podpis kierującego pracą

\end{flushleft}}

%%%%%%%%%%%%%%%%%%%%%%%%%% strona po angielsku czy moze isc od razu po polskiej?

%\clearpage \titlepage

%\begin{center}

%{\sffamily{\LARGE{\textsc Jagiellonian University in Krakow}}

%\vspace*{1mm}

%{\Large \@facultyEN}}\\\vspace*{2mm}

%\ifpdflatex\includegraphics[scale=0.3]{uj}
%\else\includegraphics[scale=0.7]{uj}
%\fi
%\vspace*{1cm}

%{\LARGE\bfseries\scshape \@author}\\\vspace*{1mm}
%{\large{\scshape Student number: 1078760}}\\\vspace*{2cm}

%{\huge{\bfseries\scshape \@titleEN}}\\\vspace*{2mm}
%{\large{\scshape Bachelor thesis in Computer Science}}\\\vspace*{3cm}

%\begin{flushright}
%\begin{minipage}[!h]{7cm}
%\large{\scshape Bachelor thesis written under supervision of:}\\ \@supervisorEN \\ Department of Information Technologies
%\end{minipage}
%\end{flushright}

%\vfill{\large Krakow \@date}

%\end{center}

%%%%%%%%%%%%%%%%%%%%%%%%%% strona z abstractem

\clearpage \titlepage
\begin{center}
\textbf{\LARGE Streszczenie}
\end{center}

\begin{flushleft}
{\large
Poniższa praca powstała w celu opisania biblioteki \textbf{EPUBKit}. Biblioteka ta ma na celu obsługę plików w formacie \textit{EPUB}, oraz dostarczenie możliwości ich wyświetlenia. \textbf{EPUBKit} jest napisany w języku Swift na platformę iOS. Rozpoczynając od opisu użytych narzędzi oraz technologii, przechodzę do charakteryzacji standardu \textit{EPUB}, szczegółowo omawiając jego strukturę. Kolejny rozdział zawiera dogłębną analizę biblioteki \textbf{EPUBKit}. Pracę kończy omówienie procesu tworzenia aplikacji na iOS oraz wykorzystania w niej biblioteki \textbf{EPUBKit}.

    \textbf{Słowa kluczowe:} iOS, Swift, EPUB, parser, czytnik książek elektronicznych, aplikacja.
}
\end{flushleft}

\vspace{3cm}

\begin{center}
\textbf{\LARGE Abstract}
\end{center}

\begin{flushleft}
{\large
The purpose of this thesis is to present the \textbf{EPUBKit} library. The goal of the library is to handle \textit{EPUB} documents and give the possibility of displaying them on an iOS device. \textbf{EPUBKit} is written using swift language and avaiable exclusively for iOS platform. Starting off with the description of used tools and technologies, I will move onto covering the \textit{EPUB} standard in greater depth. Afterwards, deep analysis of my library will follow. Thesis ends with the description of iOS applications creation process with special emphasis on the \textbf{EPUBKit} and how it fits in this landscape.

    \textbf{Keywords:} iOS, Swift, EPUB, parser, e-reader, application.
}
\end{flushleft}

%%%%%%%%%%%%%%%%%%%%%%%%%% spis tresci


\clearpage

\setcounter{page}{5}

}

\def\thesisheaders{
\fancyfoot[L]{\small \@shortauthor\quad\textit{\@shorttitlePL}}
}

\DeclareOption{en}{
\def\thesisheaders{
\fancyfoot[L]{\small \@shortauthor\quad\textit{\@shorttitleEN}}
}
}

\ProcessOptions

\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0.5pt}
\fancyhf{}
\fancyhead{}
\fancyhead[L]{\slshape{\small \rightmark}}
\fancyhead[R]{\bfseries \thepage}

\thesisheaders

\frenchspacing
\sloppy
\widowpenalty     9999
\clubpenalty      9999
\flushbottom

%---------------------------------------------------------------------------
% Ustawienia parametr�w dla tytu��w rozdzia��w, podrozdzia��w, itd.
%---------------------------------------------------------------------------


\titleformat{\chapter}[block]
{\bfseries\LARGE}{\filright \LARGE\thechapter. }{0ex}{}
%odst�py: lewy, g�ra, d��
\titlespacing{\chapter}{0pt}{17mm}{19mm}
\titleformat{\section}[block]
{\bfseries\Large}{\filright \Large\thesection. }{0ex}{}
\titlespacing{\section}{7mm}{8mm plus 0mm minus 1mm}{4mm plus 0mm minus 1mm}
\titleformat{\subsection}[block]
{\bfseries\large}{\filright \large\thesubsection. }{0ex}{}
\titlespacing{\subsection}{7mm}{6mm}{2.5mm}
\titleformat{\subsubsection}[block]
{\bfseries\normalsize}{\filright \normalsize\thesubsubsection. }{0ex}{}
\titlespacing{\subsubsection}{7mm}{3mm}{1.5mm}

%---------------------------------------------------------------------------
% Ustawienia parametr�w generowania spisu tre�ci i spisu rysunk�w
%---------------------------------------------------------------------------

\renewcommand{\cfttoctitlefont}{\bfseries\Large}
\renewcommand{\cftbeforetoctitleskip}{20mm}
\renewcommand{\cftaftertoctitleskip}{19mm}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdot}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdot}}
\renewcommand{\cftsubsecleader}{\cftdotfill{\cftdot}}
\renewcommand{\cftchapaftersnum}{.}
\renewcommand{\cftsecaftersnum}{.}
\renewcommand{\cftsubsecaftersnum}{.}
\setlength{\cftparskip}{2pt}
\setlength{\cftbeforechapskip}{0mm}
\renewcommand{\cftchappagefont}{\normalsize}
