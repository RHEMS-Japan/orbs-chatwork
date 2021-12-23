RESULT=`curl -s -o /dev/null -w '%{http_code}\n' -X POST -H "X-ChatWorkToken: ${CHATWORK_TOKEN}" \
    -d "body=${BODY}&self_unread=1" "https://api.chatwork.com/${VER}/rooms/${ROOMID}/messages"`

echo [ 200 = $RESULT ] || exit 1