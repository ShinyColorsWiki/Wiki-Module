--[[
    !! ### IMPORTANT ### !!
 This module code is hosted on GitHub due to code check and testing,
 And the changes made on wiki may be overwritten by bot any time.
 Please contact to #wiki-discussion on Discord or directly via GitHub.
 Github repository : https://github.com/ShinyColorsWiki/Wiki-Module
]]

--[[
 This is initial code. There's problem if (assumed) code spec is not matched.
]]

local p = {}

p.type = {
    [1] = "Produce",
    [2] = "Support"
}

p.rarity = {
    [1] = "R",
    [2] = "SR",
    [3] = "SSR",
}

p.character_code = {
    -- Illumination Stars
    [1]  = "Mano Sakuragi",
    [2]  = "Hiori Kazano",
    [3]  = "Meguru Hachimiya",
    -- L'Antica
    [4]  = "Kogane Tsukioka",
    [5]  = "Mamimi Tanaka",
    [6]  = "Sakuya Shirase",
    [7]  = "Yuika Mitsumine",
    [8]  = "Kiriko Yukoku",
    -- Afterschool Climax Girls
    [9]  = "Kaho Komiya",
    [10] = "Chiyoko Sonoda",
    [11] = "Juri Saijo",
    [12] = "Rinze Morino",
    [13] = "Natsuha Arisugawa",
    -- Alstroemeria
    [14] = "Amana Osaki",
    [15] = "Tenka Osaki",
    [16] = "Chiyuki Kuwayama",
    -- Straylight
    [17] = "Asahi Serizawa",
    [18] = "Fuyuko Mayuzumi",
    [19] = "Mei Izumi",
    -- noctchill
    [20] = "Toru Asakura",
    [21] = "Madoka Higuchi",
    [22] = "Koito Fukumaru",
    [23] = "Hinana Ichikawa",
    -- SHHis
    [24] = "Nichika Nanakusa",
    [25] = "Mikoto Aketa",
    -- CoMETIK
    [26] = "Luca Ikaruga",
    [27] = "Hana Suzuki",
    [28] = "Haruki Ikuta",
    -- Etc
    [90] = "Hazuki Nanakusa",
}

---@param s string string to trim
local function strim(s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function p.extractNumericOnString(str)
    return string.match(str, '%d+')
end

function p.splitCode(code)
    code = strim(code.args[1])
    return {
        tonumber(string.sub(code, 1, 1)), -- type
        tonumber(string.sub(code, 2, 2)), -- rarity
        tonumber(string.sub(code, 3, 4)), -- character
        tonumber(string.sub(code, 5, 7)) -- card number
    }
end

function p.getProduceInfo(arr)
    return {
        p.type[arr[1]],
        string.format("%d*", arr[2]),
        p.character_code[arr[3]], -- character
        arr[4] -- card number
    }
end

function p.getSupportInfo(arr)
    return {
        p.type[arr[1]],
        p.rarity[arr[2]], -- rarity
        p.character_code[arr[3]], -- character
        arr[4] -- card number
    }
end

function p.getProduceInfoFromCode(code)
    return p.getProduceInfo(p.splitCode(code))
end

function p.getSupportInfoFromCode(code)
    return p.getSupportInfo(p.splitCode(code))
end

function p.getInfoFromCode(code)
    local raw_data = p.splitCode(code)

    -- Produce card
    if raw_data[1] == 1 then
        return p.getProduceInfo(raw_data)
    end

    -- Support card
    return p.getSupportInfo(raw_data)
end

function p.getTypeFromCode(code)
    return p.getInfoFromCode(code)[1]
end

function p.getRarityFromCode(code)
    return p.getInfoFromCode(code)[2]
end

function p.getCharacterFromCode(code)
    return p.getInfoFromCode(code)[3]
end

function p.getCardNumberFromCode(code)
    return p.getInfoFromCode(code)[4]
end

return p
