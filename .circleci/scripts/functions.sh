function create_message() {
# images
ALERT_FIRING="864720511"
ALERT_RESOLVED="864720669"
WARNING="864724297"

#body
MESSAGE=$(cat <<EOF
Project : orbs-chatwork
Repo : alpha
Time : 2021-12-22 18:00:00
EOF
)

TITLE="Orb作成中"
SUB_TITLE="試験投稿です"
echo "export BODY="[info][title]${TITLE}[/title]${SUB_TITLE}[preview id=${ALERT_RESOLVED} ht=60][hr]${MESSAGE}[/info]" >> $BASH_ENV
}
