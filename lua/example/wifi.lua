-- Your access point's SSID and password
local SSID = "SEEED-MKT"
local SSID_PASSWORD = "depot0510"

-- configure ESP as a station
wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,SSID_PASSWORD)
wifi.sta.autoconnect(1)

print(wifi.sta.getip());