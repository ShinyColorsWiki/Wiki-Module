local CardCode = require "CardCode"


local function c(x)
    return { args = { x } }
end

setup(function()

end)

describe("CardCode", function()
    describe("P-SSR1 Nichika", function()
        local code = c("1040240010")

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

        it("Card Page Name check", function()
            assert.is_equal(CardCode.getCardPageNameFromCode(code), "P-SSR1 Nichika")
        end)
    end)

    describe("P-IdolRoad SSR1 Hiori", function()
        local code = c("1940020010")

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

        it("Card Page Name check", function()
            assert.is_equal(CardCode.getCardPageNameFromCode(code), "P-IdolRoad SSR1 Hiori")
        end)
    end)
end)