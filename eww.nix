{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.configFile = {
    "eww/eww.scss" = {
      enable = true;
      executable = false;
      text = ''
        		.activate-linux {
        		  color: rgba(250, 250, 250, 0.5);

        		  &.background {
        		    background: none;
        		  }
        		}
        	'';
    };
    "eww/eww.yuck" = {
      enable = true;
      executable = false;
      text = ''
                (defwidget wallpaper-info []
                  (box
                    :orientation "v"
                    :halign "start"
                    :valign "start"
                    (music_widget)
                    (weather_widget)
                  )
                )

                (defwindow wallpaper-info
                  :monitor 0
                  :stacking "bg"
                  :geometry (geometry :x "0px" :y "0px" :width "250px" :anchor "center")
                  (wallpaper-info))


                (defpoll weather :interval "5m"
                  `curl wttr.in/?format=j1`
                )


                (defwidget weather_widget []
                        (box :spacing "10"
                                :space-evenly "false"
                                ;; (image :path "''${music_meta.image}")
                                ;; (box :class "day_month"(label  :text "''${time.day}, ''${time.month} ''${time.day_number}"))
                                (box :class "time" :hexpand "true" :orientation "vertical" 
                                  (label :wrap "true" :text "''${weather.nearest_area[0].areaName[0].value}")
                                  (label :wrap "true" :text "Feels like: ''${weather.current_condition[0].FeelsLikeF} Actual: ''${weather.current_condition[0].temp_F}")
                                  (label :wrap "true" :text "''${weather.current_condition[0].weatherDesc[0].value}")
                                )
                        )
                )


                (defpoll music_meta :interval "5s"
                  `playerctl metadata -p spotify --format='{"title":"{{title}}","artist":"{{artist}}","length":"{{mpris:length}}","image":"{{mpris:artUrl}}"}'`
                )

                (defwidget music_widget []
                        (box :spacing "10"
                                :space-evenly "false"

                                (box 
                                      :style "background-image: url(\"''${music_meta.image}\");"

                                      (label :text "My text here")
                                )
                                ;; (box :class "day_month"(label  :text "''${time.day}, ''${time.month} ''${time.day_number}"))
                                (box :class "time" :hexpand "true" :orientation "vertical" 
                                  (label :wrap "true" :text "''${music_meta.title}")
                                  (label :wrap "true" :text "''${music_meta.artist}")
                                )
                                (box :class "time" :orientation "vertical"
                                        (box :orientation "horizontal"
                                                (button
                                                        :onclick "playerctl play-pause -p spotify"
                                                        (label :text "''${music_playing == "Playing" ? "⏸" : "⏵"}")
                                                )
                                        )
                                (progress :value "''${
                                  ((music_position * 1000000) / music_meta.length) * 100
                                }"))
                        )
                )
                (defpoll music_playing :interval "1s"
                  `playerctl status -p spotify`
                )
                (defpoll music_position :interval "1s"
                  `playerctl position -p spotify`
                )
        		'';

    };

  };
  # home.file = {
  #   ".config/eww/eww.scss" = {
  #     text = ''
  #       '
  #     '';
  #     /*
  #       ''
  #         * {
  #         	padding: 1px;
  #         }
  #         window {
  #         	font-family: "${config.stylix.fonts.serif.name}";
  #         	background: none;
  #         	padding: 1px;
  #         }
  #         .menu {
  #         	background: none;
  #         	border: none;
  #         	padding: 25px;
  #         	border-radius: 15px;
  #         }
  #         .power-button {
  #         	color: red;
  #         }
  #         .day_month {
  #         	font-weight: 900;
  #         	font-size: 20px;
  #         	background-color: #${config.lib.stylix.colors.base00};
  #         	padding: 20px;
  #         	border-radius: 15px;
  #         }
  #         .time {
  #         	font-weight: 900;
  #         	font-size: 20px;
  #         	background-color: #${config.lib.stylix.colors.base00};
  #         	padding: 20px;
  #         	border-radius: 15px;
  #         }
  #         .buttons {
  #         	background-color: #${config.lib.stylix.colors.base00};
  #         	padding: 20px;
  #         	border-radius: 15px;
  #         }
  #       '';
  #     */
  #     # };
  #   };
  #   ".config/eww/eww.yuck" = {
  #     text = ''
  #       (defwidget activate-linux []
  #         (box
  #           :orientation "v"
  #           :halign "start"
  #           :valign "start"
  #           (label :xalign 0 :markup "<span font_size=\"large\">Activate Linux</span>")
  #           (label :xalign 0 :text "Go to Settings to activate Linux")))
  #
  #       (defwindow activate-linux
  #         :monitor 0
  #         :stacking "fg"
  #         :geometry (geometry :x "8px" :y "32px" :width "250px" :anchor "bottom right")
  #         (activate-linux))
  #     '';
  #     /*
  #       ''
  #
  #       (defvar power_icon "⏻")
  #       (defvar screenshot_icon "󰹑")
  #       (defvar close_icon "✖")
  #       (defvar revealed "false")
  #
  #       ;; (defpoll time
  #       ;; 	:interval "5s"
  #       ;; 	`date "+%A, %B %d %I:%M %p"`
  #       ;; )
  #       (defpoll time :interval "1s"
  #       	:run-while "${revealed}"
  #         `date +'{"day":"%A","month":"%B","day_number":"%d", "hour": "%I", "minute": "%M", "am_pm": "%p"}'`
  #       )
  #       (defpoll user :interval "0s"
  #       	:run-while "false"
  #         `whoami`
  #       )
  #       (defpoll music_meta :interval "5s"
  #       	:run-while "${revealed}"
  #         `playerctl metadata -p spotify --format='{"title":"{{title}}","artist":"{{artist}}","length":"{{mpris:length}}","image":"{{mpris:artUrl}}"}'`
  #       )
  #       (defpoll music_playing :interval "1s"
  #       	:run-while "${revealed}"
  #         `playerctl status -p spotify`
  #       )
  #       (defpoll music_position :interval "1s"
  #       	:run-while "${revealed}"
  #         `playerctl position -p spotify`
  #       )
  #
  #       (defwindow example
  #       	:monitor 1
  #       	:geometry (geometry
  #       		;; :x "20px"
  #       		;; :y "20px"
  #       		:width "350px"
  #       		;; :height "350px"
  #       		:anchor "top right")
  #       	:stacking "fg"
  #       	:exclusive false
  #       	;; :reserve (struts :distance "40px" :side "top")
  #       	;; :windowtype "dock"
  #       	;; :wm-ignore true
  #       	;; ""
  #       	(revealer :transition "slidedown" :reveal "${revealed}" :duration "250ms"
  #       		(menu)
  #       	)
  #       )
  #       (defwidget menu []
  #       	(box :class "menu" :orientation "vertical"
  #       		:height "350"
  #       		:width "350"
  #       		:space-evenly false
  #       		;; :spacing "10"
  #
  #       		(box
  #       			:height 5
  #       			:orientation "horizontal"
  #       			:class "buttons"
  #       			;; :space-evenly false
  #       			;; :spacing "10"
  #       			:valign "center"
  #
  #       			(power_buttons)
  #       			(label :text "${user}")
  #       			(minimize )
  #       			;; (screenshot )
  #       		)
  #
  #       		(box
  #       			:height 5
  #       			:orientation "horizontal"
  #       			(box :orientation "vertical"
  #       		:spacing "0"
  #       				:class "main-content"
  #       				:space-evenly true
  #       				(time_widget)
  #       				(music_widget)
  #       			)
  #
  #       		)
  #
  #       	)
  #       )
  #
  #       (defwidget time_widget []
  #       	(box :class "time-label" (label :wrap "true" :text "${time}"))
  #       )
  #       (defwidget power_buttons []
  #       	(button :class "power-button"
  #       		:timeout "30s"
  #       		:onclick "bash ./scripts/powermenu.sh"
  #
  #       	(label :text "${power_icon}")
  #       	)
  #       )
  #       (defwidget screenshot []
  #       	(button
  #       		:timeout "30s"
  #       		:onclick "grim -g '$(slurp -d)' - | wl-copy"
  #
  #       	(label :text "${screenshot_icon}")
  #       	)
  #       )
  #       (defwidget minimize []
  #       	(button :valign "end"
  #       		:onclick "bash ${./}"
  #
  #       		(label :text "${close_icon}")
  #       	)
  #       )
  #       (defwidget time_widget []
  #       	(box
  #       		:spacing "10"
  #       		:space-evenly "false"
  #       			:valign "center"
  #
  #       		(box :class "day_month"
  #       			:hexpand "true"
  #       			(label  :text "${time.day}, ${time.month} ${time.day_number}"))
  #       		(box :class "time"
  #
  #       			:valign "end"
  #       			(label  :text "${time.hour}:${time.minute} ${time.am_pm}"))
  #       	)
  #       )
  #       (defwidget music_widget []
  #       	(box :spacing "10"
  #       		:space-evenly "false"
  #       		;; (image :path "${music_meta.image}")
  #       		;; (box :class "day_month"(label  :text "${time.day}, ${time.month} ${time.day_number}"))
  #       		(box :class "time" :hexpand "true" (label :wrap "true" :text "${music_meta.title}"))
  #       		(box :class "time" :orientation "vertical"
  #       			(box :orientation "horizontal"
  #       				(button
  #       					:onclick "playerctl play-pause -p spotify"
  #       					(label :text "${music_playing == "Playing" ? "⏸" : "⏵"}")
  #       				)
  #       			)
  #       		(progress :value "${((music_position * 1000000) / music_meta.length) * 100}"))
  #       	)
  #       )
  #
  #               '';
  #     */
  #     # };
  #   };
  # };
}
