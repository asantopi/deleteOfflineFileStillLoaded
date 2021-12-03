#!/bin/bash
# 2021-12-03 - v1.1.0
# @author P4F

ProgressBar() {
	# Process data
	let _progress=(${1} * 100 / ${2} * 100)/100
	let _done=(${_progress} * 4)/10
	let _left=40-$_done
	# Build progressbar string lengths
	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")

	# 1.2 Build progressbar strings and print the ProgressBar line
	# 1.2.1 Output example:
	# 1.2.1.1 Progress : [########################################] 100%
	printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"
}
