#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Print current user name

set wrong_argument = ""
set error = 0
set program_should_exit = "false"

foreach argument ($argv)
  switch ($argument)
    case "-h":
    case "--help":
      goto HELP
      breaksw
    case "-q":
    case "--quiet":
      set program_should_exit = "true"
      breaksw
    case -*:
      set wrong_argument = $argument
      goto ERROR
      breaksw
    defaut:
      breaksw
  endsw
end

if ($program_should_exit != "true") then
  goto USER
else
  goto QUIET
fi

USER:
  whoami

QUIET:
  exit $error

HELP:
  echo "whoami.tcsh -- print current user"
  echo
	echo "Usage: ./whoami.tcsh [--help] [-h] [--quiet] [-q]"
	echo
	echo "Options:"
	echo "	-h | --help 	Show help"
	echo "	-q | --quiet 	exit"
  goto QUIET

ERROR:
	set error = 1
	if ("$wrong_argument" != "") then
		echo "[\!] Unknown command: $wrong_argument"
		echo
		goto HELP
	fi
