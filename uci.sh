#!/bin/bash
#
# Two routines for loading UCI config elements --@robzr

uciSection='example.@[0]'

# uciLoadVar takes two arguments, only works on a uci option (no lists),
# and sets the variable to the option if available, else the default value 
# The variable is assumed to have the same name as the uci option.
#
# Args: $1 = variable/option name $2 = default value
uciLoadVar () {
  local getUci
  getUci=`uci -q get ${uciSection}."$1"` || getUci="$2"
  eval $1=\'$getUci\';
}

# uciLoad takes multiple arguments, first is the uci option/list name,
# followed by default value(s).  Returns to stdout, one list element per line.
#
# Optionally takes a -d X delimiter arg
#
# ARGs: $1 = option/list name $2+ = default values
uciLoad() {
  local delim="
"
  [ "$1" = -d ] && { delim="$2"; shift; shift; }
  uci -q -d"$delim" get "$uciSection.$1" 2>/dev/null || while [ -n "$2" ]; do echo $2; shift; done
}

# Example usage:
cat > /etc/config/example <<_EOF_
config example
  option firstOption 'value'
  list   firstList   'value1'
  list   firstList   'value2'
  list   firstList   'value3'
_EOF_ 


# Set variable with a defined option
var1=""
uciLoadVar var1 "default value"

# Set variable with a default value
var2=""
uciLoadVar var2 "default value"

# Retrieve defined list elements
uciLoad firstList "one" "two" "three" | while read line ; do
  echo Read 1: $line
done

# Retrieve default list elements
uciLoad undefList "one" "two" "three" | while read line ; do
  echo Read 2: $line
done

rm -f /etc/config/example

