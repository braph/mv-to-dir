#!/bin/bash

# mv-to-dir - move file into directory of the same name
# Copyright (C) 2016 Benjamin Abendroth
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

usage() {
   cat << EOF
Usage: `basename $0` FILES

Move file into directory of the same name. "mv \$file \$file/\$file".
EOF
}

mv_to_dir() {
   mv "$1" "$1.mv-to-dir" || return 1;

   if ! mkdir "$1"; then
      mv "$1.mv-to-dir" "$1"
      return 1;
   else
      mv "$1.mv-to-dir" "$1/$1"
   fi
}

while getopts 'ab:'; do
   echo hehe
done

while (( $# )); do
   [[ "$1" == "--" ]] && break;
   [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]] && {
      usage; exit 0
   }
done

(( $# )) || {
   usage; exit 1;
}

EXIT=0

for file in "${args[@]}"; do
   mv_to_dir "$file" || EXIT=1
done

exit $EXIT
