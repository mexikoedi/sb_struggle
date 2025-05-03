if engine.ActiveGamemode() == "terrortown" then return end
if SERVER then
    AddCSLuaFile()
    resource.AddFile("materials/vgui/entities/weapon_struggle.vmt")
    resource.AddFile("materials/HUD/killicons/weapon_struggle.vmt")
end

SWEP.PrintName = "Struggle"
SWEP.Author = "mexikoedi"
SWEP.Contact = "Steam"
SWEP.Instructions = "Left click to arrest and kill the enemy and secondary attack to play random sounds."
SWEP.Purpose = "Taunt and arrest and kill your enemies."
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
SWEP.Icon = "vgui/weapon_struggle"
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
SWEP.ViewModel = Model("models/weapons/v_hands.mdl")
local Killicon_Color_Icon = Color(255, 255, 255, 255)
SWEP.StruggleLength = 5
SWEP.SoundDelay = 1.5
local animation = {
    ["struggle"] = {
        ["ValveBiped.Bip01_Pelvis"] = {
            pos = Vector(0, 0, -23)
        },
        ["ValveBiped.Bip01_R_Calf"] = {
            ang = Angle(0, 120, 0)
        },
        ["ValveBiped.Bip01_L_Calf"] = {
            ang = Angle(0, 120, 0)
        },
        ["ValveBiped.Bip01_R_Thigh"] = {
            ang = Angle(0, -30, 0)
        },
        ["ValveBiped.Bip01_L_Thigh"] = {
            ang = Angle(0, -30, 0)
        },
        ["ValveBiped.Bip01_R_Foot"] = {
            ang = Angle(0, 30, 0)
        },
        ["ValveBiped.Bip01_L_Foot"] = {
            ang = Angle(0, 30, 0)
        },
        ["ValveBiped.Bip01_R_UpperArm"] = {
            ang = Angle(30, 0, 90)
        },
        ["ValveBiped.Bip01_L_UpperArm"] = {
            ang = Angle(-30, 0, -90)
        },
        ["ValveBiped.Bip01_R_ForeArm"] = {
            ang = Angle(0, -130, 0)
        },
        ["ValveBiped.Bip01_L_ForeArm"] = {
            ang = Angle(0, -120, 20)
        }
    }
}

local sounds = {"bot/im_pinned_down.wav", "bot/oh_man.wav", "bot/pain4", "bot/pain5", "bot/pain8", "bot/pain9", "bot/pain10", "bot/stop_it.wav", "bot/help.wav", "bot/i_could_use_some_help.wav", "bot/i_could_use_some_help_over_here.wav", "bot/they_got_me_pinned_down_here.wav", "bot/need_help.wav", "bot/yikes.wav", "bot/noo.wav", "hostage/hpain/hpain1.wav", "hostage/hpain/hpain2.wav", "hostage/hpain/hpain3.wav", "hostage/hpain/hpain4.wav", "hostage/hpain/hpain5.wav", "hostage/hpain/hpain6.wav", "vo/k_lab/kl_ahhhh.wav",}
local sounds2 = {"bot/where_are_you_hiding.wav", "vo/NovaProspekt/al_whereareyou03.wav", "vo/Citadel/al_wonderwhere.wav",}
local sounds3 = {"physics/body/body_medium_break2.wav", "physics/body/body_medium_break3.wav", "physics/body/body_medium_break4.wav", "physics/body/body_medium_impact_hard1.wav", "physics/body/body_medium_impact_hard2.wav", "physics/body/body_medium_impact_hard3.wav", "physics/body/body_medium_impact_hard4.wav", "physics/body/body_medium_impact_hard5.wav", "physics/body/body_medium_impact_hard6.wav",}
if CLIENT then killicon.Add("weapon_struggle", "HUD/killicons/weapon_struggle", Killicon_Color_Icon) end
function SWEP:Initialize()
end

SWEP.WepSelectIcon = Material("vgui/entities/weapon_struggle")
function SWEP:DrawWeaponSelection(x, y, w, h, a)
    render.PushFilterMag(TEXFILTER.ANISOTROPIC)
    render.PushFilterMin(TEXFILTER.ANISOTROPIC)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIcon)
    local fsin = 0
    if self.BounceWeaponIcon == true then fsin = math.sin(CurTime() * 10) * 5 end
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
        if inflictor then dmg:SetInflictor(inflictor) end
        ply:TakeDamageInfo(dmg)
    end

    local function abortVictim(victim, owner)
        if IsValid(owner) then
            owner:SetJumpPower(160)
            owner:SetCrouchedWalkSpeed(0.3)
            owner:SetRunSpeed(220)
            owner:SetWalkSpeed(220)
            owner:SetMaxSpeed(220)
            owner:GodDisable()
        end

        -- revert changes from before
        if IsValid(victim) and not victim:IsNPC() and victim:IsPlayer() then
            victim:Freeze(false)
            local bonecount = victim:GetBoneCount()
            for i = 0, bonecount do
                victim:ManipulateBonePosition(i, Vector(0, 0, 0))
                victim:ManipulateBoneAngles(i, Angle(0, 0, 0))
            end
        end

        -- giving weapon back + selecting it
        owner:Give("weapon_struggle")
        owner:SelectWeapon("weapon_struggle")
    end

    local function success(victim, owner, animationTimerString, soundTimerString)
        if IsValid(owner) then
            if owner:Health() < 100 then owner:SetHealth(100) end
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
                victim:Freeze(false)
                local bonecount = victim:GetBoneCount()
                for i = 0, bonecount do
                    victim:ManipulateBonePosition(i, Vector(0, 0, 0))
                    victim:ManipulateBoneAngles(i, Angle(0, 0, 0))
                end
            end

            -- create damage
            InstantDamage(victim, 1000, owner, ents.Create("weapon_struggle"))
        end

        -- removing timers
        timer.Remove(animationTimerString)
        timer.Remove(soundTimerString)
    end

    function SWEP:PrimaryAttack()
        -- set up postioning stuff and owner/victim checks + activate lag compensation
        local owner = self:GetOwner()
        if not IsValid(owner) then return end
        owner:LagCompensation(true)
        local victim = owner:GetEyeTrace().Entity
        if not IsValid(victim) then
            owner:LagCompensation(false)
            return
        end

        -- if nextbot or a different entity (not player/npc) then abort and deactivate lag compensation
        if victim:IsNextBot() then
            owner:ChatPrint("Nextbots are not supported! Aborting!")
            owner:LagCompensation(false)
            return
        elseif not victim:IsNPC() and not victim:IsPlayer() then
            owner:ChatPrint("Invalid entity! Aborting!")
            owner:LagCompensation(false)
            return
        end

        -- check for invalid bones (weird victim model)
        for bone in pairs(animation["struggle"]) do
            local boneid = victim:LookupBone(bone)
            if boneid == nil or victim:LookupBone(bone) == nil then
                owner:ChatPrint("Invalid victim model! Aborting!")
                abortVictim(victim, owner)
                owner:LagCompensation(false)
                return
            end
        end

        local positionOwner = owner:GetPos()
        local positionVictim = victim:GetPos()
        if positionVictim:Distance(positionOwner) > self.Primary.Distance then
            owner:LagCompensation(false)
            return
        end

        owner:EmitSound(self.Primary.Sound)
        -- set owner to godmode with no movement + position him + remove struggle + strip weapons from victim with no movement (if npc then no weapons and dead state to disable movement)
        owner:GodEnable()
        owner:SetJumpPower(1)
        owner:SetCrouchedWalkSpeed(0.1)
        owner:SetRunSpeed(1)
        owner:SetWalkSpeed(1)
        owner:SetMaxSpeed(1)
        owner:StripWeapon("weapon_struggle")
        if not victim:IsNPC() and victim:IsPlayer() then
            victim:StripWeapons()
            victim:Freeze(true)
        elseif victim:IsNPC() then
            victim:DropWeapon()
            victim:SetNPCState(NPC_STATE_PLAYDEAD)
        end

        -- animation, sound and multiple checks to ensure proper functionality
        local check = 1
        local animationTimerString = "StruggleAnimation_" .. (owner:SteamID64() or "SINGLEPLAYER")
        timer.Create(animationTimerString, 0.3, 0, function()
            if not victim:IsValid() then
                owner:LagCompensation(false)
                return
            end

            if math.random(5) == 3 then victim:EmitSound(sounds3[math.random(#sounds3)]) end
            for bone, params in pairs(animation["struggle"]) do
                local boneid = victim:LookupBone(bone)
                if boneid then
                    local bonePos = params.pos or Vector(0, 0, 0)
                    local boneAng = params.ang or Angle(0, 0, 0)
                    local randPos = Vector(bonePos.x + math.Rand(-1.0, 1.0), bonePos.y + math.Rand(-1.0, 1.0), bonePos.z + math.Rand(-1.0, 1.0))
                    local randAng = Angle(boneAng.p + math.Rand(-5, 5), boneAng.y + math.Rand(-5, 5), boneAng.r + math.Rand(-5, 5))
                    victim:ManipulateBonePosition(boneid, randPos)
                    victim:ManipulateBoneAngles(boneid, randAng)
                end
            end
        end)

        local soundTimerString = "StruggleSound_" .. (owner:SteamID64() or "SINGLEPLAYER")
        timer.Create(soundTimerString, self.SoundDelay, 0, function()
            if not victim:IsValid() then
                owner:LagCompensation(false)
                return
            end

            if not victim:IsNPC() and not victim:Alive() then
                check = 0
                success(victim, owner, animationTimerString, soundTimerString)
            end

            if victim:IsNPC() and victim:GetNPCState() == NPC_STATE_DEAD then
                check = 0
                success(victim, owner, animationTimerString, soundTimerString)
            end

            victim:EmitSound(sounds[math.random(#sounds)])
        end)

        -- check health/give health + letting the owner move again with no godmode + deal damage + remove timers + deactivate lag compensation
        timer.Simple(self.StruggleLength, function() if check == 1 then success(victim, owner, animationTimerString, soundTimerString) end end)
        owner:LagCompensation(false)
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