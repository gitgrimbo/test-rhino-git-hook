# Writes the current number of milliseconds to a.js and b.js
# This ensures git detects that the files contents have changed
NOW=$(date +"%s")
echo "var a="$NOW";" > a.js
echo "var b="$NOW";" > b.js
git add a.js b.js
git commit -m "commit @ $NOW"