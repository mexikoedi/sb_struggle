if engine.ActiveGamemode() == "terrortown" then return end
if SERVER then
    AddCSLuaFile()
    resource.AddFile("materials/vgui/entities/weapon_snuggle_struggle.vmt")
    resource.AddFile("materials/HUD/killicons/weapon_snuggle_struggle.vmt")
    resource.AddFile("sound/noice.wav")
end

SWEP.PrintName = "Snuggle Struggle"
SWEP.Author = "mexikoedi"
SWEP.Contact = "Steam"
SWEP.Instructions = "Left click to have fun with the enemy and secondary attack to play random sounds."
SWEP.Purpose = "Taunt and have fun with the enemies."
SWEP.Category = "mexikoedi's SWEPS"
SWEP.DrawWeaponInfoBox = true
SWEP.BounceWeaponIcon = true
SWEP.ViewModelFOV = 82
SWEP.ViewModelFlip = true
SWEP.NoSights = false
SWEP.AllowDrop = false
SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.AdminSpawnable = false
SWEP.AutoSpawnable = false
SWEP.Icon = "vgui/weapon_snuggle_struggle"
SWEP.Base = "weapon_base"
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.Primary.Sound = Sound("vo/novaprospekt/al_holdon.wav")
SWEP.Primary.Recoil = 0
SWEP.Primary.Damage = 0
SWEP.Primary.NumShots = -1
SWEP.Primary.Delay = 3
SWEP.Primary.Distance = 100
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.RPS = 3
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 3
SWEP.Weight = 7
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.FiresUnderwater = false
attackerweapons = {}
victimweapons = {}
SWEP.ViewModel = Model("models/weapons/v_hands.mdl")
local Killicon_Color_Icon = Color(255, 255, 255, 255)
SWEP.SnuggleLength = 5
SWEP.SoundDelay = 1.5
local ThrustVelocity = 750
local boneNames = {"ValveBiped.Bip01_Spine2", "ValveBiped.Bip01_R_UpperArm", "ValveBiped.Bip01_L_UpperArm", "ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Hand", "ValveBiped.Bip01_R_Forearm", "ValveBiped.Bip01_R_Hand", "ValveBiped.Bip01_R_Thigh", "ValveBiped.Bip01_R_Calf", "ValveBiped.Bip01_Head1", "ValveBiped.Bip01_L_Thigh", "ValveBiped.Bip01_L_Calf", "ValveBiped.Bip01_L_Foot", "ValveBiped.Bip01_R_Foot",}
local victimPos = {Vector(4.1165161132813, 0.33807373046875, 24.5458984375), Vector(10.886047363281, -6.7128601074219, 17.712890625), Vector(14.32470703125, 6.6110534667969, 24.662109375), Vector(10.561950683594, 11.863800048828, 14.9169921875), Vector(14.15673828125, 11.935821533203, 4.0126953125), Vector(8.0779418945313, -10.698425292969, 7.0859375), Vector(17.083557128906, -6.5664367675781, 1.28515625), Vector(-6.3666381835938, -3.5222778320313, 22.1142578125), Vector(-5.1080932617188, -3.3052978515625, 4.3046875), Vector(18.328247070313, -0.20745849609375, 18.6533203125), Vector(-7.3578491210938, 4.1403503417969, 22.0517578125), Vector(-6.7325439453125, 3.0444641113281, 4.2421875), Vector(-23.113708496094, 2.7197570800781, 6.40234375), Vector(-21.197875976563, -3.1515197753906, 6.390625),}
local victimAng = {Angle(13.763027191162, -7.126654624939, 297.44543457031), Angle(65.35457611084, -125.17009735107, 116.02203369141), Angle(56.451721191406, 125.61678314209, 68.999862670898), Angle(71.750823974609, 1.1475394964218, 309.23059082031), Angle(10.08162021637, 20.952842712402, 89.150527954102), Angle(30.348388671875, 24.646505355835, 257.76071166992), Angle(-31.068134307861, 5.5770988464355, 100.95864105225), Angle(85.568023681641, -10.062316894531, 259.72805786133), Angle(-11.049569129944, 179.28791809082, 92.02823638916), Angle(36.883769989014, -10.713672637939, 95.383735656738), Angle(87.360504150391, -50.038749694824, 219.5774230957), Angle(-7.4636454582214, -178.8634185791, 90.854110717773), Angle(20.328042984009, 175.31163024902, 84.239585876465), Angle(20.698318481445, -177.09216308594, 94.63240814209),}
local attackerPos = {Vector(-0.65728759765625, 0.377197265625, 30.7626953125), Vector(9.2244873046875, -3.9486083984375, 35.96484375), Vector(6.1197509765625, 10.176849365234, 30.6552734375), Vector(8.9208984375, 12.130462646484, 20.0087890625), Vector(11.781127929688, 14.134094238281, 9.0712890625), Vector(10.643859863281, -13.228057861328, 29.0009765625), Vector(15.782470703125, -6.8009948730469, 20.9951171875), Vector(-9.7853393554688, -4.5965576171875, 24.3857421875), Vector(-11.373352050781, -7.4108276367188, 6.8203125), Vector(13.504028320313, 4.9801635742188, 34.6708984375), Vector(-11.517456054688, 2.9996948242188, 25.9482421875), Vector(-14.434143066406, 11.57861328125, 10.537109375), Vector(-30.881225585938, 10.939605712891, 9.0634765625), Vector(-26.714416503906, -13.074645996094, 9.19921875),}
local attackerAng = {Angle(-23.909204483032, 21.916522979736, 247.47807312012), Angle(36.469985961914, -81.487747192383, 121.61176300049), Angle(72.325134277344, 35.100917816162, 310.2248840332), Angle(72.292373657227, 35.012317657471, 310.07629394531), Angle(53.682888031006, 77.813186645508, 63.455425262451), Angle(44.2184715271, 51.356468200684, 233.86199951172), Angle(18.646379470825, 13.987821578979, 129.42607116699), Angle(79.875244140625, -120.97535705566, 128.95693969727), Angle(-8.2740859985352, -159.73634338379, 95.78791809082), Angle(4.1483745574951, 25.958532333374, 65.960624694824), Angle(59.834487915039, 108.70742797852, 10.802012443542), Angle(5.1143140792847, -177.7751159668, 61.338542938232), Angle(46.266540527344, 113.92001342773, 15.213181495667), Angle(49.310661315918, -157.73908996582, 96.905143737793),}
local sounds = {"player/crit_death1.wav", "player/crit_death2.wav", "player/crit_death3.wav", "player/crit_death4.wav", "player/crit_death5.wav", "bot/come_to_papa.wav", "bot/im_pinned_down.wav", "bot/oh_man.wav", "bot/yesss.wav", "bot/pain4", "bot/pain5", "bot/pain8", "bot/pain9", "bot/pain10", "bot/stop_it.wav", "bot/help.wav", "bot/i_could_use_some_help.wav", "bot/i_could_use_some_help_over_here.wav", "bot/they_got_me_pinned_down_here.wav", "bot/this_is_my_house.wav", "bot/need_help.wav", "bot/i_am_dangerous.wav", "bot/yikes.wav", "noo.wav", "bot/whos_the_man.wav", "bot/hang_on_im_coming.wav", "hostage/hpain/hpain1.wav", "hostage/hpain/hpain2.wav", "hostage/hpain/hpain3.wav", "hostage/hpain/hpain4.wav", "hostage/hpain/hpain5.wav", "hostage/hpain/hpain6.wav", "vo/k_lab/al_youcoming.wav", "vo/k_lab/kl_ahhhh.wav", "noice.wav",}
local sounds2 = {"bot/where_are_you_hiding.wav", "vo/NovaProspekt/al_whereareyou03.wav", "vo/Citadel/al_wonderwhere.wav",}
local sounds3 = {"physics/body/body_medium_break2.wav", "physics/body/body_medium_break3.wav", "physics/body/body_medium_break4.wav", "physics/body/body_medium_impact_hard1.wav", "physics/body/body_medium_impact_hard2.wav", "physics/body/body_medium_impact_hard3.wav", "physics/body/body_medium_impact_hard4.wav", "physics/body/body_medium_impact_hard5.wav", "physics/body/body_medium_impact_hard6.wav",}
if CLIENT then
    killicon.Add("weapon_snuggle_struggle", "HUD/killicons/weapon_snuggle_struggle", Killicon_Color_Icon)
end

function SWEP:Initialize()
end

SWEP.WepSelectIcon = Material("vgui/entities/weapon_snuggle_struggle")
function SWEP:DrawWeaponSelection(x, y, w, h, a)
    render.PushFilterMag(TEXFILTER.ANISOTROPIC)
    render.PushFilterMin(TEXFILTER.ANISOTROPIC)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIcon)
    local fsin = 0
    if self.BounceWeaponIcon == true then
        fsin = math.sin(CurTime() * 10) * 5
    end

    local size = math.min(w, h) - 32
    surface.DrawTexturedRect(x - 50 + w + fsin / 2 - size - fsin / 2, y + h * 0.05 - fsin * 2, size, size + fsin)
    render.PopFilterMag()
    render.PopFilterMin()
    self:PrintWeaponInfo(x + 220 + w / 2 - size / 2, y + 170 + h * 0.05, 255)
end

if SERVER then
    -- damage/inflictor code
    local function InstantDamage(ply, damage, attacker, inflictor)
        local dmg = DamageInfo()
        dmg:SetDamage(damage or 500)
        dmg:SetAttacker(attacker or ply)
        dmg:SetDamageForce(ply:GetAimVector())
        dmg:SetDamagePosition(ply:GetPos())
        dmg:SetDamageType(DMG_GENERIC)
        if inflictor then
            dmg:SetInflictor(inflictor)
        end

        ply:TakeDamageInfo(dmg)
    end

    local function abortVictim(victim, owner, positionVictim, positionOwner, victimRagdoll)
        if IsValid(owner) then
            owner:SetPos(positionOwner)
            owner:SetJumpPower(160)
            owner:SetCrouchedWalkSpeed(0.3)
            owner:SetRunSpeed(220)
            owner:SetWalkSpeed(220)
            owner:SetMaxSpeed(220)
            owner:GodDisable()
        end

        -- revert changes from before and add damage
        if IsValid(victim) then
            if not victim:IsNPC() and victim:IsPlayer() then
                victim:UnSpectate()
            elseif victim:IsNPC() then
                victim:SetNoDraw(false)
            end

            victim:Spawn()
            victim:SetPos(positionVictim)
        end

        -- removing victim ragdoll
        SafeRemoveEntity(victimRagdoll)
        -- giving weapon back + selecting it
        owner:Give("weapon_snuggle_struggle")
        owner:SelectWeapon("weapon_snuggle_struggle")
    end

    local function abortOwner(victim, owner, positionVictim, positionOwner, victimRagdoll, ownerRagdoll)
        if IsValid(owner) then
            owner:SetPos(positionOwner)
            owner:SetJumpPower(160)
            owner:SetCrouchedWalkSpeed(0.3)
            owner:SetRunSpeed(220)
            owner:SetWalkSpeed(220)
            owner:SetMaxSpeed(220)
            owner:GodDisable()
        end

        -- revert changes from before and add damage
        if IsValid(victim) then
            if not victim:IsNPC() and victim:IsPlayer() then
                victim:UnSpectate()
            elseif victim:IsNPC() then
                victim:SetNoDraw(false)
            end

            victim:Spawn()
            victim:SetPos(positionVictim)
        end

        -- removing ragdolls (victim too at this point)
        SafeRemoveEntity(victimRagdoll)
        SafeRemoveEntity(ownerRagdoll)
        -- giving weapon back + selecting it
        owner:Give("weapon_snuggle_struggle")
        owner:SelectWeapon("weapon_snuggle_struggle")
    end

    local function success(victim, owner, positionVictim, positionOwner, victimRagdoll, ownerRagdoll, soundTimerString, thrustTimerString)
        if IsValid(owner) then
            if owner:Health() < 100 then
                owner:SetHealth(100)
            end

            owner:SetPos(positionOwner)
            owner:SetJumpPower(160)
            owner:SetCrouchedWalkSpeed(0.3)
            owner:SetRunSpeed(220)
            owner:SetWalkSpeed(220)
            owner:SetMaxSpeed(220)
            owner:GodDisable()
        end

        -- revert changes from before and add damage
        if IsValid(victim) then
            if not victim:IsNPC() and victim:IsPlayer() then
                victim:UnSpectate()
            elseif victim:IsNPC() then
                victim:SetNoDraw(false)
            end

            victim:Spawn()
            victim:SetPos(positionVictim)
            -- create damage
            InstantDamage(victim, 1000, owner, ents.Create("weapon_snuggle_struggle"))
        end

        -- removing ragdolls and timers
        SafeRemoveEntity(victimRagdoll)
        SafeRemoveEntity(ownerRagdoll)
        timer.Remove(soundTimerString)
        timer.Remove(thrustTimerString)
    end

    function SWEP:PrimaryAttack()
        -- set up postioning stuff and owner/victim checks
        local owner = self:GetOwner()
        local victim = owner:GetEyeTrace().Entity
        if not IsValid(victim) then return end
        -- if nextbot or a different entity (not player/npc) then abort
        if victim:IsNextBot() then
            owner:ChatPrint("Nextbots are not supported! Aborting!")

            return
        elseif not victim:IsNPC() and not victim:IsPlayer() then
            owner:ChatPrint("Invalid entity! Aborting!")

            return
        end

        local positionOwner = owner:GetPos()
        local positionVictim = victim:GetPos()
        local positionBase = positionOwner + Vector(0, 0, 5)
        local traceda = {}
        traceda.start = positionBase
        traceda.endpos = positionBase - Vector(0, 0, 1000)
        traceda.filter = {victim, owner}
        local trace = util.TraceLine(traceda)
        positionBase = trace.HitPos or positionBase
        if positionVictim:Distance(positionOwner) > self.Primary.Distance then return end
        owner:EmitSound(self.Primary.Sound)
        -- set owner to godmode with no movement + position him + remove snuggle struggle + set victim to spectator camera and no movement (if npc then invisible and no weapons)
        owner:GodEnable()
        owner:SetJumpPower(1)
        owner:SetCrouchedWalkSpeed(0.1)
        owner:SetRunSpeed(1)
        owner:SetWalkSpeed(1)
        owner:SetMaxSpeed(1)
        owner:SetPos(positionOwner + Vector(0, 50, 0))
        owner:StripWeapon("weapon_snuggle_struggle")
        if not victim:IsNPC() and victim:IsPlayer() then
            victim:Spectate(OBS_MODE_CHASE)
            victim:StripWeapons()
            victim:SetJumpPower(1)
            victim:SetCrouchedWalkSpeed(0.1)
            victim:SetRunSpeed(1)
            victim:SetWalkSpeed(1)
            victim:SetMaxSpeed(1)
        elseif victim:IsNPC() then
            victim:DropWeapon()
            victim:SetNoDraw(true)
        end

        -- ragdoll creation and set up for victim and owner
        local victimRagdoll = ents.Create("prop_ragdoll")
        victimRagdoll:SetModel(victim:GetModel())
        victimRagdoll:SetPos(positionVictim)
        victimRagdoll:Spawn()
        victimRagdoll:Activate()
        -- check for invalid bones (weird victim model)
        if victimRagdoll:GetPhysicsObjectCount() - 1 <= 0 then
            owner:ChatPrint("Invalid victim model! Aborting!")
            abortVictim(victim, owner, positionVictim, positionOwner, victimRagdoll)

            return
        end

        for i = 1, victimRagdoll:GetPhysicsObjectCount() - 1 do
            local boneName = boneNames[i]
            -- check for invalid bones (weird victim model)
            if boneName == nil or victimRagdoll:LookupBone(boneName) == nil then
                owner:ChatPrint("Invalid victim model! Aborting!")
                abortVictim(victim, owner, positionVictim, positionOwner, victimRagdoll)

                return
            end

            local boneId = victimRagdoll:LookupBone(boneName)
            if boneId ~= nil then
                local physId = victimRagdoll:TranslateBoneToPhysBone(boneId)
                local phys = victimRagdoll:GetPhysicsObjectNum(physId)
                if not IsValid(phys) then continue end
                phys:SetPos(positionBase + victimPos[i])
                phys:SetAngles(victimAng[i])
                phys:EnableCollisions(true)
                phys:EnableMotion(false)
            end
        end

        local ownerRagdoll = ents.Create("prop_ragdoll")
        ownerRagdoll:SetModel(owner:GetModel())
        ownerRagdoll:SetPos(positionOwner)
        ownerRagdoll:Spawn()
        ownerRagdoll:Activate()
        -- check for invalid bones (weird owner model)
        if ownerRagdoll:GetPhysicsObjectCount() - 1 <= 0 then
            owner:ChatPrint("Invalid owner model! Aborting!")
            abortOwner(victim, owner, positionVictim, positionOwner, victimRagdoll, ownerRagdoll)

            return
        end

        for i = 1, ownerRagdoll:GetPhysicsObjectCount() - 1 do
            local boneName = boneNames[i]
            -- check for invalid bones (weird owner model)
            if boneName == nil or ownerRagdoll:LookupBone(boneName) == nil then
                owner:ChatPrint("Invalid owner model! Aborting!")
                abortOwner(victim, owner, positionVictim, positionOwner, victimRagdoll, ownerRagdoll)

                return
            end

            local boneId = ownerRagdoll:LookupBone(boneName)
            if boneId ~= nil then
                local physId = ownerRagdoll:TranslateBoneToPhysBone(boneId)
                local phys = ownerRagdoll:GetPhysicsObjectNum(physId)
                if not IsValid(phys) then continue end
                phys:SetPos(positionBase + attackerPos[i])
                phys:SetAngles(attackerAng[i])
                phys:EnableCollisions(false)
                phys:EnableMotion(true)
                if i == 2 or i == 5 or i == 7 or i == 10 or i == 13 or i == 14 then
                    phys:EnableMotion(false)
                end
            end
        end

        -- spectate each other (only if player and not npc) and play random sounds
        owner:SpectateEntity(ownerRagdoll)
        if not victim:IsNPC() and victim:IsPlayer() then
            victim:SpectateEntity(ownerRagdoll)
        end

        local thrustTimerString = "SnuggleThrust_" .. (owner:SteamID64() or "SINGLEPLAYER")
        local boneName = boneNames[11]
        local boneId = ownerRagdoll:LookupBone(boneName)
        if boneId ~= nil then
            local physId = ownerRagdoll:TranslateBoneToPhysBone(boneId)
            local phys = ownerRagdoll:GetPhysicsObjectNum(physId)
            if IsValid(phys) then
                phys:SetVelocity(Vector(0, 0, 100000))
                timer.Create(
                    thrustTimerString,
                    0.3,
                    0,
                    function()
                        phys:SetVelocity(Vector(0, 0, ThrustVelocity))
                        if IsValid(victimRagdoll) and math.random(5) == 3 then
                            victimRagdoll:EmitSound(sounds3[math.random(#sounds3)])
                        end
                    end
                )
            end
        end

        local soundTimerString = "EmitSnuggleSounds_" .. (owner:SteamID64() or "SINGLEPLAYER")
        timer.Create(
            soundTimerString,
            self.SoundDelay,
            0,
            function()
                if not victimRagdoll:IsValid() then return end
                victimRagdoll:EmitSound(sounds[math.random(#sounds)])
            end
        )

        -- check health/give health + positioning of owner/victim and letting the owner move again with no godmode
        timer.Simple(
            self.SnuggleLength,
            function()
                success(victim, owner, positionVictim, positionOwner, victimRagdoll, ownerRagdoll, soundTimerString, thrustTimerString)
            end
        )
    end

    SWEP.NextSecondaryAttack = 0
    function SWEP:SecondaryAttack()
        if self.NextSecondaryAttack > CurTime() then return end
        self.NextSecondaryAttack = CurTime() + self.Secondary.Delay
        local owner = self:GetOwner()
        -- set up random sounds
        owner:EmitSound(sounds2[math.random(#sounds2)])
    end
end