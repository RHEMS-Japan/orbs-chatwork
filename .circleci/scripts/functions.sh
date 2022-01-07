function create_message() {
# images
SUCCESS="871810507"
ERROR="871810825"
ON_HOLD="871810928"

#body
MESSAGE=`cat <<EOF
Project : orbs-chatwork
Repo : alpha
Time : $(date "+%Y/%m/%d %H:%M:%S")
https://circleci.com/workflow-run/${CIRCLE_WORKFLOW_ID}
EOF
`
BODY="[preview id=${SUCCESS} ht=60][hr]${MESSAGE}"

echo "export MESSAGE='${BODY}'" >> $BASH_ENV
echo "${MESSAGE}"
}
