#!/bin/bash
# digest.sh <file> [file2 ...] — structure of a code file at ~5% of full-read cost.
# Prints line count + numbered signatures (defs/classes/exports/sections).
for f in "$@"; do
  [ -f "$f" ] || { echo "!! not a file: $f"; continue; }
  echo "== $f ($(wc -l < "$f" | tr -d ' ') lines) =="
  grep -nE '^\s*(def |class |function |async (def|function) |const [A-Za-z_]+ *= *(\(|async)|export |func |fn |pub fn |public |private |protected |interface |type [A-Z]|struct |enum |impl |#{1,3} )' "$f" | head -80
done
