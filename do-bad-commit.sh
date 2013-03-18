# Same as do-commit.sh, but the b.js content is invalid on purpose.
NOW=$(date +"%s")
echo "var a="$NOW";" > a.js
echo "var" > b.js
git add a.js b.js
git commit -m "commit @ $NOW"