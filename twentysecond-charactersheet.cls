% Class File for twentysecond-charactersheet resume
% This file is a modification of twentysecondcv.cls and friggeri-cv.cls and cies-briejs-resume.sty
% Plus my own code and comments

% Plus applicable licenses

% A Note about the units

%%% Class Definition %%%
\ProvidesClass{twentysecond-charactersheet}[2017/04/26 twentysecond-charactersheet resume class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

%%% Required Packages %%%
\RequirePackage[left=3.25in,top=0in,right=0.50in,bottom=0.25in,nohead,nofoot]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[sfdefault]{ClearSans}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{ifxetex}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{metalogo}
\RequirePackage[usenames,dvipsnames,svgnames]{xcolor}
\RequirePackage[style=verbose, sorting=ydnt]{biblatex}
\RequirePackage[math-style=TeX]{unicode-math}
\RequirePackage{parskip}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{fontawesome}
\RequirePackage{qrcode}

% Graphics packages
\RequirePackage{tikz}
\RequirePackage{graphicx}

% Incremental steps toward typographic perfection
\usepackage[protrusion]{microtype}

% Constructs the pretty graphical timeline for cventry dates
\RequirePackage{moderntimeline}

% For \textscale
\RequirePackage{relsize}

\usepackage{enumitem}
\setlist[itemize]{leftmargin=*}

% if building with xetex this will allow you to add hyperlinks to image buttons
\ifxetex
	\usepackage{letltxmacro}
	\setlength{\XeTeXLinkMargin}{1pt}
	\LetLtxMacro\SavedIncludeGraphics\includegraphics
	\def\includegraphics#1#{\IncludeGraphicsAux{#1}} % #1 catches optional stuff (star/opt. arg.)
	\newcommand*{\IncludeGraphicsAux}[2]{\XeTeXLinkBox{\SavedIncludeGraphics#1{#2}}
}
\fi

% Set metadata for output pdf
\hypersetup{
	pdftitle={},
	pdfauthor={},
	pdfsubject={},
	pdfkeywords={},
	colorlinks=false,
	allbordercolors=white
}

% Color Definitions

% Sidebar color
\definecolor{sidecolor}{HTML}{E7E7E7}

% Hyperlink color
\definecolor{pblue}{HTML}{0395DE}

\definecolor{mainblue}{HTML}{0E5484}

\definecolor{maingray}{HTML}{B9B9B9}
\definecolor{lightgray}{HTML}{999999}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}

% Icon colors
\definecolor{github-blackish}{HTML}{171516}
\definecolor{linkedin-blue}{HTML}{0077B5}
\definecolor{quora-red}{HTML}{B92B27}
\definecolor{skype-blue}{HTML}{00AFF0}
\definecolor{manila-file-folder}{HTML}{F8F5E1}

% Golds
\definecolor{gold}{HTML}{FFD700}
\definecolor{gold-metallic}{HTML}{D4AF37}


% Color changes when printing
\ifdefined\@cv@print
	\colorlet{green}{gray}
	\colorlet{orange}{gray}
	\colorlet{purple}{gray}
	\colorlet{red}{gray}
	\colorlet{blue}{gray}
	\colorlet{fillheader}{white}
	\colorlet{header}{gray}
\else
	\colorlet{fillheader}{white}
	\colorlet{header}{gray}
\fi

% Set TEXT COLOR
\colorlet{textcolor}{gray}

% Set HEADER COLOR
\colorlet{headercolor}{gray}

% Set TIMELINE COLORS
\colorlet{timeline-color}{gray}
\colorlet{color1}{gray}

%%% FONTS %%%

% MAIN FONT
\setmainfont[
  Mapping = tex-text,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{Roboto}

% HEADING FONT
\newfontfamily\headingfont[
  Mapping = tex-text,
  UprightFont=*-Regular,
  ItalicFont=*-Italic,
  BoldFont=*-Bold,
  BoldItalicFont=*-BoldItalic,
]{Roboto}

% TWENTYHEADING FONT
\newfontfamily\twentyheadingfont{Segoe UI}

% FONTAWESOME
\newfontfamily\FA{FontAwesome}

% SANS FONT
%\newfontfamily\gyreheros[
%	Extension = .otf,
%	Mapping = tex-text,
%	Numbers = OldStyle,
%	Ligatures = {Common,Contextual},
%	UprightFont=*-regular,
%	ItalicFont=*-italic,
%	BoldFont=*-bold,
%	BoldItalicFont=*-bolditalic
%]{texgyreheros}

% SERIF FONT
%\newfontfamily\bodyserif[
%	Extension = .otf,
%	Mapping = tex-text,
%	Numbers = OldStyle,
%	Ligatures = {Common,Contextual},
%	UprightFont=*-regular,
%	ItalicFont=*-italic,
%	BoldFont=*-bold,
%	BoldItalicFont=*-bolditalic
%]{texgyrepagella}

% Optionally use the Linux Libertine font (it has nice lignatures)
%\newfontfamily\linuxlibertine[
%	Mapping = tex-text,
%	Numbers = OldStyle,
%	Ligatures = {Common,Contextual},
%]{Linux Libertine O}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% BEGIN SIDE BAR %%%%%%%%%%

% The sidebar is composed of a 3-inch colored rectangle (tikz image) that runs the length of the left side of the page.
% Within the rectangle is a text box with the various elements of the sidebar called in order from top to bottom.
% The commands for the smartdiagram and the progress bars are defined below.

% Left margin
\setlength{\TPHorizModule}{28pt}

% Top margin
\setlength{\TPVertModule}{24pt}

%%% Sidebar Command Definitions %%%
\newlength\imagewidth
\pgfmathsetlength{\imagewidth}{2in}

% Set the RESOLUTION of the sidebar image
\newlength\imagescale
\pgfmathsetlength{\imagescale}{\imagewidth/600}

% Sidebar SECTION style
\newcommand{\sidebarsection}[2]{{\color{headercolor}}\huge #1\rule[0.15\baselineskip]{#2}{1pt}}

% Sidebar SUBSECTION style
\newcommand{\sidebarsubsection}[1]{\Large #1\newline}

% Commands for CV info
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\linkedinusername}[1]{\renewcommand{\linkedinusername}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvquora}[1]{\renewcommand{\cvquora}{#1}}
\newcommand{\quorausername}[1]{\renewcommand{\quorausername}{#1}}
\newcommand{\skype}[1]{\renewcommand{\skype}{#1}}
\newcommand{\githubusername}[1]{\renewcommand{\githubusername}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvnumbersimple}[1]{\renewcommand{\cvnumbersimple}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\logowidth}[1]{\renewcommand{\logowidth}{#1}}
\newcommand{\qrtext}[1]{\renewcommand{\qrtext}{#1}}

%%% Smart Diagram %%%
\usepackage{smartdiagram}

\smartdiagramset{%
	% inner font size
	bubble center node font = \footnotesize,
	% outer font size
	bubble node font = \scriptsize,
	% minimum center bubble size
	bubble center node size = 16pt,
	% minimum outer bubble size
	bubble node size = 16pt,
	% distance between center and outer bubbles
	distance center/other bubbles = 16pt,
	% distance from text to border in center node
	distance text center bubble = 16pt,
	% center bubble color
	bubble center node color = Crimson!70,
	% list of colors
	set color list = {SteelBlue, PowderBlue, RoyalBlue, Gold, Yellow, LightGoldenrod},
	% bubble opacity
	bubble fill opacity = 0.60,
	% bubble text opacity
	bubble text opacity = 0.80,
}

% Command for printing progress bars (languages)
\newcommand\languages[1]{\renewcommand{\languages}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6.55, \i+0.4);
				\draw[fill=white,SkyBlue](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.30) {\small{\x}};
			}
		\end{tikzpicture}
	}
}

% Command for printing progress bars (programming)
\newcommand\programming[1]{\renewcommand{\programming}{
		\begin{tikzpicture}
			\foreach [count=\i] \x/\y in {#1}{
				\draw[fill=maingray,maingray] (0,\i) rectangle (6.55, \i+0.4);
				\draw[fill=white,DodgerBlue!80](0,\i) rectangle (\y,\i+0.4);
				\node [above right] at (0,\i+0.30) {\small{\x}};
			}
		\end{tikzpicture}
	}
}

% Command for making rounded rectangular boxes around characters (for FontAwesome integration)
\newcommand*{\icon}[1]{%
	\tikz[baseline=(char.base)]{\node[shape=rectangle,rounded corners=3,draw,inner sep=0pt, fill=black,white,text=sidecolor, scale=0.60] (char) {#1};
	}
}

%%% Sidebar Layout %%%

\newcommand{\makesidebar}{%

	% pretty colored rectangle for the sidebar
	\begin{tikzpicture}[remember picture,overlay]
		\node [rectangle, fill=sidecolor, anchor=north west, minimum width=3in, minimum height=\paperheight+1cm] (box) at (-3.275in,0.40in){};
	\end{tikzpicture}

	% Start sidebar text block
	\begin{textblock}{6.55}(0.5, 0.2)

		% Pic
		\ifthenelse{\equal{\profilepic}{}}{}{\begin{center} \includegraphics[scale=1.00]{\profilepic} \end{center}}

		\begin{tabular}{p{28pt} @{\hskip 12pt}p{2in}}

			% Phone
			\ifthenelse{\equal{\cvnumberphone}{}}{}{{$\begin{array}{l}%
				{\hspace{3.5pt}\href{tel:\cvnumbersimple}{\rlap{\color{lightgray}\large\textnormal{\raisebox{7pt}{\faStop}}}}{\rlap{\color{lightgray}\large\textnormal{\raisebox{1.5pt}{\faCircle}}}}{\color{github-blackish}\Huge\textnormal\faMobile}}\end{array}$} & \href{tel:\cvnumbersimple}{\small\cvnumberphone} \\ }

			% Email
           \ifthenelse{\equal{\cvmail}{}}{}{{$\begin{array}{l}%
            	{\href{mailto:\cvmail}{\rlap{\color{manila-file-folder}\LARGE\textnormal\faEnvelope}}{\color{github-blackish}\LARGE\textnormal\faEnvelopeO}}\end{array}$} & \href{mailto:\cvmail}{\small\cvmail} \\ }

			% Skype
			\ifthenelse{\equal{\skype}{}}{}{{$\begin{array}{l}%
				 \href{skype:\skype?call}{\rlap{\color{white}\Large\textnormal{\hspace{2pt}\raisebox{2pt}{\faCircle}}}}{\color{skype-blue}\huge\textnormal\faSkype} \end{array}$} & \href{skype:\skype?call}{\small\skype} \\ }

			% LinkedIn
			\ifthenelse{\equal{\cvlinkedin}{}}{}{{$\begin{array}{l}%
				{\href{\cvlinkedin}{\color{linkedin-blue}\huge\textnormal\faLinkedin}}\end{array}$} & \href{\cvlinkedin}{\small{\linkedinusername}}\\}

			% Github
			\ifthenelse{\equal{\cvgithub}{}}{}{{$\begin{array}{l}%
				{\href{\cvgithub}{\color{github-blackish}\huge\textnormal\faGithub}}\end{array}$} & \href{\cvgithub}{\small{\githubusername}} \\ }

			% Quora
			\ifthenelse{\equal{\cvquora}{}}{}{{$\begin{array}{l}%
				{\href{\cvquora}{\color{quora-red}\LARGE\textnormal\faQuora}}\end{array}$} & \href{\cvquora}{\small{\quorausername}} \\ }

		\end{tabular}

		\sidebarsection{Specialty Areas~}{42pt}

    	\begin{center}
			\skills
		\end{center}

		\vspace{-12pt}

        \sidebarsection{Languages~}{80pt}	

		\sidebarsubsection{~Spoken}
		\languages

		\sidebarsubsection{~Programming}
		\programming

	\end{textblock}
}

%%%%%%%%%%% END SIDEBAR %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Header and Separator Line %%%
\newcommand{\header}[3]{%
	\begin{tikzpicture}[remember picture, overlay]%
		% First and Last Name
		\node [anchor=north west] at (0pt, 0pt) {\fontsize{30pt}{62pt}\color{header}{\headingfont#1\twentyheadingfont#2}};
		% Title
		\node [anchor=north west] at (6pt, -32pt) {\fontsize{14pt}{24pt}\color{pblue}\twentyheadingfont#3};
		% Separator
		\draw [gray, line width=6pt] (0pt, -58pt) -- (5in, -58pt);
	\end{tikzpicture}
}

%%% Quotation %%%
\newcommand*{\myquote}[2]{%
	\begin{tikzpicture}[overlay]
		% Quotation
		\node [anchor=north east] at (5in, 12pt) {\parbox{0.32\textwidth}{\textit{\color{header}\tiny{``#1''}}}};
		% Source
		\node [anchor=north east] at (5in, -12pt) {\color{header}\tiny{#2}};
	\end{tikzpicture}	
}

% MAIN SECTION style 
\renewcommand{\section}[1]{\par\vspace{\parskip}{\LARGE\twentyheadingfont\color{headercolor}\@sectioncolor #1}\par\vspace{\parskip}}

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{\tikz[baseline=(char.base)]{\node[anchor=north west, draw, rectangle, rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=#2,#2, text=white](char){#1};}}

% Color of the rounded boxes around the first three letters of section titles
\def\@sectioncolor#1#2#3{{\color{pblue}#1#2#3}}

% MAIN SUBSECTION style
\renewcommand{\subsection}[1]{\par\vspace{0.50\parskip}{\Large\twentyheadingfont\color{headercolor} #1}\par\vspace{0.25\parskip}}

%%% MODERNTIMELINE INTEGRATION %%%
\makeatletter
\newcommand*{\hintfont}{}
\newcommand*{\hintstyle}[1]{{\hintfont\textcolor{timeline-color}{#1}}}
\newcommand*{\listitemsymbol}{\labelitemi~}

% Experience ITEM Style
\newcommand*{\cventry}[7][.25em]{%
	\begin{tabular}{@{}p{\hintscolumnwidth}@{\hspace{\separatorcolumnwidth}}p{\maincolumnwidth}@{}}%
		\raggedleft\hintstyle{#2}&{\bfseries#3}\hfill{\bfseries\slshape\footnotesize\acr{#4}}%
		{\par\addfontfeature{Color=pblue}\raggedright#6}%
	\end{tabular}
	\begin{tabular}{@{}p{\hintscolumnwidth}@{\hspace{\separatorcolumnwidth}}p{\maincolumnwidth}@{}}%
		{\ifblank{#5}{}{#5}}&\parbox{0.84\textwidth}{\ifblank{#7}{}{\par\small\bfseries#7}}%
	\end{tabular}%
}

\newlength{\quotewidth}
\newlength{\hintscolumnwidth}
% Set width of timeline
\setlength{\hintscolumnwidth}{0.175\textwidth}
\newlength{\separatorcolumnwidth}
% Set width of break between timeline and text block
\setlength{\separatorcolumnwidth}{0.025\textwidth}
\newlength{\maincolumnwidth}
\newlength{\doubleitemmaincolumnwidth}
\newlength{\listitemsymbolwidth}
\settowidth{\listitemsymbolwidth}{\listitemsymbol}
\newlength{\listitemmaincolumnwidth}
\newlength{\listdoubleitemmaincolumnwidth}
% Set width of main text column
\setlength{\maincolumnwidth}{1.06\dimexpr\textwidth-\separatorcolumnwidth-\hintscolumnwidth}
\makeatother

% QR Code Generate and place
\newcommand*{\qrgen}[1]{%
	\begin{tikzpicture}[remember picture,overlay]
	\begin{pgfonlayer}{background}
		\node[anchor=south east,outer sep=0pt,inner sep=0pt] at ($(current page.south east) +(-0.25in,0.25in)$) {~\fbox{\qrcode[height=0.50in]{#1}}};
	\end{pgfonlayer}
	\end{tikzpicture}
}

%%% MISC CONFIGS %%%

% Changes bold text to gray
\renewcommand{\bfseries}{\color{black}}

% Disable headers and footers
\pagestyle{empty}

% Disable paragraph indentation
%\setlength{\parindent}{0pt}

% Adds space between sentences (after a period)
%\xspaceskip1ex

% acr command, to quickly mark acronyms for special formatting
\newcommand*\acr[1]{\textscale{.85}{#1}}

% apo command, for an apostrophe that looks good on old style nums
\newcommand{\apo}{\raisebox{-.18ex}{'}{\hspace{-.1em}}}

%% end of file `twentycharactersheet.cls'.