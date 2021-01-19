#!/bin/sh
#
# ufetch-raspbian - tiny system info for raspbian

## INFO

# user is already defined
host="$(hostname)"
os='Raspbian'
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(dpkg -l | wc -l)"
shell="$(basename ${SHELL})"

if [ -z "${WM}" ]; then
	if [ "${XDG_CURRENT_DESKTOP}" ]; then
		envtype='DE'
		WM="${XDG_CURRENT_DESKTOP}"
	elif [ "${DESKTOP_SESSION}" ]; then
		envtype='DE'
		WM="${DESKTOP_SESSION}"
	else
		envtype='WM'
		WM="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	fi
else
	envtype='WM'
fi

## DEFINE COLORS

# probably don't change these
bold="$(tput bold)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
reset="$(tput sgr0)"

# you can change these
lc="${reset}${bold}${red}"		# labels
nc="${reset}${bold}${red}"		# user and hostname
ic="${reset}${bold}${white}"		# info
c0="${reset}${bold}${green}"		# first color
c1="${reset}${bold}${red}"		# second color

## OUTPUT

cat <<EOF
${c0}    __  __    ${lc}${USER}${ic}@${lc}${host}${reset}
${c0}   (_\\)(/_)   ${lc}OS:        ${ic}${os}${reset}
${c1}   (_(__)_)   ${lc}KERNEL:    ${ic}${kernel}${reset}
${c1}  (_(_)(_)_)  ${lc}UPTIME:    ${ic}${uptime}${reset}
${c1}   (_(__)_)   ${lc}PACKAGES:  ${ic}${packages}${reset}
${c1}     (__)     ${lc}SHELL:     ${ic}${shell}${reset}
${c1}              ${lc}${envtype}:        ${ic}${WM}${reset}
EOF
