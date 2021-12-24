function create_message() {
# images
SUCCESS="866484042"
ERROR="866484114"

#body
MESSAGE=`cat <<EOF
Project : orbs-chatwork
Repo : alpha
Time : "$(date "+%Y/%m/%d %H:%M:%S")"
EOF
`
BODY="[preview id=${SUCCESS} ht=60][hr]${MESSAGE}"

echo "${BODY}"
echo "export BODY=${BODY}" >> $BASH_ENV
}
