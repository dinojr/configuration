#!/bin/bash

# Copyright 2013, Raphael Reitzig
#
# pdfsplitk is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# pdfsplitk is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with pdfsplitk. If not, see <http://www.gnu.org/licenses/>.

# Splits PDFs into constant-sized chunks.
# Requires `pdftk`, `pdfinfo`, `awk` and `acroread` if PS output is desired.
#
# Call with four parameters:
#  * First is the input file (`*.pdf`).
#  * Second it the number of pages per chunk.
#  * Third is the target directory.
#  * Fourth is `ps` if you want PS instead of PDF output (optional).

if [ ${#} -lt 3 ];
then
  echo "Usage: pdfsplitk <file.pdf> <pages per chunk> <target dir> [ps]";
  exit;
fi

declare -i pagesper number count counter start end;

tmp="/tmp/pdfsplitk";
file=$1;
filename=${file%.pdf};
pagesper=$2;
target=$3;
mode=$4;

if [[ ! -d "${target}" ]]; then 
  mkdir "${target}";
fi

if [[ -d "${target}" ]]; then
  mkdir ${tmp};
  cp $file ${tmp}/;
  
  # number=`pdfinfo "${tmp}/${file}" 2>&1 | grep Pages | awk ' /\ddd+/; { print $2 }'`;
  # count=$((number / pagesper));

  number=$(pdfinfo -- "$file" 2> /dev/null | awk '$1 == "Pages:" {print $2}')
  count=$((($number+$pagesper-1)/$pagesper))

  echo "[pdfsplitk] Creating ${count} documents with ${pagesper} pages max each in ${target}.";
  echo "";

  counter=0;
  while [[ $count -gt $counter ]]; do 
    echo -e "\033M[$((100*counter/count))%]";
    start=$((counter*pagesper + 1));
    end=$((start + pagesper - 1));
    if [ $end -gt $number ]; then
    end=$number
    fi
    
    counterstring=`printf '%04d' ${counter}`;
    if [[ ${mode} == "ps" ]]; then      
	acroread -toPostScript -size a4 -start ${start} -end ${end} -pairs "${tmp}/${file}" "${target}/${filename}_${counterstring}.ps";
    else
	pdftk "${tmp}/${file}" cat ${start}-${end} output "${target}/${filename}_${counterstring}.pdf";
    fi
    counter=$((counter + 1));
  done
  echo -e "\033M[Done]";
  
  rm -rf ${tmp};
fi
