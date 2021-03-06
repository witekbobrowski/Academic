# Scripting Languages (Winter 2017)
![OS](https://img.shields.io/badge/macOS-v10.13-orange.svg)
![bash](https://img.shields.io/badge/bash-v4.4-green.svg)
![tcsh](https://img.shields.io/badge/tcsh-v6.18.01-blue.svg)
![perl](https://img.shields.io/badge/perl-v5.18.2-red.svg)
![python](https://img.shields.io/badge/python-v3.6.3-blue.svg)

## About

This folder contains my solutions to assignments for Scripting Languages course. Im an amateur - first timer user - with these languages but I will do my best and try to follow the best practices while writing those scripts, but don't take my word for it...

IMPORTANT: Before you consider writing your script in c shell - if reading my scripts in tcsh wasn't enough you might want to take a look at those:
- [CSH PROGRAMMING CONSIDERED HARMFUL](http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/)
- [Top Ten Reasons not to use the C shell](http://www.grymoire.com/unix/CshTop10.txt)

## Assignments

#### Shell (bash / tcsh)

- [x] 1. Print current user [`bash`](shell/whoami.bash) [`tcsh`](shell/whoami.tcsh)
- [x] 2a. Multiplication table [`bash`](shell/multiplication-table.bash) [`tcsh`](shell/multiplication-table.tcsh)
- [x] 2b. Multiplication table with given range [`bash`](shell/multiplication-table-in-range.bash) [`tcsh`](shell/multiplication-table-in-range.tcsh)
- [x] 2c. Any calculation table with given range [`bash`](shell/calculation-table-in-range.bash) [`tcsh`](shell/calculation-table-in-range.tcsh)
- [x] 3. Ping IP's in range [`bash`](shell/ping.bash) [`tcsh`](shell/ping.tcsh)
- [x] 4. Describe active IP [`bash`](shell/ping-and-describe.bash) [`tcsh`](shell/ping-and-describe.tcsh)
- [x] 5. Counting server + client [`bash`](shell/counting-server.bash) [`tcsh`](shell/counting-server.tcsh)

#### Perl

- [x] 1-4. Print file with options [`perl`](perl/print-file.pl)
- [x] 5. Print file with words range [`perl`](perl/print-file-words-range.pl)
- [x] 6. Print file with words pair [`perl`](perl/print-file-words-pair.pl)
- [x] 7. Print file with words range with custom split [`perl`](perl/print-file-words-range-split.pl)
- [x] 8. Print file with words pair with custom split [`perl`](perl/print-file-words-pair-split.pl)
- [x] 9. Word count [`perl`](perl/word-count.pl)
- [x] 10. Registry [`perl`](perl/registry.pl)

+ Utils [`module`](perl/Utils.pm)

#### Python

- [x] 1. Multiplication table [`python`](python/mul-tab.py)
- [x] 2. Quadratic equation [`python`](python/quad-eq.py)
- [x] 3-4. Quadratic equation with arguments [`python`](python/quad-eq-args.py)
- [x] 5. Concatenate [`python`](python/cat.py)
- [x] 6. Word count [`python`](python/word-count.py)
- [x] 7. Finder [`python`](python/finder.py)
- [x] 8. Registry [`python`](python/registry.py)

+ utils [`module`](python/utils.py)

#### Final project

Python project - [humblecritic](https://github.com/witekbobrowski/humblecritic)
> 💯 Get score for HumbleBundle bundle

+ Humblecritic plot [`perl`](perl/humblecritic-plot.pl)
> Script that takes json exported from humblecritic to plot data

## Usage

#### Shell (bash / tcsh)

Make sure the one of these shells is installed and shebang included in the script file matches your shell location on your system, then from command line run:

```
$ ./script.sh
```

#### Perl

Again, make sure your perl installation matches the header in script file. Then simply run the following:

```
$ perl script.pl
```

#### Python

... and again. Make sure shebang matches python installation and if it actually is python 3:

```
$ python3 script.py
```

#### General

Most of the scripts expect some input and options so try to pass `-h` or `--help` to find out how to use them.

```
$ ./whoami.tcsh --help

whoami.tcsh -- print current user

Usage: ./whoami.tcsh [--help] [-h] [--quiet] [-q]

Options:
	-h | --help 	Show help
	-q | --quiet 	exit
```
