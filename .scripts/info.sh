#!/bin/sh
#
# ufetch-arch - tiny system info for arch

## INFO

# user is already defined
host="$(hostname)"
os='arch linux'
kernel="$(uname -r)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(pacman -Q | wc -l)"
shell="$(basename ${SHELL})"

if [ -z "${WM}" ]; then
	if [ "${XDG_CURRENT_DESKTOP}" ]; then
		envtype='de'
		WM="${XDG_CURRENT_DESKTOP}"
	elif [ "${DESKTOP_SESSION}" ]; then
		envtype='de'
		WM="${DESKTOP_SESSION}"
	else
		envtype='wm'
		WM="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	fi
else
	envtype='wm'
fi

## DEFINE COLORS

# probably don't change these
bold="$(tput bold)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
red2="$(tput setaf 9)"
green="$(tput setaf 2)"
green2="$(tput setaf 10)"
yellow="$(tput setaf 3)"
yellow2="$(tput setaf 11)"
blue="$(tput setaf 4)"
blue2="$(tput setaf 12)"
magenta="$(tput setaf 5)"
magenta2="$(tput setaf 13)"
cyan="$(tput setaf 6)"
cyan2="$(tput setaf 14)"
white="$(tput setaf 7)"
white2="$(tput setaf 15)"
reset="$(tput sgr0)"
# you can change these
lc="${reset}${magenta}"		# labels
nc="${reset}${cyan}"		# user and hostname
ic="${reset}${white}"	# info
c0="${reset}${blue2}"		# first color
c1="${reset}${blue}"			# second color

## OUTPUT

cat <<EOF

${lc}       os: ${ic}${os}${reset}
${lc}     kern: ${ic}${kernel}${reset}
${lc} packages: ${ic}${packages}${reset}
${lc}    shell: ${ic}${shell}${reset}
${lc}       ${envtype}: ${ic}${WM}${reset}

${reset} ${red}▪${reset}${red2}▪${reset} ${green}▪${reset}${green2}▪${reset} ${blue}▪${reset}${blue2}▪${reset} ${yellow}▪${reset}${yellow2}▪${reset} ${cyan}▪${reset}${cyan2}▪${reset} ${magenta}▪${reset}${magenta2}▪${reset} ${white}▪${reset}${white2}▪${reset}
EOF
