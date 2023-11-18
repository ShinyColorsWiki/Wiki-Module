local PrismCardCode = require "PrismCardCode"


local function c(x)
    return { args = { x } }
end

setup(function()

end)

describe("PrismCardCode", function()
    describe("Produce", function()
        local code = c("328001")

        it("Rarity check", function()
            assert.is_equal(PrismCardCode.getProduceRarityFromCode(code), "3*")
        end)

        it("Character check", function()
            assert.is_equal(PrismCardCode.getCharacterFromCode(code), "Haruki Ikuta")
        end)

        it("Card Number check", function()
            assert.is_equal(PrismCardCode.getCardNumberFromCode(code), 1)
        end)
    end)

    describe("Support", function()
        local code = c("390001")

        it("Rarity check", function()
            assert.is_equal(PrismCardCode.getSupportRarityFromCode(code), "SSR")
        end)

        it("Character check", function()
            assert.is_equal(PrismCardCode.getCharacterFromCode(code), "Hazuki Nanakusa")
        end)

        it("Card Number check", function()
            assert.is_equal(PrismCardCode.getCardNumberFromCode(code), 1)
        end)
    end)
end)
