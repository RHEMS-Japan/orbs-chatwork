# shellcheck disable=SC2155
echo -e "${BODY}"
# _body=$(eval echo -e "${BODY}")
# echo "$_body"
echo -e "---"

RESULT=$(curl -s -o /dev/null -w '%{http_code}\n' -X POST -H "X-ChatWorkToken: ${CHATWORK_TOKEN}" \
    -d "body=${_body}&self_unread=${IS_UNREAD}" "https://api.chatwork.com/${VER}/rooms/${ROOMID}/messages")

echo "http_code=${RESULT}"
[ "200" = "${RESULT}" ] || exit 1