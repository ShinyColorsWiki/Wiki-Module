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

        describe("Limit", function()
            it("Check Limit Increase with Da",
                testGenerator(
                    "Dance Limit UP '''(3☆)'''",
                    "Dance Limit +150",
                    "",
                    "Limit",
                    "Da"
                ))
        end)
    end)

    describe("Live", function()
        it("Check Pretty Sweet",
            testGenerator(
                "'''''Pretty Sweet'''''",
                -- luacheck: no max line length
                [['''''{{#tag:span|Vocal 3.5× Appeal|style="background-color:#ff7fdf"}}''''' /<br/>'''''{{#tag:span|Judge's Interest 50% DOWN|style="background-color:#9f87ff"}}'''''<br/>[3 turns] /<br/>'''''{{#tag:span|Judge's Interest 100% UP|style="background-color:#9f87ff"}}'''''<br/>[5 turns]<br/>'''Link:''' ''{{#tag:span|Vocal 3× Appeal|style="background-color:#ff7fdf"}}'']]
                ,
                "No",
                "Live",
                "Vo"
            ))

        it("Check Sora to Ao to Aitsu",
            testGenerator(
                "'''''Sora to Ao to Aitsu'''''",
                -- luacheck: no max line length
                [['''''{{#tag:span|Visual 2.5× Appeal<br/>to All Judges|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|Visual 10% UP|style="background-color:#ffbf27"}}''''' [3 turns] /<br/>'''''{{#tag:span|Visual 5% UP|style="background-color:#ffbf27"}}''''' [4 turns]<br/>'''Link:''' ''{{#tag:span|Visual 2× Appeal<br/>to All Judges|style="background-color:#ffbf27"}}'']]
                ,
                "No",
                "Live",
                "ViMulti"
            ))
    end)

    describe("SpecifySkillIcon", function()
        it("Check Vocal Passive with specify icon with Live, Da",
            testGenerator(
                "Mental Dmg 20%CUT",
                "If: Star count ≥ 10<br/>Chance: 20%<br/>Maximum 1×",
                "Yes, Limit, Vi",
                'Limit',
                'Vi'
            ))

        it("Check DmgCut with specify icon with Limit, Vi",
            testGenerator(
                "Mental Dmg 20%CUT",
                "If: Star count ≥ 10<br/>Chance: 20%<br/>Maximum 1×",
                "Yes, Limit, Vi",
                'Limit',
                'Vi'
            ))

        it("Check Vocal Live skill with specify icon with Passive, VoUpAttentionDown",
            testGenerator(
                "'''''Vocal Appeal IV'''''",
                "'''''Vocal 2.5× Appeal'''''",
                "No, Passive, VoUpAttentionDown",
                'Passive',
                'VoUpAttentionDown'
            ))
    end)
end)
