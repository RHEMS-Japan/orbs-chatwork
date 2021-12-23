TOKEN=$(eval echo "${TOKEN}")
echo "${TOKEN}"
echo "${BODY}"
echo "${IS_UNREAD}"


curl -X POST -H "X-ChatWorkToken: ${TOKEN}" \
    -d "body=${BODY}&self_unread=${IS_UNREAD}" "https://api.chatwork.com/${VER}/rooms/${ROOMID}/messages"