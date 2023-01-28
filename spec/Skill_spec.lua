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
    describe("Check Passive", function()
        -- luacheck: no max line length
        it("AllUp",
            testGenerator(
                [[{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 15% UP '''(1☆)''']]
                ,
                "If: Mental ≤ 74%<br/>Chance: 40%<br/>Maximum 1×",
                "",
                "Passive",
                "AllUp"
            ))

        it("VoUp",
            testGenerator(
                "Vocal 7%UP",
                "If: w/ Kogane<br/>Chance: 10%<br/>Maximum 1×",
                "No",
                "Passive",
                "VoUp"
            ))

        -- TODO: VoDown

        it("VoUpAttentionDown",
            testGenerator(
                [[Vocal 60% UP /<br/>{{#tag:span|Attention 50% DOWN|style="background-color:#9f87ff"}}  '''(1☆)''']],
                "If: Turn count ≤ 2<br/>Chance: 30%<br/>Maximum 1×",
                "",
                "Passive",
                "VoUpAttentionDown"
            ))

        it("VoUpAttentionUp",
            testGenerator(
                [[Vocal 80% UP /<br/>{{#tag:span|Attention 100% UP|style="background-color:#a787ff"}} '''(2☆)''']],
                "If: Turn count ≤ 5<br/>Chance: 20%<br/>Maximum 2×",
                "Yes",
                "Passive",
                "VoUpAttentionUp"
            ))

        it("VoUpDefenseDow",
            testGenerator(
                [[Vocal 40% UP /<br/>{{#tag:span|MentalDmg 20% UP|style="background-color:#3f87ff"}} '''(2☆)''']],
                "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                "yes",
                "Passive",
                "VoUpDefenseDown"
            ))

        it("VoUpGuard",
            testGenerator(
                [[Vocal 25% UP /<br/>{{#tag:span|MentalDmg 25% CUT|style="background-color:#ff9f1f"}} '''(2☆)''']],
                "If: Mental ≤ 24%<br/>Chance: 30%<br/>Maximum 1×",
                "Yes",
                "Passive",
                "VoUpGuard"
            ))

        it("VoUpHeal",
            testGenerator(
                [[Vocal 15% UP /<br/>{{#tag:span|Mental 10% Heal|style="background-color:#1fdf7f"}} '''(2☆)''']],
                "If: Turn count ≥ 6<br/>Chance: 40%<br/>Maximum 1×",
                "Yes",
                "Passive",
                "VoUpHeal"
            ))
    end)

    describe("Check Limit Increase", function()
        it("Da",
            testGenerator(
                "Dance Limit UP '''(3☆)'''",
                "Dance Limit +150",
                "",
                "Limit",
                "Da"
            ))
    end)

    describe("Check Live skill", function()
        -- luacheck: no max line length
        it("Pretty Sweet",
            testGenerator(
                "'''''Pretty Sweet'''''",
                [['''''{{#tag:span|Vocal 3.5× Appeal|style="background-color:#ff7fdf"}}''''' /<br/>'''''{{#tag:span|Judge's Interest 50% DOWN|style="background-color:#9f87ff"}}'''''<br/>[3 turns] /<br/>'''''{{#tag:span|Judge's Interest 100% UP|style="background-color:#9f87ff"}}'''''<br/>[5 turns]<br/>'''Link:''' ''{{#tag:span|Vocal 3× Appeal|style="background-color:#ff7fdf"}}'']]
                ,
                "No",
                "Live",
                "Vo"
            ))

        it("Sora to Ao to Aitsu",
            testGenerator(
                "'''''Sora to Ao to Aitsu'''''",
                [['''''{{#tag:span|Visual 2.5× Appeal<br/>to All Judges|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|Visual 10% UP|style="background-color:#ffbf27"}}''''' [3 turns] /<br/>'''''{{#tag:span|Visual 5% UP|style="background-color:#ffbf27"}}''''' [4 turns]<br/>'''Link:''' ''{{#tag:span|Visual 2× Appeal<br/>to All Judges|style="background-color:#ffbf27"}}'']]
                ,
                "No",
                "Live",
                "ViMulti"
            ))
    end)

    describe("CheckSpecifySkillIcon", function()
        it("Vocal Passive with specify icon with Live, Da",
            testGenerator(
                "Mental Dmg 20%CUT",
                "If: Star count ≥ 10<br/>Chance: 20%<br/>Maximum 1×",
                "Yes, Limit, Vi",
                'Limit',
                'Vi'
            ))

        it("DmgCut with specify icon with Limit, Vi",
            testGenerator(
                "Mental Dmg 20%CUT",
                "If: Star count ≥ 10<br/>Chance: 20%<br/>Maximum 1×",
                "Yes, Limit, Vi",
                'Limit',
                'Vi'
            ))

        it("Vocal Live skill with specify icon with Passive, VoUpAttentionDown",
            testGenerator(
                "'''''Vocal Appeal IV'''''",
                "'''''Vocal 2.5× Appeal'''''",
                "No, Passive, VoUpAttentionDown",
                'Passive',
                'VoUpAttentionDown'
            ))
    end)

    describe("Invalid handling", function()
        it("No or missing argument", function()
            assert.is_equal(Skill._main({}), "")
            assert.is_equal(Skill._main({ "", "" }), "")
            assert.is_equal(Skill._main({ "", nil, "" }), "")
        end)

        it("Failed to parsing", function()
            assert.is_equal(Skill._main({ "a", "b" }), "b")
        end)

        it("Try compat fix without type", testGenerator(
            "Vocal 7%UP",
            "If: w/ Kogane<br/>Chance: 10%<br/>Maximum 1×",
            ", Passive, DaUp,",
            "Passive",
            "DaUp"
        ))

        it("Try compat fix with type", testGenerator(
            "Vocal 7%UP",
            "If: w/ Kogane<br/>Chance: 10%<br/>Maximum 1×",
            ", Passive, DaUp, Yes",
            "Passive",
            "DaUp"
        ))

        it("Try fix with only specify skill icon", testGenerator(
            "Vocal 7%UP",
            "If: w/ Kogane<br/>Chance: 10%<br/>Maximum 1×",
            "Passive, DaUp",
            "Passive",
            "DaUp"
        ))

        it("Try fix with leftover", testGenerator(
            "Vocal 7%UP",
            "If: w/ Kogane<br/>Chance: 10%<br/>Maximum 1×",
            "Passive, DaUp,",
            "Passive",
            "DaUp"
        ))
    end)
end)
