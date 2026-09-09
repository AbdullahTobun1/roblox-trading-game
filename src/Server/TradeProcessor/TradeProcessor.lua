-- TradeProcessor.lua
-- Server-side trade validation and execution
-- Handles: validation, P&L calculation, XP awarding

local TradeProcessor = {}

-- Trade result object
local TradeResult = {}
TradeResult.__index = TradeResult

function TradeResult.new(success, tradeId, message, data)
	local self = setmetatable({}, TradeResult)
	self.success = success or false
	self.tradeId = tradeId or nil
	self.message = message or ""
	self.data = data or {}
	return self
end

-- Validate a trade request
-- Input: {
--   playerId: <int>,
--   direction: "BUY" | "SELL",
--   entryPrice: <number>,
--   exitPrice: <number> (optional, added when closing),
--   quantity: <number>,
--   stopLoss: <number> (optional, price limit),
--   playerCash: <number>,
--   playerPortfolio: <table> (optional)
-- }
function TradeProcessor.validateTrade(tradeRequest)
	-- Validate required fields
	if not tradeRequest.playerId then
		return TradeResult.new(false, nil, "Missing playerId")
	end
	
	if not tradeRequest.direction or (tradeRequest.direction ~= "BUY" and tradeRequest.direction ~= "SELL") then
		return TradeResult.new(false, nil, "Invalid direction: must be BUY or SELL")
	end
	
	if not tradeRequest.entryPrice or tradeRequest.entryPrice <= 0 then
		return TradeResult.new(false, nil, "Invalid entry price")
	end
	
	if not tradeRequest.quantity or tradeRequest.quantity <= 0 then
		return TradeResult.new(false, nil, "Quantity must be positive")
	end
	
	-- Validate player has sufficient cash for BUY
	local cost = tradeRequest.entryPrice * tradeRequest.quantity
	if tradeRequest.direction == "BUY" and tradeRequest.playerCash < cost then
		return TradeResult.new(false, nil, "Insufficient funds", {required = cost, available = tradeRequest.playerCash})
	end
	
	-- Validate stop-loss is reasonable
	if tradeRequest.stopLoss then
		if tradeRequest.direction == "BUY" and tradeRequest.stopLoss >= tradeRequest.entryPrice then
			return TradeResult.new(false, nil, "Stop-loss must be below entry price for BUY orders")
		end
		if tradeRequest.direction == "SELL" and tradeRequest.stopLoss <= tradeRequest.entryPrice then
			return TradeResult.new(false, nil, "Stop-loss must be above entry price for SELL orders")
		end
	end
	
	return TradeResult.new(true, nil, "Trade is valid")
end

-- Calculate trade success score (0-100)
-- Factors: direction accuracy, magnitude estimation, risk management
function TradeProcessor.calculateTradeScore(trade)
	-- Input: {
	--   entryPrice: <number>,
	--   exitPrice: <number>,
	--   predictedPrice: <number> (player's guess),
	--   direction: "BUY" | "SELL",
	--   stopLoss: <number> (optional),
	--   actualMarketHigh: <number> (highest price during trade),
	--   actualMarketLow: <number> (lowest price during trade)
	-- }
	
	if not trade.entryPrice or not trade.exitPrice or not trade.predictedPrice then
		return 0
	end
	
	local score = 0
	
	-- Direction Score (0-40 points)
	local directionCorrect = false
	if trade.direction == "BUY" and trade.exitPrice > trade.entryPrice then
		directionCorrect = true
	elseif trade.direction == "SELL" and trade.exitPrice < trade.entryPrice then
		directionCorrect = true
	end
	
	if directionCorrect then
		score = score + 40
	else
		return 0  -- Got direction wrong, no score
	end
	
	-- Magnitude Accuracy Score (0-40 points)
	local actualMove = math.abs((trade.exitPrice - trade.entryPrice) / trade.entryPrice)
	local predictedMove = math.abs((trade.predictedPrice - trade.entryPrice) / trade.entryPrice)
	
	if predictedMove == 0 then
		score = score + 0
	else
		local accuracy = 1 - math.min(1, math.abs(actualMove - predictedMove) / predictedMove)
		score = score + (40 * accuracy)
	end
	
	-- Risk Management Score (0-20 points)
	if trade.stopLoss then
		local riskPerTrade = math.abs((trade.stopLoss - trade.entryPrice) / trade.entryPrice)
		local rewardPerTrade = actualMove
		
		if riskPerTrade > 0 then
			local riskRewardRatio = rewardPerTrade / riskPerTrade
			-- Reward good risk/reward ratios (2:1 or better)
			if riskRewardRatio >= 2 then
				score = score + 20
			elseif riskRewardRatio >= 1 then
				score = score + 10
			else
				score = score + 0
			end
		end
	end
	
	return math.floor(score)
end

-- Calculate P&L (Profit/Loss) in dollars
function TradeProcessor.calculatePnL(trade)
	-- Input: {entryPrice, exitPrice, quantity, direction}
	local pnl = 0
	
	if trade.direction == "BUY" then
		pnl = (trade.exitPrice - trade.entryPrice) * trade.quantity
	elseif trade.direction == "SELL" then
		pnl = (trade.entryPrice - trade.exitPrice) * trade.quantity
	end
	
	return pnl
end

-- Apply trading fees/slippage
function TradeProcessor.applyFees(tradeValue, volatility)
	volatility = volatility or 0.02
	
	local baseFee = 0.001  -- 0.1% base commission
	local slippage = volatility * 0.05  -- Slippage increases with volatility
	
	local totalFeePercent = baseFee + slippage
	return tradeValue * totalFeePercent
end

return TradeProcessor
