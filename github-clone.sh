#!/bin/bash

if [ "$2" = "" ]; then
	echo "usage: $0 <github-user> <repository-name> [local-directory]"
	exit 1
elif ! [[ $1 =~ ^[a-zA-Z0-9.-]+$ ]]; then
	echo "error: parameter $1 not conforming Github user name format"
	exit 1
elif ! [[ $2 =~ ^[a-zA-Z0-9.-]+$ ]]; then
	echo "error: parameter $2 not conforming Github repository name format"
	exit 1
elif [ ! -f ~/.ssh/id_github_$2 ]; then
	echo "error: no ssh key present for Github repository $1/$2"
	exit 1
fi

dir=`dirname $0`
if [ "$dir" = "." ]; then dir=`pwd`; fi
if [ "$dir" = ".." ]; then
	echo "run this script from its directory"
	exit 1
fi

user=$1
repo=$2
shift
shift

full="git@github.com:$user/$repo.git"
GIT_SSH=$dir/github-helper.sh GIT_KEY=~/.ssh/id_github_$repo git clone $full $@
