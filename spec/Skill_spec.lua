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

        describe("Vo", function()
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
                    [[Vocal 60% UP /<br/>{{#tag:span|Attention 50% DOWN|style="background-color:#9f87ff"}}  '''(1☆)''']]
                    ,
                    "If: Turn count ≤ 2<br/>Chance: 30%<br/>Maximum 1×",
                    "",
                    "Passive",
                    "VoUpAttentionDown"
                ))

            it("VoUpAttentionUp",
                testGenerator(
                    [[Vocal 80% UP /<br/>{{#tag:span|Attention 100% UP|style="background-color:#a787ff"}} '''(2☆)''']]
                    ,
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
                    [[Vocal 25% UP /<br/>{{#tag:span|MentalDmg 25% CUT|style="background-color:#ff9f1f"}} '''(2☆)''']]
                    ,
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

        describe("Vo & Da", function()
            it("VoDaUp",
                testGenerator(
                    [[{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} 20% UP '''(2☆)''']]
                    ,
                    "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "VoDaUp"
                ))

            -- TODO: VoDaUpAttentionDown

            it("VoDaUpAttentionUp",
                testGenerator(
                    [[{{{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} 65% UP /<br/> {{#tag:span|Attention 30% UP|style="background-color:#9f87ff"}} '''(2☆)''']]
                    ,
                    "If: [[File:Live Status AttentionUp.png]]<br/>Chance: 20%<br/>Maximum 2×",
                    "Yes",
                    "Passive",
                    "VoDaUpAttentionUp"
                ))
        end)


        describe("Vo & Vi", function()
            it("VoViUp",
                testGenerator(
                    [[{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 20% UP '''(2☆)''']]
                    ,
                    "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "VoViUp"
                ))

            it("VoViUpAttentionDown",
                testGenerator(
                    [[{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 33% UP /<br/> {{#tag:span|Attention 20% DOWN|style="background-color:#9f87ff"}} '''(2☆)''']]
                    ,
                    "If: Mental ≤ 49%<br/>Chance: 33%<br/>Maximum 1×",
                    "No",
                    "Passive",
                    "VoViUpAttentionDown"
                ))

            it("VoViUpAttentionUp",
                testGenerator(
                    [[{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 45% UP /<br/>{{#tag:span|Attention 40% UP|style="background-color:#a787ff"}} '''(2☆)''']]
                    ,
                    "If: [[File:Live Status ViUp.png]]<br/>Chance: 20%<br/>Maximum 3×",
                    "Yes",
                    "Passive",
                    "VoViUpAttentionUp"
                ))
        end)

        describe("Da", function()
            it("DaUp",
                testGenerator(
                    "Dance 3% UP",
                    "If: Turn count ≥ 5<br/>Chance: 20%<br/>Maximum 1×",
                    "No",
                    "Passive",
                    "DaUp"
                ))

            -- TODO: DaDown

            it("DaUpAttentionDown",
                testGenerator(
                    [[Dance 30% UP /<br/>{{#tag:span|Attention 20% DOWN|style="background-color:#9f87ff"}}'''(2☆)''']]
                    ,
                    "If: Mental ≤ 49%<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "DaUpAttentionDown"
                ))

            it("DaUpAttentionUp",
                testGenerator(
                    [[Dance 40% UP /<br/>{{#tag:span|Attention 40% UP|style="background-color:#a787ff"}}''' (2☆)''']]
                    ,
                    "If: Turn count ≤ 5<br/>Chance: 20%<br/>Maximum 2×",
                    "Yes",
                    "Passive",
                    "DaUpAttentionUp"
                ))

            it("DaUpDefenseDown",
                testGenerator(
                    [[Dance 40% UP /<br/>{{#tag:span|MentalDmg 20% UP|style="background-color:#3f87ff"}} '''(2☆)''']],
                    "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "DaUpDefenseDown"
                ))

            it("DaUpGuard",
                testGenerator(
                    [[Dance 33% UP /<br/>{{#tag:span|MentalDmg 33% CUT|style="background-color:#ff9f1f"}} '''(2☆)''']]
                    ,
                    "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "DaUpGuard"
                ))

            it("DaUpHeal",
                testGenerator(
                    [[Dance 60% UP /<br/>{{#tag:span|Mental 5% Heal|style="background-color:#1fdf7f"}} '''(2☆)''']],
                    "If: Mental ≥ 80%<br/>Chance: 20%<br/>Maximum 2×",
                    "Yes",
                    "Passive",
                    "DaUpHeal"
                ))
        end)

        describe("Da & Vi", function()
            it("DaViUp",
                testGenerator(
                    [[{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 20% UP '''(2☆)''']]
                    ,
                    "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "DaViUp"
                ))

            it("DaViUpAttentionDown",
                testGenerator(
                    [[{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 30% UP /<br/>{{#tag:span|Attention 20% DOWN|style="background-color:#9f87ff"}} '''(2☆)''']]
                    ,
                    "If: Mental ≤ 49%<br/>Chance: 20%<br/>Maximum 2×",
                    "Yes",
                    "Passive",
                    "DaViUpAttentionDown"
                ))

            it("DaViUpAttentionUp",
                testGenerator(
                    [[{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 75% UP /<br/>{{#tag:span|Attention 30% UP|style="background-color:#9f87ff"}} '''(2☆)''']]
                    ,
                    "If: Turn count ≥ 3<br/>Madoka in Skill History<br/>Chance: 20%<br/>Maximum 2×",
                    "Yes",
                    "Passive",
                    "DaViUpAttentionUp"
                ))
        end)

        describe("Vi", function()
            it("ViUp",
                testGenerator(
                    "Visual 7% UP",
                    "If: w/ Natsuha<br/>Chance: 10%<br/>Maximum 1×",
                    "No",
                    "Passive",
                    "ViUp"
                ))

            -- TODO: ViDown

            it("ViUpAttentionDown",
                testGenerator(
                    [[Visual 30% UP /<br/>{{#tag:span|Attention 50% DOWN|style="background-color:#9f87ff"}} '''(2☆)''']]
                    ,
                    "If: Mental ≤ 30%<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "ViUpAttentionDown"
                ))

            it("ViUpAttentionUp",
                testGenerator(
                    [[Visual 70% UP /<br/>{{#tag:span|Attention 50% UP|style="background-color:#9f87ff"}} '''(2☆)''']]
                    ,
                    "If: [[File:Live Status ReactionUp.png]]<br/>Chance: 10%<br/>Maximum 3×",
                    "Yes",
                    "Passive",
                    "ViUpAttentionUp"
                ))

            it("ViUpDefenseDown",
                testGenerator(
                    [[Visual 40% UP /<br/>'''''{{#tag:span|MentalDmg 20% UP|style="background-color:#3f87ff"}}''''' '''(2☆)''']]
                    ,
                    "If: Turn count ≤ 3<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "ViUpDefenseDown"
                ))

            it("ViUpGuard",
                testGenerator(
                    [[Visual 90% UP /<br/>{{#tag:span|MentalDmg 40% CUT|style="background-color:#ff9f1f"}} '''(2☆)''']]
                    ,
                    "If: Mental ≥ 95%<br/>Chance: 20%<br/>Maximum 3×",
                    "Yes",
                    "Passive",
                    "ViUpGuard"
                ))

            it("ViUpHeal",
                testGenerator(
                    [[Visual 70% UP /<br/>{{#tag:span|Mental 10% Heal|style="background-color:#1fdf7f"}} '''(4☆)''']],
                    "If: w/ 1 or 2 Alstroemeria<br/>Chance: 15%<br/>Maximum 2×",
                    "Yes",
                    "Passive",
                    "ViUpHeal"
                ))
        end)

        describe("Misc", function()
            it("AttentionDown",
                testGenerator(
                    "Attention 30% DOWN '''(2☆)'''",
                    "If: Mental ≤ 50%<br/>Chance: 30%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "AttentionDown"
                ))

            it("Heal",
                testGenerator(
                    "Mental 40% Heal '''(2☆)'''",
                    "If: Turn count ≥ 6<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "Heal"
                ))

            -- TODO: Regen, Revive, DefenseDown

            it("Guard",
                testGenerator(
                    "MentalDmg 40% CUT '''(2☆)'''",
                    "If: Turn count ≥ 6<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "Guard"
                ))

            it("GuardHeal",
                testGenerator(
                    [[{{#tag:span|MentalDmg 20% CUT|style="background-color:#ff9f1f"}} /<br/>{{#tag:span|Mental 5% Heal|style="background-color:#1fdf7f"}} '''(2☆)''']]
                    ,
                    "|If: Turn count ≥ 6<br/>Chance: 40%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "GuardHeal"
                ))

            it("Gauge",
                testGenerator(
                    "Memory Gauge 50% UP '''(2☆)'''",
                    "If: Center Position<br/>Chance: 60%<br/>Maximum 1×",
                    "Yes",
                    "Passive",
                    "Gauge"
                ))
        end)

        describe("Limit Increase", function()
            it("Vo",
                testGenerator(
                    "Vocal Limit UP '''(3☆)'''",
                    "Vocal Limit +50",
                    "",
                    "Limit",
                    "Vo"
                ))

            it("VoDa",
                testGenerator(
                    [[{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} Limit UP]]
                    ,
                    "Vocal&Dance<br/>Limit +25",
                    "",
                    "Limit",
                    "VoDa"
                ))

            it("VoVi",
                testGenerator(
                    [[{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} Limit UP '''(3☆)''']]
                    ,
                    "Vocal & Visual<br/>Limit +100",
                    "No",
                    "Limit",
                    "VoVi"
                ))

            it("Da",
                testGenerator(
                    "Dance Limit UP '''(3☆)'''",
                    "Dance Limit +150",
                    "",
                    "Limit",
                    "Da"
                ))

            it("DaVi",
                testGenerator(
                    [[{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} Limit UP]]
                    ,
                    "Dance & Visual Limit +100",
                    "",
                    "Limit",
                    "DaVi"
                ))

            it("Vi",
                testGenerator(
                    "Visual Limit UP '''(3☆)'''",
                    "Visual Limit +150",
                    "",
                    "Limit",
                    "Vi"
                ))

            it("Mental",
                testGenerator(
                    "Mental Limit UP '''(3☆)'''",
                    "Mental Limit +100",
                    "",
                    "Limit",
                    "Mental"
                ))
        end)
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
