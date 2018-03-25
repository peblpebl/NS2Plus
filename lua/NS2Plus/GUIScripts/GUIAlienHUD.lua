PrecacheAsset("ui/oma_alien_hud_health.dds")
PrecacheAsset("ui/rant_alien_hud_health.dds")

function GUIAlienHUD:CHUDRepositionGUI()
	local gametime = CHUDGetOption("gametime")
	local realtime = CHUDGetOption("realtime")
	local biomass = ClientUI.GetScript("GUIBioMassDisplay")
	local y = self.resourceDisplay.teamText:GetPosition().y

	if gametime and self.gameTime then
		y = y + 30
		self.gameTime:SetFontName(GUIMarineHUD.kTextFontName)
		self.gameTime:SetScale(GetScaledVector()*1.15)
		self.gameTime:SetPosition(Vector(20, y , 0))
		GUIMakeFontScale(self.gameTime)
	end

	if realtime and self.realTime then
		y = y + 30
		self.realTime:SetFontName(GUIMarineHUD.kTextFontName)
		self.realTime:SetScale(GetScaledVector()*1.15)
		self.realTime:SetPosition(Vector(20, y, 0))
		GUIMakeFontScale(self.realTime)
	end

	local biomassSmokeyBackground = ConditionalValue(mingui, "ui/alien_commander_bg_smoke.dds", "ui/transparent.dds")
	local biomassTexture = ConditionalValue(mingui, "ui/biomass_bar.dds", "ui/transparent.dds")
	local kBioMassBackgroundPos = GUIScale(Vector(20, 90, 0))
	local kSmokeyBackgroundPos = GUIScale(Vector(-100, 10, 0))

	biomass.smokeyBackground:SetAdditionalTexture("noise", biomassSmokeyBackground)
	biomass.smokeyBackground:SetPosition(kSmokeyBackgroundPos)
	biomass.background:SetTexture(biomassTexture)
	biomass.background:SetPosition(kBioMassBackgroundPos)
end

function GUIAlienHUD:OnLocalPlayerChanged(newPlayer)
	
	if Client.GetIsControllingPlayer() then
		Client.GetLocalPlayer():SetDarkVision(CHUDGetOption("avstate"))
	end

end

local originalAlienInit = GUIAlienHUD.Initialize
function GUIAlienHUD:Initialize()
	local mingui = not CHUDGetOption("mingui")
	local aliencircles = CHUDGetOption("aliencircles")

	originalAlienInit(self)

	self.gameTime = self:CreateAnimatedTextItem()
	self.gameTime:SetFontName(GUIMarineHUD.kTextFontName)
	self.gameTime:SetFontIsBold(true)
	self.gameTime:SetLayer(kGUILayerPlayerHUDForeground2)
	self.gameTime:SetColor(kAlienTeamColorFloat)

	self.realTime = self:CreateAnimatedTextItem()
	self.realTime:SetFontName(GUIMarineHUD.kTextFontName)
	self.realTime:SetFontIsBold(true)
	self.realTime:SetLayer(kGUILayerPlayerHUDForeground2)
	self.realTime:SetColor(kAlienTeamColorFloat)

	local kTextureNameCHUD = CHUDGetOptionAssocVal("aliencircles")
	local kBackgroundCHUD = ConditionalValue(mingui, PrecacheAsset("ui/alien_commander_bg_smoke.dds"), PrecacheAsset("ui/transparent.dds"))

	-- Backgrounds of health/energy
	self.healthBall.dialBackground:SetAdditionalTexture("noise", kBackgroundCHUD)
	self.energyBall.dialBackground:SetAdditionalTexture("noise", kBackgroundCHUD)
	self.secondaryAbilityBackground:SetAdditionalTexture("noise", kBackgroundCHUD)

	-- Alien bars
	self.healthBall:SetForegroundTexture(kTextureNameCHUD)
	self.armorBall:SetForegroundTexture(kTextureNameCHUD)
	self.energyBall:SetForegroundTexture(kTextureNameCHUD)
	self.adrenalineEnergy:SetForegroundTexture(kTextureNameCHUD)

	local healthColor = ConditionalValue(aliencircles == 2, Color(1, 1, 1, 1), Color(230/255, 171/255, 46/255, 1))
	local armorColor = ConditionalValue(aliencircles == 2, Color(1, 1, 1, 1), Color(1, 121/255, 12/255, 1))
	local adrenalineColor = ConditionalValue(aliencircles == 2, Color(1, 1, 1, 1), Color(1, 121/255, 12/255, 1))

	self.healthBall:GetLeftSide():SetColor(healthColor)
	self.healthBall:GetRightSide():SetColor(healthColor)

	self.armorBall:GetLeftSide():SetColor(armorColor)
	self.armorBall:GetRightSide():SetColor(armorColor)

	self.adrenalineEnergy:GetLeftSide():SetColor(adrenalineColor)
	self.adrenalineEnergy:GetRightSide():SetColor(adrenalineColor)

	if aliencircles == 2 then
		self.armorBall:GetLeftSide():SetTexturePixelCoordinates(0, 0, 64, 128)
		self.armorBall:GetRightSide():SetTexturePixelCoordinates(64, 0, 128, 128)

		self.energyBall:GetLeftSide():SetTexturePixelCoordinates(128, 128, 192, 256)
		self.energyBall:GetRightSide():SetTexturePixelCoordinates(192, 128, 256, 256)

		self.adrenalineEnergy:GetLeftSide():SetTexturePixelCoordinates(128, 0, 192, 128)
		self.adrenalineEnergy:GetRightSide():SetTexturePixelCoordinates(192, 0, 256, 128)
	end

	if CHUDGetOption("mingui") then
		self.resourceDisplay.background:SetColor(Color(1,1,1,0))
	else
		self.resourceDisplay.background:SetColor(Color(1,1,1,1))
	end

	Client.DestroyScreenEffect(Player.screenEffects.darkVision)
	Client.DestroyScreenEffect(HiveVision_screenEffect)
	Client.DestroyScreenEffect(HiveVisionExtra_screenEffect)
	HiveVision_screenEffect = Client.CreateScreenEffect("shaders/HiveVision.screenfx")
	HiveVisionExtra_screenEffect = Client.CreateScreenEffect("shaders/HiveVisionExtra.screenfx")
	Player.screenEffects.darkVision = Client.CreateScreenEffect(CHUDGetOptionAssocVal("av"))

	-- Cr4zyAV config options
	if CHUDGetOption("av") == 5 then
        updateAlienVision()
    end

	if CHUDGetOption("hudbars_a") > 0 then
		if CHUDGetOption("hudbars_a") == 2 then
			self.resourceDisplay.background:SetPosition(Vector(-440, -100, 0))
		end

		local healthBall = self.healthBall:GetBackground()
		local energyBall = self.energyBall:GetBackground()
		local healthBallPos = healthBall:GetPosition()
		local energyBallPos = energyBall:GetPosition()
		self.healthBall.leftSide:SetIsVisible(false)
		self.healthBall.rightSide:SetIsVisible(false)
		self.energyBall.leftSide:SetIsVisible(false)
		self.energyBall.rightSide:SetIsVisible(false)
		self.adrenalineEnergy:SetIsVisible(false)
		if CHUDGetOption("hudbars_a") == 2 then
			healthBall:SetPosition(Vector(healthBallPos.x+50, healthBallPos.y, 0))
			energyBall:SetPosition(Vector(energyBallPos.x-50, energyBallPos.y, 0))
			self.secondaryAbilityBackground:SetPosition(Vector(-50, -125, 0))
		end
	end

	self.gorgeBuiltText = GUIManager:CreateTextItem()
	self.gorgeBuiltText:SetFontName(Fonts.kStamp_Large)
	self.gorgeBuiltText:SetScale(GetScaledVector())
	self.gorgeBuiltText:SetAnchor(GUIItem.Middle, GUIItem.Center)
	self.gorgeBuiltText:SetTextAlignmentX(GUIItem.Align_Center)
	self.gorgeBuiltText:SetTextAlignmentY(GUIItem.Align_Center)
	self.gorgeBuiltText:SetColor(kAlienFontColor)
	self.gorgeBuiltText:SetInheritsParentAlpha(true)
	self.gorgeBuiltText:SetIsVisible(false)

	self.energyBall:GetBackground():AddChild(self.gorgeBuiltText)

	self:CHUDRepositionGUI()
end


function GUIAlienHUD:CHUDUpdateHealthBall(deltaTime)
	local healthBarPercentageGoal = PlayerUI_GetPlayerHealth() / PlayerUI_GetPlayerMaxHealth()
	self.healthBarPercentage = healthBarPercentageGoal

	local maxArmor = PlayerUI_GetPlayerMaxArmor()

	if not (maxArmor == 0) then
		local armorBarPercentageGoal = PlayerUI_GetPlayerArmor() / maxArmor
		self.armorBarPercentage = armorBarPercentageGoal
	end

	-- don't use more than 60% for armor in case armor value is bigger than health
	-- for skulk use 10 / 70 = 14% as armor and 86% as health
	local armorUseFraction = Clamp( PlayerUI_GetPlayerMaxArmor() / PlayerUI_GetPlayerMaxHealth(), 0, 0.6)
	local healthUseFraction = 1 - armorUseFraction

	-- set global rotation to snap to the health ring
	self.armorBall:SetRotation( - 2 * math.pi * self.healthBarPercentage * healthUseFraction )

	self.healthBall:SetPercentage(self.healthBarPercentage * healthUseFraction)
	self.armorBall:SetPercentage(self.armorBarPercentage * armorUseFraction)

	self:UpdateFading(self.healthBall:GetBackground(), self.healthBarPercentage * self.armorBarPercentage, deltaTime)
end

local originalAlienSetIsVisible = GUIAlienHUD.SetIsVisible
function GUIAlienHUD:SetIsVisible(state)
	originalAlienSetIsVisible(self, state)

	if self.gameTime then
		self.gameTime:SetIsVisible(state)
	end

	if self.realTime then
		self.realTime:SetIsVisible(state)
	end

end

local originalAlienUpdate = GUIAlienHUD.Update
function GUIAlienHUD:Update(deltaTime)
	originalAlienUpdate(self, deltaTime)

	local mingui = not CHUDGetOption("mingui")
	local rtcount = CHUDGetOption("rtcount")
	local gametime = CHUDGetOption("gametime")
	local realtime = CHUDGetOption("realtime")
	local showcomm = CHUDGetOption("showcomm")
	local instanthealth = CHUDGetOption("instantalienhealth")

	if instanthealth then
		self:CHUDUpdateHealthBall(deltaTime)
	end

	if not rtcount then
		self.resourceDisplay.rtCount:SetIsVisible(false)
		self.resourceDisplay.pResDescription:SetText(string.format("%s (%d %s)",
			Locale.ResolveString("RESOURCES"),
			CommanderUI_GetTeamHarvesterCount(),
			ConditionalValue(CommanderUI_GetTeamHarvesterCount() == 1, "RT", "RTs")))
	else
		self.resourceDisplay.rtCount:SetIsVisible(CommanderUI_GetTeamHarvesterCount() > 0)
		self.resourceDisplay.pResDescription:SetText(Locale.ResolveString("RESOURCES"))
	end

	if self.gameTime then
		self.gameTime:SetText(CHUDGetGameTimeString())
		self.gameTime:SetIsVisible(gametime and self.visible)
	end
	
	if self.realTime then
		self.realTime:SetText(CHUDGetRealTimeString())
		self.realTime:SetIsVisible(realtime and self.visible)
	end

	self.resourceDisplay.teamText:SetIsVisible(showcomm)

	local aliencircles = CHUDGetOption("aliencircles")
	local energyColor = Color(1, 1, 1, 1)

	if aliencircles == 2 and self.energyBall:GetBackground():GetColor() ~= Color(0.6, 0, 0, 1) then
		self.energyBall:GetLeftSide():SetColor(energyColor)
		self.energyBall:GetRightSide():SetColor(energyColor)
	end

	self.armorBall:SetIsVisible(self.healthBall:GetBackground():GetIsVisible() and CHUDGetOption("hudbars_a") == 0)

	if self.mucousBall and CHUDGetOption("hudbars_a") ~= 0 then
		self.mucousBall:SetIsVisible(false)
	end

	local player = Client.GetLocalPlayer()
	local gorgeBuiltTextVisible = false
	if player and player:isa("Gorge") and GUIGorgeBuildMenu then
		local activeWeapon = player:GetActiveWeapon()
		if activeWeapon and activeWeapon:isa("DropStructureAbility") then
			local dropStructureAbility = player:GetWeapon(DropStructureAbility.kMapName)
			if dropStructureAbility then
				local structure = dropStructureAbility:GetActiveStructure()
				local structureId = structure and structure:GetDropStructureId() or -1
				local maxStructures = GorgeBuild_GetMaxNumStructure(structureId)
				local numBuilt = dropStructureAbility:GetNumStructuresBuilt(structureId)

				gorgeBuiltTextVisible = structureId ~= -1
				if gorgeBuiltTextVisible then
					self.gorgeBuiltText:SetText(numBuilt .. "/" .. maxStructures)
					self.gorgeBuiltText:SetColor(GorgeBuild_GetCanAffordAbility(structureId) and kAlienFontColor or kRed)
				end
			end
		end
	end
	self.gorgeBuiltText:SetIsVisible(gorgeBuiltTextVisible)
	self.activeAbilityIcon:SetIsVisible(not gorgeBuiltTextVisible)
end
	
local originalAlienReset = GUIAlienHUD.Reset
function GUIAlienHUD:Reset()
	originalAlienReset(self)

	self:CHUDRepositionGUI()
end

local originalAlienUninit = GUIAlienHUD.Uninitialize
function GUIAlienHUD:Uninitialize()
	originalAlienUninit(self)

	GUI.DestroyItem(self.gameTime)
	self.gameTime = nil
	
	GUI.DestroyItem(self.realTime)
	self.realTime = nil
end

function updateAlienVision()
    local player = Client.GetLocalPlayer()
    local useShader = Player.screenEffects.darkVision
    local av_close = ColorIntToColor(CHUDGetOption("av_closecolor"))
    local av_distant = ColorIntToColor(CHUDGetOption("av_distantcolor"))
    local av_fog = ColorIntToColor(CHUDGetOption("av_fogcolor"))
    local av_style = CHUDGetOption("av_style")
    local av_offstyle = CHUDGetOption("av_offstyle")
    local av_edges = CHUDGetOption("av_edges")
    local av_edgesize = CHUDGetOption("av_edgesize") / 1000
    local av_closeIntensity = CHUDGetOption("av_closeintensity")
    local av_distantIntensity = CHUDGetOption("av_distantintensity")
    local av_fogIntensity = CHUDGetOption("av_fogintensity")
    local av_desat = CHUDGetOption("av_desaturation")
    local av_desatIntensity = CHUDGetOption("av_desaturationintensity")
    local av_viewModelStyle = CHUDGetOption("av_viewmodelstyle")
    local av_viewModelIntensity = CHUDGetOption("av_viewmodelintensity")
    local av_worldIntensity = CHUDGetOption("av_worldintensity")
    local av_activateEffect = CHUDGetOption("av_activationeffect")
    local av_skyBox = CHUDGetOption("av_skybox")
    local av_blendDistance = CHUDGetOption("av_blenddistance")
    local av_desatBlend = CHUDGetOption("av_desaturationblend")
    local actualAspect   = Client.GetScreenWidth() / Client.GetScreenHeight()
    local av_marineColor = CHUDGetOption("av_marinecolor")
    
    --player aspect ratio, so drawing circles is better
    useShader:SetParameter("avAspect", actualAspect)

    --close colours
    useShader:SetParameter("closeR", av_close.r)
    useShader:SetParameter("closeG", av_close.g)
    useShader:SetParameter("closeB", av_close.b)
    useShader:SetParameter("closeIntensity", av_closeIntensity)
    
    --distant colours
    useShader:SetParameter("distantR", av_distant.r)
    useShader:SetParameter("distantG", av_distant.g)
    useShader:SetParameter("distantB", av_distant.b)
    useShader:SetParameter("distantIntensity", av_distantIntensity)

    --fog colours
    useShader:SetParameter("fogR", av_fog.r)
    useShader:SetParameter("fogG", av_fog.g)
    useShader:SetParameter("fogB", av_fog.b)
    useShader:SetParameter("fogIntensity", av_fogIntensity)
    
    --marine colour changer
    useShader:SetParameter("marineColor", av_marineColor)
    

    --style selectors
    useShader:SetParameter("modeAV", av_style)
    useShader:SetParameter("modeAVoff", av_offstyle)

    --edge values
    useShader:SetParameter("avEdge", av_edges)
    useShader:SetParameter("edgeSize", av_edgesize)

    --world values
    useShader:SetParameter("avDesat", av_desat)
    useShader:SetParameter("desatIntensity", av_desatIntensity)
    useShader:SetParameter("avDesatBlend", av_desatBlend)
    useShader:SetParameter("avWorldIntensity", av_worldIntensity)
    useShader:SetParameter("avSky", av_skyBox)
    useShader:SetParameter("avBlend", av_blendDistance)
    
    --activation effect
    useShader:SetParameter("avToggle", av_activateEffect)
    
    --viewmodel
    useShader:SetParameter("avViewModelStyle", av_viewModelStyle)
    useShader:SetParameter("avViewModel", av_viewModelIntensity)
end