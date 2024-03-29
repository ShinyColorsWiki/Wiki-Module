local PrismCardCode = require "PrismCardCode"


local function c(x)
    return { args = { x } }
end

setup(function()

end)

describe("PrismCardCode", function()
    describe("Produce", function()
        local code = c("1328001")

        it("Type check", function()
            assert.is_equal(PrismCardCode.getTypeFromCode(code), "Produce")
        end)

        it("Rarity check", function()
            assert.is_equal(PrismCardCode.getRarityFromCode(code), "3*")
        end)

        it("Character check", function()
            assert.is_equal(PrismCardCode.getCharacterFromCode(code), "Haruki Ikuta")
        end)

        it("Card Number check", function()
            assert.is_equal(PrismCardCode.getCardNumberFromCode(code), 1)
        end)
    end)

    describe("Support", function()
        local code = c("2390001")

        it("Type check", function()
            assert.is_equal(PrismCardCode.getTypeFromCode(code), "Support")
        end)

        it("Rarity check", function()
            assert.is_equal(PrismCardCode.getRarityFromCode(code), "SSR")
        end)

        it("Character check", function()
            assert.is_equal(PrismCardCode.getCharacterFromCode(code), "Hazuki Nanakusa")
        end)

        it("Card Number check", function()
            assert.is_equal(PrismCardCode.getCardNumberFromCode(code), 1)
        end)
    end)
end)
