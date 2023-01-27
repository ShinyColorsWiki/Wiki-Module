local p = {}

local passive = {
    limit = false,
    vocal = false,
    dance = false,
    visual = false,
    mental = false,
    up = false,
    down = false,
    cut = false,
    heal = false,
    regen = false,
    revive = false,
    attention = false,
    dmg = false,
    gauge = false,
    excellent = false
}

local live = {
    vocal = false,
    dance = false,
    visual = false,
    mental = false,
    up = false,
    down = false,
    cut = false,
    heal = false,
    regen = false,
    attention = false,
    interest = false,
    influence = false,
    dmg = false,
    appeal = false,
    all_judges = false,
    lower_mental = false,
    higher_mental = false,
    memory_gauge = false,
    instantly_satisfy = false
}

p.text = false
p.icon = false
p.category = false



function p.basicParser(args)
    -- Check invalid argument
    if args[1] ~= nil and string.len(p.strim(args[1])) < 1 then
        return false
    end

    if args[2] ~= nil and string.len(p.strim(args[2])) < 1 then
        return false
    end

    local title = p.strim(args[1])
    p.text = p.strim(args[2])

    -- Additional (SpecifySkillIcon compat)
    if args[3] ~= nil and string.len(p.strim(args[3])) > 4 then
        local type, category, icon = p.strim(args[3]):match("([^,]+),([^,]+),([^,]+)")

        -- Invalid syntax but trying to fix.
        type = p.strim(type)
        if not (type == "Yes"
            or type == "Niji"
            or type == "No"
            or type == ""-- invalid by compat
            ) then
            icon = type
            category = icon
        end

        p.icon = p.strim(icon)
        p.category = p.strim(category)
        return true
    end

    local f = title:find("'''''")
    if f == nil or f < 6 then
        passive:parser(title)
    else
        --live:parser(text)
    end

    return true
end

function p._main(args)
    if p.basicParser(args) then
        return p.render()
    end
    return ""
end

function p.render()
    if p.icon then
        local file = string.format('[[File:Skill_%s_%s.png|55px]]', p.category, p.icon)
        local s = '<table style="vertical-align:middle; margin:0 auto;"><tr><td>%s</td><td>%s</td></tr></table>'
        return string.format(s, file, p.text)
    else
        return p.text
    end
end

function p.strim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

-- Passive skill parser
---@param text string The parsing value
function passive:parser(text)
    p.category = "Passive"
    self:check(text:lower())
    self:parse()
end

-- Passive type checker
---@param text string The parsing valu
function passive:check(text)
    -- FIXME: revive?
    local typeList = {
        limit = 'limit',
        vocal = 'vocal',
        dance = 'dance',
        visual = 'visual',
        mental = 'mental',
        up = 'up',
        down = 'down',
        cut = 'cut',
        heal = 'heal',
        regen = 'regen',
        attention = 'attention',
        dmg = 'dmg',
        gauge = 'memory gauge',
        excellent = 'excellent'
    };

    for k, v in pairs(typeList) do
        if text:find(v) ~= nil then
            self[k] = true
        end
    end
end

function passive:parse()
    -- All up
    if self.vocal and self.dance and self.visual and self.up and not self.down then
        p.icon = "AllUp"
    end

    -- Vo(s)
    if self.vocal then
        -- Vo only
        if not self.dance and not self.visual then
            -- contains Up
            if self.up then
                -- VoUp
                if not self.down then
                    p.icon = "VoUp"
                end

                -- Attention
                if self.attention then
                    if self.down then
                        p.icon = "VoUpAttentionDown"
                    else
                        p.icon = "VoUpAttentionUp"
                    end
                end

                if self.dmg and not self.down then
                    p.icon = "VoUpDefenseDown"
                end
            end

            if not self.up and self.down then
                p.icon = "VoDown"
            end

            if self.cut and self.dmg then
                p.icon = "VoUpGuard"
            end

            if self.heal then
                p.icon = "VoUpHeal"
            end
        end

        -- Vo & Da
        if self.dance and not self.visual then
            -- Note: all of 2 types skills are contains Up as of now. just left for next uses
            if self.up then
                -- Attention
                if self.attention then
                    if self.down then
                        p.icon = "VoDaUpAttentionDown"
                    else
                        p.icon = "VoDaUpAttentionUp"
                    end
                end
            end

            if not self.up and self.down then
                p.icon = "VoDaDown"
            end
        end

        -- Vo & Vi
        if not self.dance and self.visual then
            -- Note: all of 2 types skills are contains Up as of now. just left for next uses
            if self.up then
                -- Attention
                if self.attention then
                    if self.down then
                        p.icon = "VoViUpAttentionDown"
                    else
                        p.icon = "VoViUpAttentionUp"
                    end
                end
            end

            if not self.up and self.down then
                p.icon = "VoViDown"
            end
        end
    end

    -- Da(s)
    if self.dance then
        -- da only
        if not self.vocal and not self.visual then
            -- contains Up
            if self.up then

                if not self.down then
                    p.icon = "DaUp"
                end

                -- Attention
                if self.attention then
                    if self.down then
                        p.icon = "DaUpAttentionDown"
                    else
                        p.icon = "DaUpAttentionUp"
                    end
                end

                if self.dmg and not self.down then
                    p.icon = "DaUpDefenseDown"
                end
            end

            if not self.up and self.down then
                p.icon = "DaDown"
            end

            if self.cut and self.dmg then
                p.icon = "DaUpGuard"
            end

            if self.heal then
                p.icon = "DaUpHeal"
            end
        end

        -- Da & Vi
        if not self.vocal and self.visual then
            -- Note: all of 2 types skills are contains Up as of now. just left for next uses
            if self.up then
                -- Attention
                if self.attention then
                    if self.down then
                        p.icon = "DaViUpAttentionDown"
                    else
                        p.icon = "DaViUpAttentionUp"
                    end
                end
            end

            if not self.up and self.down then
                p.icon = "DaViDown"
            end
        end
    end

    -- Vi
    if not self.vocal and not self.dance and self.visual then
        -- contains Up
        if self.up then
            if not self.down then
                p.icon = "ViUp"
            end

            -- Attention
            if self.attention then
                if self.down then
                    p.icon = "ViUpAttentionDown"
                else
                    p.icon = "ViUpAttentionUp"
                end
            end

            if self.dmg and not self.down then
                p.icon = "ViUpDefenseDown"
            end
        end

        if not self.up and self.down then
            p.icon = "ViDown"
        end

        if self.cut and self.dmg then
            p.icon = "ViUpGuard"
        end

        if self.heal then
            p.icon = "ViUpHeal"
        end
    end

    -- Misc
    if not self.vocal and not self.dance and not self.visual then

        if not self.down then
            if self.attention and not self.up then
                p.icon = "AttentionDown"
            end

            if not self.cut then
                if self.heal then
                    p.icon = "Heal"
                end

                if self.regen then
                    p.icon = "Regen"
                end

                if self.revive then
                    p.icon = "Revive"
                end
            end
        end

        if self.dmg then
            if self.down and not self.cut then
                p.icon = "DefenseDown"
            end

            if not self.down and self.cut then
                p.icon = "Guard"

                if self.heal then
                    p.icon = "GuardHeal"
                end
            end
        end

        if self.gauge then
            p.icon = "Gauge"
        end
    end

    -- Limit Increase
    if self.limit then
        p.category = "Limit"

        if self.vocal then
            if not self.dance and not self.visual then
                p.icon = "Vo"
            end

            if self.dance and not self.visual then
                p.icon = "VoDa"
            end

            if not self.dance and self.visual then
                p.icon = "VoVi"
            end
        else
            if self.dance then
                if not self.visual then
                    p.icon = "Da"
                else
                    p.icon = "DaVi"
                end
            else if self.visual then
                    p.icon = "Vi"
                end
            end

            if self.mental then
                p.icon = "Mental"
            end
        end
    end
    -- not checked: ReviveOk
end

return p
