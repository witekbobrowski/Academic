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

- [x] 1. Print current user [`bash`](shell/whoami.bash) [`tcsh`](shell/whoami.tcsh)
- [x] 2a. Multiplication table [`bash`](shell/multiplication-table.bash) [`tcsh`](shell/multiplication-table.tcsh)
- [x] 2b. Multiplication table with given range [`bash`](shell/multiplication-table-in-range.bash) [`tcsh`](shell/multiplication-table-in-range.tcsh)
- [x] 2c. Any calculation table with given range [`bash`](shell/calculation-table-in-range.bash) [`tcsh`](shell/calculation-table-in-range.tcsh)
- [ ] 3. Ping IP's in range [`bash`](shell/ping-in-range.bash) `tcsh`
- [ ] 4. Describe active IP `bash` `tcsh`
- [ ] 5. Counting server + client `bash` `tcsh`

#### Perl

- [ ] 1. Print file [`perl`](shell/print-file.pl)
- [ ] 2. Print file without comments `perl`
- [ ] 3. Print file with numbered lines `perl`
- [ ] 4. Print file with numbered lines (separated) `perl`
- [ ] 5. Print words in given range `perl`
- [ ] 6. Print words in given range (numbers) `perl`
- [ ] 7. Print words in given range with separator `perl`
- [ ] 8. Print words in given range (numbers) with separator `perl`

## Usage

#### bash / tcsh

Make sure the one of these shells is installed and shebang included in the script file matches your shell location on your system, then from command line run:

```
$ ./script.sh
```

#### perl

```
$ perl script.pl
```
