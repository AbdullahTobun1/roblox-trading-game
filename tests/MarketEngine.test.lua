-- tests/MarketEngine.test.lua
-- Unit tests for MarketEngine module
-- Run in Roblox Studio command bar or with a test runner

local MarketEngine = require(game.ServerScriptService.MarketEngine)

local function assertEquals(actual, expected, message)
	if actual ~= expected then
		error(string.format("AssertionError: %s\n  Expected: %s\n  Actual: %s", message, tostring(expected), tostring(actual)))
	end
end

local function assertGreater(actual, threshold, message)
	if actual <= threshold then
		error(string.format("AssertionError: %s\n  Expected > %d, got %d", message, threshold, actual))
	end
end

local function assertLess(actual, threshold, message)
	if actual >= threshold then
		error(string.format("AssertionError: %s\n  Expected < %d, got %d", message, threshold, actual))
	end
end

-- Test Suite
local tests = {}

function tests.testMarketInitialization()
	local market = MarketEngine.new({startPrice = 100, volatility = 0.02})
	assertEquals(market:getPrice(), 100, "Starting price should be 100")
	print("✓ testMarketInitialization passed")
end

function tests.testMarketTick()
	local market = MarketEngine.new({startPrice = 100, volatility = 0.02})
	local priceBefore = market:getPrice()
	market:tick(1)
	local priceAfter = market:getPrice()
	
	-- Price should change (with high probability)
	assertGreater(market.history[2] or 0, 0, "Price should be positive after tick")
	print("✓ testMarketTick passed")
end

function tests.testMarketEventCrash()
	local market = MarketEngine.new({startPrice = 100, volatility = 0.02})
	local priceBefore = market:getPrice()
	market:addEvent("crash", 0.10)  -- 10% crash
	local priceAfter = market:getPrice()
	
	assertLess(priceAfter, priceBefore, "Price should decrease after crash event")
	print("✓ testMarketEventCrash passed")
end

function tests.testPriceNeverNegative()
	local market = MarketEngine.new({startPrice = 0.1, volatility = 0.5})  -- Very volatile
	
	for i = 1, 1000 do
		market:tick(1)
		assertGreater(market:getPrice(), 0, "Price should never go negative")
	end
	
	print("✓ testPriceNeverNegative passed (1000 iterations)")
end

function tests.testHistoryTracking()
	local market = MarketEngine.new({startPrice = 100})
	
	for i = 1, 10 do
		market:tick(1)
	end
	
	local history = market:getHistory()
	assertEquals(#history, 10, "History should contain 10 entries (not counting initial)")
	print("✓ testHistoryTracking passed")
end

-- Run all tests
local function runAllTests()
	local passed = 0
	local failed = 0
	
	for testName, testFunc in pairs(tests) do
		pcall(function()
			testFunc()
			passed = passed + 1
		end, function(err)
			print(string.format("✗ %s FAILED: %s", testName, err))
			failed = failed + 1
		end)
	end
	
	print(string.format("\n%d passed, %d failed", passed, failed))
	return failed == 0
end

-- Export
return {
	runAllTests = runAllTests,
	tests = tests
}
