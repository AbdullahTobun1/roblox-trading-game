-- MarketEngine.lua
-- Server-side market simulation engine
-- Manages price updates using Geometric Brownian Motion (GBM)
-- Will upgrade to Ornstein-Uhlenbeck in Phase 2

local MarketEngine = {}
MarketEngine.__index = MarketEngine

-- Constants
local MARKET_TICK_RATE = 1  -- seconds between price updates
local DEFAULT_VOLATILITY = 0.02  -- 2% daily volatility
local DEFAULT_DRIFT = 0.0005  -- slight upward bias

local Random = Random.new()

-- Constructor
function MarketEngine.new(config)
	config = config or {}
	
	local self = setmetatable({}, MarketEngine)
	
	self.price = config.startPrice or 100
	self.volatility = config.volatility or DEFAULT_VOLATILITY
	self.drift = config.drift or DEFAULT_DRIFT
	self.history = {self.price}  -- Store price history for replay/analysis
	self.events = {}  -- Market events (earnings, crashes, etc.)
	self.lastTickTime = os.time()
	
	return self
end

-- Simulate one tick of the market (1 second)
function MarketEngine:tick(deltaTime)
	deltaTime = deltaTime or MARKET_TICK_RATE
	
	-- Geometric Brownian Motion: dP = μ*P*dt + σ*P*dW
	-- where dW is standard normal random variable
	
	local standardNormal = self:_generateGaussian()
	local priceChange = self.price * (self.drift * deltaTime + self.volatility * math.sqrt(deltaTime) * standardNormal)
	
	self.price = self.price + priceChange
	
	-- Price should never go negative
	if self.price < 0.01 then
		self.price = 0.01
	end
	
	table.insert(self.history, self.price)
	
	return self.price
end

-- Generate standard normal random variable using Box-Muller transform
function MarketEngine:_generateGaussian()
	local u1 = Random:NextNumber()
	local u2 = Random:NextNumber()
	
	-- Avoid log(0)
	while u1 <= 0 do
		u1 = Random:NextNumber()
	end
	
	local z0 = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
	return z0
end

-- Get current price
function MarketEngine:getPrice()
	return self.price
end

-- Get price history (for charting)
function MarketEngine:getHistory(count)
	count = count or 100
	local start = math.max(1, #self.history - count + 1)
	return {unpack(self.history, start)}
end

-- Add a market event (earnings report, crash, etc.)
function MarketEngine:addEvent(eventType, magnitude, description)
	magnitude = magnitude or 0.05  -- 5% default
	
	-- Random shock to price
	if eventType == "earnings" then
		self.price = self.price * (1 + Random:NextInteger(-10, 10) * magnitude / 100)
	elseif eventType == "crash" then
		self.price = self.price * (1 - magnitude)
	elseif eventType == "rally" then
		self.price = self.price * (1 + magnitude)
	end
	
	table.insert(self.events, {
		type = eventType,
		time = os.time(),
		magnitude = magnitude,
		description = description,
		priceAfter = self.price
	})
end

-- Reset market to initial state
function MarketEngine:reset(startPrice)
	self.price = startPrice or 100
	self.history = {self.price}
	self.events = {}
end

return MarketEngine
