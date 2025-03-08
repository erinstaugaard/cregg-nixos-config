STATE="$(eww get revealed)"
if [ "$STATE" == "false" ]; then
	eww update revealed="true"
fi
if [ "$STATE" == "true" ]; then
	eww update revealed="false"
fi
if [ "$STATE" == "" ]; then
	eww open example
	eww update revealed="true"
fi

