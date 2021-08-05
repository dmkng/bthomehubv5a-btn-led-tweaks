#!/bin/sh

[ "$DSL_NOTIFICATION_TYPE" = "DSL_INTERFACE_STATUS" ] || exit 0

. /lib/functions/leds.sh

led_get_attr() {
	cat /sys/class/leds/$1/$2 2>/dev/null
}
led_get_trigger() {
	led_get_attr $1 "trigger" | sed 's/.*\[\([^]]*\).*/\1/g'
}
led_get_delay() {
	local delay=$(led_get_attr $1 "delay_on")
	[ "$delay" = "$(led_get_attr $1 "delay_off")" ] && echo $delay
}

led_r=bthomehubv5a:red:broadband
led_g=bthomehubv5a:green:broadband
led_b=bthomehubv5a:blue:broadband

case "$DSL_INTERFACE_STATUS" in
DOWN)
	led_off $led_r
	led_off $led_g
	led_off $led_b
;;
READY)
	led_off $led_g
	led_off $led_b

	[ "$(get_led_trigger $led_r)" = "timer" ] || led_timer $led_r 1000 2000 # flashing red LED
	# or
	#led_on $led_r # static red LED
	# or
	#led_off $led_r # no red LED
;;
HANDSHAKE)
	led_off $led_r
	led_off $led_b

	[ "$(led_get_trigger $led_g)" = "timer" -a "$(led_get_delay $led_g)" = "1000" ] || led_timer $led_g 1000 1000
;;
TRAINING)
	led_off $led_r
	led_off $led_b

	[ "$(led_get_trigger $led_g)" = "timer" -a "$(led_get_delay $led_g)" = "500" ] || led_timer $led_g 500 500
;;
UP)
	led_off $led_r
	led_off $led_b

	[ "$(led_get_trigger $led_g)" = "timer" -a "$(led_get_delay $led_g)" = "250" ] || led_timer $led_g 250 250
;;
esac
