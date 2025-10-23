response=$((echo "Power Off" && echo "Cancel") | fuzzel -dmenu)

if [[ $response == "Power Off" ]]; then
	poweroff
fi
