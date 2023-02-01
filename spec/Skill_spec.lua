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

        -- All
        it("[All] Ha♡to-felt Gift",
            testGenerator(
                "'''''Ha♡to-felt Gift'''''",
                [['''''{{#tag:span|Visual 2.5× Appeal|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} 1.5× Appeal|style="background-color:#dfdfdf"}}''''' /<br/>'''''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 5% UP|style="background-color:#dfdfdf"}}''''' [5 turns]<br/>'''Link:''' ''{{#tag:span|Memory Gauge 10% UP|style="background-color:#9f87ff"}}'']]
                ,
                "",
                "Live",
                "All"
            ))

        it("[AllUp] Sakkaku Darlin",
            testGenerator(
                "'''''Sakkaku Darlin'''''",
                [['''''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 40% UP|style="background-color:#dfdfdf"}}'''''<br/>[4 turns] /<br/>'''''{{#tag:span|MentalDmg 50% UP|style="background-color:#3f87ff"}}''''' [4 turns] <br/>'''Link:''' ''{{#tag:span|Attention 30% DOWN|style="background-color:#9f87ff"}}'']]
                ,
                "",
                "Live",
                "AllUp"
            ))

        it("[AllMulti] Kyun♡Kome",
            testGenerator(
                "'''''Kyun♡Kome'''''",
                [['''''{{#tag:span|Visual 2.5× Appeal<br/>to all Judges|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} 0.5× Appeal|style="background-color:#dfdfdf"}}''''' /<br/>'''''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}}<br/>10% UP|style="background-color:#dfdfdf"}}''''' [3 turns]<br/>'''Link:''' ''{{#tag:span|Visual 1.5× Appeal<br/>to all Judges|style="background-color:#ffbf27"}}'']]
                ,
                "",
                "Live",
                "AllMulti"
            ))

        -- Vo
        it("[Vo] Pretty Sweet",
            testGenerator(
                "'''''Pretty Sweet'''''",
                [['''''{{#tag:span|Vocal 3.5× Appeal|style="background-color:#ff7fdf"}}''''' /<br/>'''''{{#tag:span|Judge's Interest 50% DOWN|style="background-color:#9f87ff"}}'''''<br/>[3 turns] /<br/>'''''{{#tag:span|Judge's Interest 100% UP|style="background-color:#9f87ff"}}'''''<br/>[5 turns]<br/>'''Link:''' ''{{#tag:span|Vocal 3× Appeal|style="background-color:#ff7fdf"}}'']]
                ,
                "No",
                "Live",
                "Vo"
            ))

        it("[VoMulti] Tobikkiri Ginger",
            testGenerator(
                "'''''Tobikkiri Ginger'''''",
                [['''''{{#tag:span|Vocal 3× Appeal<br/>to all Judges|style="background-color:#ff7fdf"}}''''' /<br/>'''''{{#tag:span|Vocal 30% UP|style="background-color:#ff7fdf"}}''''' [4 turns] /<br/>'''''{{#tag:span|MentalDmg 50% UP|style="background-color:#3f87ff"}}''''' [1 turn]<br/>'''Link:''' ''{{#tag:span|Vocal 1.5× Appeal|style="background-color:#ff7fdf"}}'']]
                ,
                "",
                "Live",
                "VoMulti"
            ))

        -- TODO: VoUp (No pure VoUp found)

        it("[VoHighmental] Spencer-ke no Nichijou (4☆)",
            testGenerator(
                "'''''Spencer-ke no Nichijou''''' '''(4☆)'''''",
                [['''''{{#tag:span|Vocal 0.8~4× Appeal|style="background-color:#ff7fdf"}}'''''<br/>[effect UP at higher Mental] /<br/>'''''{{#tag:span|MentalDmg 20% CUT|style="background-color:#ff9f1f"}}''''' [2 turns]|]]
                ,
                "Yes",
                "Live",
                "VoHighmental"
            ))

        it("[VoLowmental] Fureai, Omoiai+ (4☆)",
            testGenerator(
                "'''''Fureai, Omoiai+''''' '''(4☆)'''",
                [['''''{{#tag:span|Vocal 1~5× Appeal|style="background-color:#ff7fdf"}}'''''<br/>[effect UP at lower Mental]<br/>'''Link:''' ''{{#tag:span|Vocal 150% UP|style="background-color:#ff7fdf"}}'' [4 turns]|]]
                ,
                "",
                "Live",
                "VoLowmental"
            ))

        it("[VoMelancholy] Koufuku no Rhythm",
            testGenerator(
                "'''''Koufuku no Rhythm'''''",
                [['''''{{#tag:span|Vocal 3.5× Appeal|style="background-color:#ff7fdf"}}''''' /<br/>'''''{{#tag:span|Melancholy 10% to All Units|style="background-color:#9f87ff"}}'''''<br/>[3 turns]<br/>'''Link:''' ''{{#tag:span|MentalDmg 20% CUT|style="background-color:#ff9f1f"}}''<br/>[5 turns]|]]
                ,
                "",
                "Live",
                "VoMelancholy"
            ))

        -- FIXME: THIS
        it("[VoRevive] Nana Rinbu+ (4☆) [FIXME: NOT_SAME_AS_GAME]",
            testGenerator(
                "'''''Nana Rinbu+''''' '''(4☆)'''",
                [['''''{{#tag:span|Vocal 160% UP|style="background-color:#ff7fdf"}}''''' [5 turns] /<br/>'''''{{#tag:span|Mental 51% Auto-Revive|style="background-color:#1fdf7f"}}'''''<br/>[5 turns]<br/>'''Link:''' ''{{#tag:span|Vocal 3× Appeal|style="background-color:#ff7fdf"}}'']]
                ,
                "",
                "Live",
                "VoRevive"
            ))

        -- Vo & Da
        it("[VoDa] Hibi o Tsumugu Inverno",
            testGenerator(
                "'''''Hibi o Tsumugu Inverno'''''",
                [['''''{{#tag:span|Vocal 2.5× Appeal|style="background-color:#ff7fdf"}}''''' /<br/>'''''{{#tag:span|Dance 1.5× Appeal|style="background-color:#7fbfff"}}''''' <br/>'''Link:''' ''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} 40% UP|style="background-color:#dfdfdf"}}''<br/>[5 Turns]|]],
                "",
                "Live",
                "VoDa"
            ))

        it("[VoDaMulti] CHILLY+ (3☆)",
            testGenerator(
                "'''''CHILLY+''''' '''(3☆)'''",
                [['''''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Dance|style="background-color:#7fbfff"}} 2× Appeal<br/>to All Judges|style="background-color:#dfdfdf"}}'''''<br/>'''Link:''' ''{{#tag:span|Increase Nichika Appeal<br/>by 1×|style="background-color:#dfdfdf"}}'' [4 turns]|]],
                "",
                "Live",
                "VoDaMulti"
            ))

        -- TODO: VoDaUp

        -- Vo & Vi
        it("[VoVi] Sora o Hane",
            testGenerator(
                [['''''{{#tag:span|Sora o|style="background-color:#ffbf27"}}{{#tag:span| Hane|style="background-color:#ff7fdf"}}''''']],
                [[|'''''{{#tag:span|Visual 2.5× Appeal|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|Vocal 1.5× Appeal|style="background-color:#ff7fdf"}}'''''<br/>'''Link:''' ''{{#tag:span|{{#tag:span|Vocal|style="background-color:#ff7fdf"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 40% UP|style="background-color:#dfdfdf"}}''<br/>[5 turns]|]],
                "",
                "Live",
                "VoVi"
            ))

        -- TODO: VoViMulti, VoViUp

        -- Da(s)
        it("[Da] Rinze Kaden (4☆)",
            testGenerator(
                "'''''Rinze Kaden+''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance 1.1~5.5× Appeal|style="background-color:#7fbfff"}}'''''<br/>[effect UP at higher Memory Gauge]<br/>'''''{{#tag:span|Memory Gauge 30% DOWN|style="background-color:#9f87ff"}}'''''<br/>'''Link:''' ''{{#tag:span|Dance 3× Appeal|style="background-color:#7fbfff"}}'']]
                ,
                "No",
                "Live",
                "Da"
            ))

        it("[DaMulti] Harari Hirari Musubu (4☆)",
            testGenerator(
                "'''''Harari Hirari Musubu''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance 4× Appeal<br/>to all Judges|style="background-color:#7fbfff"}}''''' /<br/>'''''{{#tag:span|{{#tag:span|Reduce own Mental by 25%|style="background-color:#ff7f7f"}}&<br/>{{#tag:span|Dance Maximum 180% UP [3 turns]|style="background-color:#7fbfff"}}|style="background-color:#dfdfdf"}}'''''<br/>[effect UP at higher Reduction]<br/>'''{{#tag:span|Plus:|style="background-color:#DF78FF"}}''' [If: w/ L'Antica & Mental ≤ 49%]<br/>''{{#tag:span|Dance 1× Appeal to all Judges|style="background-color:#7fbfff"}}'']],
                "",
                "Live",
                "DaMulti"
            ))

        it("[DaUp] Be~♡bop Kaigan",
            testGenerator(
                "'''''Be~♡bop Kaigan'''''",
                [['''''FAST {{#tag:span|MentalDmg 50% UP|style="background-color:#3f87ff"}}''''' [1 turn] /<br/>'''''{{#tag:span|Dance 100% UP|style="background-color:#7fbfff"}}''''' [3 turns]<br/>'''Link:''' ''{{#tag:span|Mental 20% Heal|style="background-color:#1fdf7f"}}'']],
                "",
                "Live",
                "DaUp"
            ))

        it("[DaHighmental] Let's☆Shinobi Ashi! (4☆)",
            testGenerator(
                "'''''Let's☆Shinobi Ashi!''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance Maximum 4× Appeal|style="background-color:#7fbfff"}}'''''<br/>[effect UP at higher Mental] /<br/>'''''{{#tag:span|Dance 35% UP|style="background-color:#7fbfff"}}''''' [3 turns]|]],
                "Yes",
                "Live",
                "DaHighmental"
            ))

        it("[DaLowmental] RESONANCE (4☆)",
            testGenerator(
                "'''''RESONANCE''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance Maximum 6× Appeal|style="background-color:#7fbfff"}}''''' /<br/>[effect UP at lower Mental]|]],
                "",
                "Live",
                "DaLowmental"
            ))

        it("[DaMelancholy] Koufuku no Rhythm+ (4☆)",
            testGenerator(
                "'''''Koufuku no Rhythm+''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance 5× Appeal|style="background-color:#7fbfff"}}''''' /<br/>'''''{{#tag:span|Melancholy 10% to All Units|style="background-color:#9f87ff"}}'''''<br/>[3 turns]<br/>'''Link:''' ''{{#tag:span|MentalDmg 20% CUT|style="background-color:#ff9f1f"}}''<br/>[5 turns]|]],
                "",
                "Live",
                "DaMelancholy"
            ))

        it("[DaRevive] Kiri Ne Sansan+ (4☆)",
            testGenerator(
                "'''''Kiri Ne Sansan+''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance 3× Appeal|style="background-color:#7fbfff"}}''''' /<br/>'''''{{#tag:span|Mental 20% Auto-Revive|style="background-color:#1fdf7f"}}''''' [2 turns]<br/>'''Link:''' ''{{#tag:span|Dance 150% UP|style="background-color:#7fbfff"}}'' [4 turns]|]],
                "",
                "Live",
                "DaRevive"
            ))

        -- Da & Vi
        it("[DaVi] Ekisenjou no Nichijou (4☆)",
            testGenerator(
                "'''''Ekisenjou no Nichijou''''' '''(4☆)'''",
                [['''''{{#tag:span|{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 2× Appeal|style="background-color:#dfdfdf"}}''''' /<br/>'''''{{#tag:span|{{#tag:span|Dance|style="background-color:#7fbfff"}}&{{#tag:span|Visual|style="background-color:#ffbf27"}} 20% UP|style="background-color:#dfdfdf"}}'''''<br/>[3 turns]|]],
                "",
                "Live",
                "DaVi"
            ))

        -- TODO: DaViMulti, DaViup

        -- Vi
        it("[Vi] Visual Appeal IV",
            testGenerator(
                "'''''Visual Appeal IV'''''",
                [['''''Visual 2.5× Appeal''''']]
                ,
                "No",
                "Live",
                "Vi"
            ))

        it("[ViMulti] Sora to Ao to Aitsu",
            testGenerator(
                "'''''Sora to Ao to Aitsu'''''",
                [['''''{{#tag:span|Visual 2.5× Appeal<br/>to All Judges|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|Visual 10% UP|style="background-color:#ffbf27"}}''''' [3 turns] /<br/>'''''{{#tag:span|Visual 5% UP|style="background-color:#ffbf27"}}''''' [4 turns]<br/>'''Link:''' ''{{#tag:span|Visual 2× Appeal<br/>to All Judges|style="background-color:#ffbf27"}}'']]
                ,
                "No",
                "Live",
                "ViMulti"
            ))

        it("[ViUp] Be~♡bop Kaigan+ (4☆)",
            testGenerator(
                "'''''Be~♡bop Kaigan+''''' '''(4☆)'''",
                [['''''FAST {{#tag:span|MentalDmg 70% UP|style="background-color:#3f87ff"}}''''' [1 turn] /<br/>'''''{{#tag:span|Visual 150% UP|style="background-color:#ffbf27"}}''''' [3 turns]<br/>'''Link:''' ''{{#tag:span|Mental 20% Heal|style="background-color:#1fdf7f"}}'']],
                "",
                "Live",
                "ViUp"
            ))

        it("[ViHighmental] Akizora to Kouyou",
            testGenerator(
                "'''''Akizora to Kouyou'''''",
                [['''''{{#tag:span|Visual 0.7~3.5× Appeal|style="background-color:#ffbf27"}}''''' <br/>[effect UP at higher Mental] /<br/>'''''{{#tag:span|Visual 25% UP|style="background-color:#ffbf27"}}''''' [5 turns]<br/>'''Link:''' ''{{#tag:span|Visual 80% UP|style="background-color:#ffbf27"}}'' [4 turns]|]],
                "Yes",
                "Live",
                "ViHighmental"
            ))

        it("[ViLowmental] 1/60 NaturalHeart+ (4☆)",
            testGenerator(
                "'''''1/60 NaturalHeart+''''' '''(4☆)'''",
                [['''''{{#tag:span|Visual 1.2~6× Appeal|style="background-color:#ffbf27"}}'''''<br/>[effect UP at lower Mental]<br/>'''''{{#tag:span|Visual 2× Appeal<br/>to all Judges|style="background-color:#ffbf27"}}'''''<br/>'''Link:''' ''{{#tag:span|Visual 3× Appeal|style="background-color:#ffbf27"}}'']],
                "",
                "Live",
                "ViLowmental"
            ))

        it("[ViMelancholy] Tricky Night+",
            testGenerator(
                "'''''Tricky Night'''''",
                [['''''{{#tag:span|Visual 3× Appeal|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|Melancholy 5% to Rivals|style="background-color:#9f87ff"}}''''' [3 turns]<br/>'''Link:''' ''{{#tag:span|Visual 3× Appeal|style="background-color:#ffbf27"}}'']],
                "",
                "Live",
                "ViMelancholy"
            ))

        it("[ViRevive] Kiri Ne Sansan+ (4☆)",
            testGenerator(
                "'''''Kiri Ne Sansan+''''' '''(4☆)'''",
                [[|'''''{{#tag:span|Visual 4.5× Appeal|style="background-color:#ffbf27"}}''''' /<br/>'''''{{#tag:span|Mental 30% Auto-Revive|style="background-color:#1fdf7f"}}''''' [2 turns]<br/>'''Link:''' ''{{#tag:span|Visual 150% UP|style="background-color:#ffbf27"}}'' [4 turns]|]],
                "",
                "Live",
                "ViRevive"
            ))

        -- Misc
        it("[Vi] Visual Appeal IV",
            testGenerator(
                "'''''Visual Appeal IV'''''",
                [['''''Visual 2.5× Appeal''''']]
                ,
                "No",
                "Live",
                "Vi"
            ))

        it("[Onehit] Joujou Kinga (4☆)",
            testGenerator(
                "'''''Joujou Kinga''''' '''(4☆)'''",
                [['''''{{#tag:span|Dance 2× Appeal|style="background-color:#7fbfff"}}''''' /<br/>'''''{{#tag:span|Very rare (2%) chance<br/>to instantly satisfy Judge|style="background-color:#9f87ff"}}''''']]
                ,
                "No",
                "Live",
                "Onehit"
            ))

        it("[Excellent] Long Short Time! (4☆)",
            testGenerator(
                "'''''Long Short Time!''''' '''(4☆)'''",
                [['''''{{#tag:span|Excellent 3.5× Appeal|style="background-color:#dfdfdf"}}''''' /<br/>'''''{{#tag:span|Attention 20% UP|style="background-color:#a787ff"}}''''' [4 turns]|]]
                ,
                "No",
                "Live",
                "Excellent"
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

    describe("[Compat] descriptionParser", function()
        local function c(x)
            return { args = { x } }
        end

        it("Yes", function()
            assert.is_equal("Yes", Skill.descriptionParser(c("Yes, Live, Allup")))
        end)

        it("No", function()
            assert.is_equal("No", Skill.descriptionParser(c("No, Live, Allup")))
        end)

        it("Niji", function()
            assert.is_equal("Niji", Skill.descriptionParser(c("Niji, Live, Allup")))
        end)

        it("broken", function()
            assert.is_equal("No", Skill.descriptionParser(c("Nasdf")))
        end)

        it("empty", function()
            assert.is_equal("No", Skill.descriptionParser(c("")))
        end)
    end)
end)
