-- Old Main Menu
ModLoader.SetupFileHook( "lua/menu/GUIMainMenu.lua", "lua/NS2Plus/Client/CHUD_MainMenu.lua", "post")

-- New Main Menu
ModLoader.SetupFileHook( "lua/menu2/NavBar/Screens/Options/Mods/ModsMenuData.lua", "lua/NS2Plus/Client/CHUD_ModsMenuData.lua", "post")

-- GUIScripts
ModLoader.SetupFileHook("lua/GUIAlienHUD.lua", "lua/NS2Plus/GUIScripts/GUIAlienHUD.lua", "post")
ModLoader.SetupFileHook("lua/GUIAlienTeamMessage.lua", "lua/NS2Plus/GUIScripts/GUIAlienTeamMessage.lua", "post")
ModLoader.SetupFileHook("lua/Hud/Marine/GUIMarineHUD.lua", "lua/NS2Plus/GUIScripts/GUIMarineHUD.lua", "post")
ModLoader.SetupFileHook("lua/GUIMarineTeamMessage.lua", "lua/NS2Plus/GUIScripts/GUIMarineTeamMessage.lua", "post")
ModLoader.SetupFileHook("lua/Hud/Marine/GUIExoHUD.lua", "lua/NS2Plus/GUIScripts/GUIExoHUD.lua", "post")
ModLoader.SetupFileHook("lua/Weapons/Marine/ExoWeaponHolder.lua", "lua/NS2Plus/GUIScripts/ExoWeaponHolder.lua", "post")
ModLoader.SetupFileHook("lua/GUIMinimap.lua", "lua/NS2Plus/GUIScripts/GUIMinimap.lua", "post") -- Comm stuff is here
ModLoader.SetupFileHook("lua/MapBlip.lua", "lua/NS2Plus/GUIScripts/MapBlip.lua", "post")
ModLoader.SetupFileHook("lua/GUIMinimapFrame.lua", "lua/NS2Plus/GUIScripts/GUIMinimapFrame.lua", "post")
ModLoader.SetupFileHook("lua/GUIMinimapConnection.lua", "lua/NS2Plus/GUIScripts/GUIMinimapConnection.lua", "post")
ModLoader.SetupFileHook("lua/GUIProgressBar.lua", "lua/NS2Plus/GUIScripts/GUIProgressBar.lua", "post")
ModLoader.SetupFileHook("lua/GUIAlienBuyMenu.lua", "lua/NS2Plus/GUIScripts/GUIAlienBuyMenu.lua", "post")
ModLoader.SetupFileHook("lua/GUIGorgeBuildMenu.lua", "lua/NS2Plus/GUIScripts/GUIGorgeBuildMenu.lua", "post")
ModLoader.SetupFileHook("lua/GUIMarineBuyMenu.lua", "lua/NS2Plus/GUIScripts/GUIMarineBuyMenu.lua", "post")
ModLoader.SetupFileHook("lua/GUIWorldText.lua", "lua/NS2Plus/GUIScripts/GUIWorldText.lua", "post")
ModLoader.SetupFileHook("lua/GUIWaypoints.lua", "lua/NS2Plus/GUIScripts/GUIWaypoints.lua", "post")
ModLoader.SetupFileHook("lua/GUIUnitStatus.lua", "lua/NS2Plus/GUIScripts/GUIUnitStatus.lua", "post")
ModLoader.SetupFileHook("lua/GUIRequestMenu.lua", "lua/NS2Plus/GUIScripts/GUIRequestMenu.lua", "post")
ModLoader.SetupFileHook("lua/GUISensorBlips.lua", "lua/NS2Plus/GUIScripts/GUISensorBlips.lua", "post")
ModLoader.SetupFileHook("lua/GUIPickups.lua", "lua/NS2Plus/GUIScripts/GUIPickups.lua", "post")
ModLoader.SetupFileHook("lua/GUIScoreboard.lua", "lua/NS2Plus/GUIScripts/GUIScoreboard.lua", "post")
ModLoader.SetupFileHook("lua/GUINotifications.lua", "lua/NS2Plus/GUIScripts/GUINotifications.lua", "post")
ModLoader.SetupFileHook("lua/GUIDeathMessages.lua", "lua/NS2Plus/GUIScripts/GUIDeathMessages.lua", "post")
ModLoader.SetupFileHook("lua/GUICrosshair.lua", "lua/NS2Plus/GUIScripts/GUICrosshair.lua", "post")
ModLoader.SetupFileHook("lua/GUICommanderAlerts.lua", "lua/NS2Plus/GUIScripts/GUICommanderAlerts.lua", "post")
ModLoader.SetupFileHook("lua/Hud/GUIInventory.lua", "lua/NS2Plus/GUIScripts/GUIInventory.lua", "post")
ModLoader.SetupFileHook("lua/GUIProduction.lua", "lua/NS2Plus/GUIScripts/GUIProduction.lua", "post")
ModLoader.SetupFileHook("lua/Commander_Client.lua", "lua/NS2Plus/GUIScripts/Commander_Client.lua", "post")
ModLoader.SetupFileHook("lua/GUICommanderButtons.lua", "lua/NS2Plus/GUIScripts/GUICommanderButtons.lua", "post")
ModLoader.SetupFileHook("lua/GUIFeedback.lua", "lua/NS2Plus/GUIScripts/GUIFeedback.lua", "post")
ModLoader.SetupFileHook("lua/GUIJetpackFuel.lua", "lua/NS2Plus/GUIScripts/GUIJetpackFuel.lua", "post")
ModLoader.SetupFileHook("lua/GUIHiveStatus.lua", "lua/NS2Plus/GUIScripts/GUIHiveStatus.lua", "post")
ModLoader.SetupFileHook("lua/Hud2/topBar/GUIHudTopBarForLocalTeam.lua", "lua/NS2Plus/GUIScripts/GUIHudTopBarForLocalTeam.lua", "post")
ModLoader.SetupFileHook("lua/Hud/GUIPlayerResource.lua", "lua/NS2Plus/GUIScripts/GUIPlayerResource.lua", "post")
ModLoader.SetupFileHook("lua/Hud/GUIEvent.lua", "lua/NS2Plus/GUIScripts/GUIEvent.lua", "post")