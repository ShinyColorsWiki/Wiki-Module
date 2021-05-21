local CardCode = require "CardCode"


local function code(code)
    return { args = { code} }
end

setup(function()

end)

describe("CardCode", function()
    describe("P-SSR1 Nichika", function()
        local code = code("1040240010")

        it("Type check", function()
            assert.is_equal(CardCode.getTypeFromCode(code), "Produce")
        end)

        it("Rarity check", function()
            assert.is_equal(CardCode.getRarityFromCode(code), "SSR")
        end)

        it("Character check", function()
            assert.is_equal(CardCode.getCharacterFromCode(code), "Nichika Nanakusa")
        end)

        it("Card Number check", function()
            assert.is_equal(CardCode.getCardNumberFromCode(code), 1)
        end)
    end)

    describe("P-IdolRoad SSR1 Hiori", function()
        local code = code("1940020010")

        it("Type check", function()
            assert.is_equal(CardCode.getTypeFromCode(code), "Produce")
        end)

        it("Rarity check", function()
            assert.is_equal(CardCode.getRarityFromCode(code), "IdolRoad SSR")
        end)

        it("Character check", function()
            assert.is_equal(CardCode.getCharacterFromCode(code), "Hiori Kazano")
        end)

        it("Card Number check", function()
            assert.is_equal(CardCode.getCardNumberFromCode(code), 1)
        end)
    end)
end)