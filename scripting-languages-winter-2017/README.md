# Scripting Languages (Winter 2017)
![OS](https://img.shields.io/badge/macOS-v10.13-orange.svg)
![bash](https://img.shields.io/badge/bash-v4.4-green.svg)
![tcsh](https://img.shields.io/badge/tcsh-v6.18.01-blue.svg)
![perl](https://img.shields.io/badge/perl-v5.18.2-red.svg)

## About

This folder contains my solutions to assignments for Scripting Languages course. Each of the assignments needs more the one solution (for example in `bash` and `tcsh`). I will do my best and try to follow the best practices while writing those scripts, but don't take my word for it...

IMPORTANT: Before you consider writing your script in c shell - if reading my scripts in tcsh wasn't enough you might want to take a look at those:
- [CSH PROGRAMMING CONSIDERED HARMFUL](http://www.faqs.org/faqs/unix-faq/shell/csh-whynot/)
- [Top Ten Reasons not to use the C shell](http://www.grymoire.com/unix/CshTop10.txt)

## Tasks

#### Shell (bash and tcsh)

- [x] 1. Print current user [`bash`](shell/whoami-bash.sh) [`tcsh`](shell/whoami-tcsh.sh)
- [x] 2a. Multiplication table [`bash`](shell/multiplication-table-bash.sh) [`tcsh`](shell/multiplication-table-tcsh.sh)
- [x] 2b. Multiplication table with given range [`bash`](shell/multiplication-table-in-range-bash.sh) [`tcsh`](shell/multiplication-table-in-range-tcsh.sh)
- [x] 2c. Any calculation table with given range [`bash`](shell/calculation-table-in-range-bash.sh) [`tcsh`](shell/calculation-table-in-range-tcsh.sh)
- [x] 3. Ping IP's in range [`bash`](shell/ping-in-range-bash.sh) [`tcsh`](shell/ping-in-range-tcsh.sh)
- [ ] 4. Describe active IP `bash` `tcsh`
- [ ] 5. Counting server + client `bash` `tcsh`

#### Perl

- [x] 1-4. Print file with options [`perl`](perl/print-file.pl)
- [x] 5. Print file with words range [`perl`](perl/print-file-words-range.pl)
- [x] 6. Print file with words pair [`perl`](perl/print-file-words-pair.pl)
- [x] 7. Print file with words range with custom split [`perl`](perl/print-file-words-range-split.pl)
- [x] 8. Print file with words pair with custom split [`perl`](perl/print-file-words-pair-split.pl)
- [ ] 9. Word count `perl`

## Usage

#### bash / tcsh

Make sure the one of these shells is installed and shebang included in the script file matches your shell location on your system, then from command line run:

```
$ ./script.sh
```

#### perl

Again, make sure your perl installation matches the header in script file. Then simply run the following:

```
$ perl script.pl
```
