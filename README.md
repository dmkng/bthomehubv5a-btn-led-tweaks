# BT Home Hub 5 Type A (OpenWrt) Buttons and LEDs tweaks

This repository contains scripts that tweak buttons and LEDs functionality on BT Home Hub 5 Type A with OpenWrt installed.
These scripts work best with a specific configuration of the LEDs, you can apply this configuration by merging contents of the `system.led` file from this repository with the `/etc/config/system` file on your device.

Some of the scripts have configuration options (see their source code for more details).

If you're using some other device with OpenWrt installed but it also has RGB LEDs (and optionally a temperature sensor) you can modify the `led_r`, `led_g`, and `led_b` variables in some scripts and everything will work.

## What does it change?
* Restart button: click to reset the WAN interface, hold for more than 5 seconds to restart the device
* WPS button: click to enable/disable WPS, hold for more than 5 seconds to enable/disable WiFi
* Broadband LED: displays the WAN interface status and traffic A LOT better than the original configuration
* WiFi LED: displays WiFi status and traffic better than the original configuration, also displays WPS status
* Power LED: turns yellow if the temperature is above 75.5 degrees Celsius
