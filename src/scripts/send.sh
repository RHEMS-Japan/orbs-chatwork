echo "$BODY"
echo -e "---"
export C_BODY=$(eval echo "\$BODY")

RESULT=$(curl -s -o /dev/null -w '%{http_code}\n' -X POST -H "X-ChatWorkToken: ${CHATWORK_TOKEN}" \
    -d "body=${C_BODY}&self_unread=${IS_UNREAD}" "https://api.chatwork.com/${VER}/rooms/${ROOMID}/messages")

echo "http_code=${RESULT}"
[ "200" = "${RESULT}" ] || exit 1