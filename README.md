# esx_aircraftshop
Aircraft Shop based on ESX

I did NOT create the Code. I only edited the esx_vehicleshop code to create this new shop. This code unlike most other versions out there do NOT interfere with the Original esx_vehicleshop.

This Aircraft Shop works just like esx_vehicleshop. However tho instead of Players buying Cars they can Buy/Sell Aircrafts. I created this because i couldn't find a Aircraft Shop Script & instead of waiting for others i went ahead & did it myself. 

The personal aircraft menu can be opened with /pa (like the vehicle shop /pv command).

# Requirement:

* Player management (billing and boss actions)
  * esx_society => https://github.com/FXServer-ESX/fxserver-esx_society
  * esx_billing => https://github.com/FXServer-ESX/fxserver-esx_billing
  
* Boat Garage
  * esx_eden_aircraftgarage => https://github.com/HumanTree92/esx_eden_aircraftgarage

# Installation

1) CD in your resources/[esx] folder
2) Clone the repository
3) Import esx_aircraftshop.sql in your database

4) Add this in your server.cfg :

```
start esx_aircraftshop
```
5) If you want player management you have to set Config.EnablePlayerManagement to true in config.lua

# Credits/Original Code
* ESX-Org => https://github.com/ESX-Org
  * esx_vehicleshop => https://github.com/ESX-Org/esx_vehicleshop
