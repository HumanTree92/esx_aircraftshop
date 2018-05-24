Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- If set to true, you need esx_addonaccount, esx_billing and esx_society
Config.EnablePaCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false
Config.ResellPercentage           = 50
Config.Locale                     = 'en'

Config.Zones = {

  ShopEntering = { -- Marker for accessing shop DONE
    Pos   = { x = -940.06, y = -2963.15, z = 18.85 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },

  ShopInside = { -- Marker for viewing Vehicles DONE (old x = -965.35, y = -3030.07, z = 14.55 )
    Pos     = { x = -1075.01, y = -2933.22, z = 14.55 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 59.9,
    Type    = -1,
  },

  ShopOutside = { -- Marker after purchasing vehicle DONE
    Pos     = { x = -965.25, y = -2983.56, z = 14.55 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 59.9,
    Type    = -1,
  },

  BossActions = { -- Boss Actions DONE
    Pos   = { x = -924.57, y = -2966.45, z = 18.85 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = { -- Marker for Player Management DONE (old x = -967.13, y = -2939.9, z = 14.55)
    Pos   = { x = -1040.79, y = -2991.23, z = 14.55 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },

  ResellVehicle = { -- Marker selling vehicle DONE
    Pos   = { x = -1003.24, y = -2920.79, z = 12.95 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },

}
