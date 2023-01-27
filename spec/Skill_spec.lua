local Skill = require "Skill"

local function expected(category, icon, text)
    local file = string.format('[[File:Skill_%s_%s.png|55px]]', category, icon)
    local s = '<table style="vertical-align:middle; margin:0 auto;"><tr><td>%s</td><td>%s</td></tr></table>'
    return string.format(s, file, text)
end

local function testGenerator(title, text, option, category, icon)
    return function()
        assert.is_equal(expected(category, icon, text), Skill._main({ title, text, option }))
    end
end

setup(function()

end)

describe("Skill", function()
    describe("Passive", function()
        it("Check Vocal Passive",
            testGenerator(
                "Vocal 7%UP",
                "If: w/ Kogane<br/>Chance: 10%<br/>Maximum 1×",
                "No",
                "Passive",
                "VoUp"
            ))
    end)


    describe("Limit", function()

    end)

    describe("SpecifySkillIcon", function()
        it("Check Vocal Passive with specify icon with Live, Da",
            testGenerator(
                "Mental Dmg 20%CUT",
                "If: Star count ≥ 10<br/>Chance: 20%<br/>Maximum 1×",
                "Yes, Limit, Vi",
                'Limit', 'Vi'
            ))

        it("Check DmgCut with specify icon with Limit, Vi",
            testGenerator(
                "Mental Dmg 20%CUT",
                "If: Star count ≥ 10<br/>Chance: 20%<br/>Maximum 1×",
                "Yes, Limit, Vi",
                'Limit',
                'Vi'
            ))

        -- it("Check Vocal Live skill with specify icon with Passive, VoUpAttentionDown", function ()
        --     local title = "'''''Vocal Appeal IV'''''"
        --     local text = "'''''Vocal 2.5× Appeal'''''"
        --     local option = "No, Passive, VoUpAttentionDown"
        --     assert.is_equal(Skill.basicParser({title, option, text}), expected('Passive', 'VoUpAttentionDown', text))
        -- end)
    end)
end)
