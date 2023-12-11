# Check if there are enough arguments
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <cwd> <tab_title>"
  exit 1
fi

TAB_TITLE=$1
DIRECTORY=$2

LINE_EXISTING=$(kitty @ ls | jq '.[].tabs[].title' | grep -c $TAB_TITLE)

echo $LINE_EXISTING

if [ $LINE_EXISTING -eq 0 ]; then
  echo "here"
  kitty @ launch --type='tab' --tab-title=$TAB_TITLE --cwd=$DIRECTORY --no-response
  kitty @ launch --type='window' --match=title:^$TAB_TITLE --cwd=$DIRECTORY --no-response lazygit
fi

kitty @ focus-tab --match=title:^$TAB_TITLE --no-response
