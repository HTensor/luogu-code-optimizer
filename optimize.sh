#!/bin/bash

main(){
	local bs="`dirname "$0"`"
	[ -f "$1" ] || exit
	local of="$2"
	if(($#==1)); then of="$1"; fi
	touch "$of"
	if(($?!=0)); then exit; fi
	local n="$1"
	local n1=${n%.cpp}
	local flg=0
	if [ a"$n" != a"$n1" ]; then
		if [ ! -f "$n1" ]; then flg=1; fi
		g++ "$n" -o "$n1" -Ofast -march=native
		if(($?!=0)); then exit; fi
		strip "$n1"
		n="$n1"
	fi
	if [ ! -f "$bs""/converter" ]; then
		g++ "$bs""/converter.cpp" -o "$bs""/converter" -O2
		if(($?!=0)); then exit; fi
	fi
	"$bs""/converter" "$n" "$of"
	if((flg==1)); then rm "$n"; fi
}

main $@
