#!/usr/bin/env tcsh
# Witold Bobrowski ; Group 2
#
# Print classic multiplication table

echo "* __1__2__3__4__5__6__7__8__9"
foreach a (`seq 1 9`)
  set buffer = $a"|"
  foreach b (`seq 1 9`)
	@ result = ( $a * $b )
	if ($result < 10) then
		set buffer = "$buffer  $result"
	else
		set buffer = "$buffer $result"
	endif
  end
  echo "$buffer"
end
