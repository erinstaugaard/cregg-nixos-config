SELECTION=$(echo -e "Power off\nRestart\nCancel"| fuzzel -d)
if [ "$SELECTION" == "Power off" ]; then 
	poweroff
fi
if [ "$SELECTION" == "Restart" ]; then 
	reboot
fi
