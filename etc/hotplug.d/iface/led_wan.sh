#!/bin/sh

[ "$INTERFACE" = "wan" ] || exit 0

. /lib/functions/leds.sh

led_get_attr() {
	cat /sys/class/leds/$1/$2 2>/dev/null
}
led_get_trigger() {
	led_get_attr $1 "trigger" | sed 's/.*\[\([^]]*\).*/\1/g'
}

led_r=bthomehubv5a:red:broadband
led_g=bthomehubv5a:green:broadband
led_b=bthomehubv5a:blue:broadband

case "$ACTION" in
ifup)
	. /lib/functions.sh

	config_load system

	led_off $led_r
	led_off $led_g

	if [ "$(config_get led_dsl trigger)" = "netdev" ]; then
		if [ "$(get_led_trigger $led_b)" != "netdev" ]; then
			led_set_attr $led_b "trigger" "netdev"
			led_set_attr $led_b "device_name" "$(config_get led_dsl dev)"
			for m in $(config_get led_dsl mode); do
				led_set_attr $led_b "$m" "1"
			done
		fi
	else
		led_on $led_b
	fi
;;
ifdown)
	led_off $led_g
	led_off $led_b

	[ "$(get_led_trigger $led_r)" = "timer" ] || led_timer $led_r 1000 2000 # flashing red LED
	# or
	#led_on $led_r # static red LED
	# or
	#led_off $led_r # no red LED
;;
esac
