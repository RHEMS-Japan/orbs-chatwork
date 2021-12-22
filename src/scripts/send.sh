curl -X POST -H "X-ChatWorkToken: ${CHATWORK_TOKEN}" \
    -d "body=${BODY}&self_unread=${IS_UNREAD}" "https://api.chatwork.com/v2/rooms/${ROOMID}/messages"