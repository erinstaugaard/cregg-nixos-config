
{ config, pkgs, ... }:
{
  home.file = {
    ".config/eww/eww.css" = {
        text = ''
* {
	padding: 1px;
}
window {
	font-family: "${config.stylix.fonts.serif.name}";
	background: none;
	/* opacity: 0; */
	/* transform: scale(1.5); */
	/* cursor: 'pointer'; */
	padding: 1px;
}
.menu {
	/* background: rgba(0, 0, 0, 0.2); */
	background: none;
	border: none;
	padding: 25px;
	border-radius: 15px;
}
.power-button {
	color: red;
	/* width: 0px; */
	/* background: none; */
}
.day_month {
	font-weight: 900;
	font-size: 20px;
	background-color: #${config.lib.stylix.colors.base01};
	box-shadow: 0px 7px 11px 1px #${config.lib.stylix.colors.base00};
	/*filter: drop-shadow(0px 6px 10px #241f31);*/
	padding: 20px;
	border-radius: 15px;
}
.time {
	font-weight: 900;
	font-size: 20px;
	background-color: #${config.lib.stylix.colors.base01};
	box-shadow: 0px 7px 11px 1px #${config.lib.stylix.colors.base00};
	padding: 20px;
	border-radius: 15px;
}
.buttons {
	background-color: #${config.lib.stylix.colors.base01};
	box-shadow: 0px 7px 11px 1px #${config.lib.stylix.colors.base00};
	padding: 20px;
	border-radius: 15px;
}
.pause-button {
	background-color: #${config.lib.stylix.colors.base02};
}
.play-button {
	background-color: #${config.lib.stylix.colors.base00};
}
        '';
    /* }; */
  };
    ".config/eww/eww.yuck" = {
        text = ''

(defvar power_icon "⏻")
(defvar screenshot_icon "󰹑")
(defvar close_icon "✖")
(defvar revealed "false")

;; (defpoll time 
;; 	:interval "5s"
;; 	`date "+%A, %B %d %I:%M %p"`
;; )
(defpoll time :interval "1s"
	:run-while "''${revealed}"
  `date +'{"day":"%A","month":"%B","day_number":"%d", "hour": "%I", "minute": "%M", "am_pm": "%p"}'`
)
(defpoll user :interval "0s"
	:run-while "false"
  `whoami`
)
(defpoll music_meta :interval "5s"
	:run-while "''${revealed}"
  `playerctl metadata -p spotify --format='{"title":"{{title}}","artist":"{{artist}}","length":"{{mpris:length}}","image":"{{mpris:artUrl}}"}'`
)
(defpoll music_playing :interval "1s"
	:run-while "''${revealed}"
  `playerctl status -p spotify`
)
(defpoll music_position :interval "1s"
	:run-while "''${revealed}"
  `playerctl position -p spotify`
)

(defwindow example
	:monitor 1
	:geometry (geometry 
		;; :x "20px"
		;; :y "20px"
		:width "350px"
		;; :height "350px"
		:anchor "top right")
	:stacking "fg"
	:exclusive false
	;; :reserve (struts :distance "40px" :side "top")
	;; :windowtype "dock"
	;; :wm-ignore true
	;; ""
	(revealer :transition "slidedown" :reveal "''${revealed}" :duration "250ms" 
		(menu)
	)
)
(defwidget menu [] 
	(box :class "menu" :orientation "vertical"
		:height "350"
		:width "350"
		:space-evenly false
		;; :spacing "10"


		(box 
			:height 5
			:orientation "horizontal" 
			:class "buttons"
			;; :space-evenly false
			;; :spacing "10"
			:valign "center"
			
			(power_buttons)
			(label :text "''${user}")
			(minimize )
			;; (screenshot )
		)
		
		(box 
			:height 5
			:orientation "horizontal" 
			(box :orientation "vertical"
		:spacing "0"
				:class "main-content"
				:space-evenly true
				(time_widget)
				(music_widget)
			)

		)

	)
)

(defwidget time_widget []
	(box :class "time-label" (label :wrap "true" :text "''${time}"))
)
(defwidget power_buttons []
	(button :class "power-button"
		:timeout "30s"
		:onclick "bash ${./powermenu.sh}"

	(label :text "''${power_icon}")
	)
)
(defwidget screenshot []
	(button 
		:timeout "30s"
		:onclick "grim -g '$(slurp -d)' - | wl-copy"

	(label :text "''${screenshot_icon}")
	)
)
(defwidget minimize []
	(button :valign "end"
		:onclick "bash ${./toggle.sh}"

		(label :text "''${close_icon}")
	)
)
(defwidget time_widget []
	(box 
		:spacing "10"
		:space-evenly "false"
			:valign "center"
			
		(box :class "day_month"
			:hexpand "true"
			(label  :text "''${time.day}, ''${time.month} ''${time.day_number}"))
		(box :class "time"
			
			:valign "end"
			(label  :text "''${time.hour}:''${time.minute} ''${time.am_pm}"))
	)
)
(defwidget music_widget []
	(box :spacing "10"
		:space-evenly "false"
		;; (image :path "''${music_meta.image}")
		;; (box :class "day_month"(label  :text "''${time.day}, ''${time.month} ''${time.day_number}"))
		(box :class "time" :hexpand "true" (label :wrap "true" :text "''${music_meta.title}"))
		(box :class "time" :orientation "vertical" 
			(box :orientation "horizontal" 
				(button :class "''${music_playing == "Playing" ? "pause-button" : "play-button"}" 
					:onclick "playerctl play-pause -p spotify"
					(label :text "''${music_playing == "Playing" ? "⏸" : "⏵"}")
				)
			) 
		(progress :value "''${((music_position * 1000000) / music_meta.length) * 100}"))
	)
)


        '';
    /* }; */
  };
};}
