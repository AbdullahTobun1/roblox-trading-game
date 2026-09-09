# Contributing Guide

## Development Setup

### Step 1: Clone & Install
```bash
git clone https://github.com/[your-username]/roblox-trading-game.git
cd roblox-trading-game
```

### Step 2: Roblox Studio Integration

Roblox Studio reads from disk automatically. When you edit `.lua` files:
1. **VS Code** → Save file (Ctrl+S)
2. **Roblox Studio** → Sees the change (may need to reopen place or do File → Revert)
3. OR use a file watcher plugin for real-time sync

### Step 3: VS Code Extensions (Recommended)
- `Lua` by Sumneko (autocompletion, linting)
- `Roblox LSP` by Nightrains (Roblox-specific types)
- `GitLens` (see who wrote what)

---

## Code Style

### Naming Conventions
```lua
-- Constants: SCREAMING_SNAKE_CASE
local MAX_PORTFOLIO_SIZE = 100
local DEFAULT_COMMISSION = 0.001

-- Functions: camelCase
local function calculateTradeScore(entryPrice, exitPrice, direction)
    -- ...
end

-- Variables: camelCase
local playerCash = 5000
local isTradeActive = true

-- Classes/Modules: PascalCase
local TradeProcessor = {}
function TradeProcessor.new()
    -- ...
end
```

### File Structure
```lua
-- MarketEngine.lua
local MarketEngine = {}
local MARKET_TICK_RATE = 1 -- seconds

local function internalHelper()
    -- Private functions prefixed with underscore or top-level
end

function MarketEngine.new(config)
    return {
        price = config.startPrice,
        volatility = config.volatility
    }
end

function MarketEngine:tick(dt)
    -- Public methods use self
end

return MarketEngine
```

### Comments
- **Only comment "why", not "what"** (code should be self-explanatory)
- Use `--` for single line, `--[[` for multi-line
```lua
-- BAD: Explains what, not why
local multiplier = 1.05 -- Multiplies by 1.05

-- GOOD: Explains intent
-- Adjust for edge case where market is halted mid-trade
local multiplier = isMarketHalted and 1.05 or 1.0
```

---

## Workflow: From Issue to Merge

### 1. Pick an Issue
- Go to [Issues](https://github.com/[your-username]/roblox-trading-game/issues)
- Find one labeled `ready-to-start` or `Phase 1`
- Comment: "I'll take this" → assign yourself

### 2. Create a Branch
```bash
# Branch naming: task-type/issue-number-short-description
git checkout -b feature/42-implement-market-tick
# or
git checkout -b fix/55-trade-validation-bug
```

### 3. Write Code
- Edit files in `src/` folder
- Test locally in Roblox Studio
- Commit with clear messages:
  ```bash
  git add .
  git commit -m "Implement Ornstein-Uhlenbeck market model

  - Add OU process with mean-reversion parameter
  - Price update: dP = κ(μ - P)dt + σ dW(t)
  - Tuned for stock-like behavior, tested with Monte Carlo
  - Fixes #42"
  ```

### 4. Push & Create PR
```bash
git push origin feature/42-implement-market-tick
```
- GitHub will prompt you to create a PR
- **Title:** Clear and concise (e.g., "Implement Ornstein-Uhlenbeck market model")
- **Description:**
  ```markdown
  ## What
  Implements the OU market model for realistic price movements.
  
  ## Why
  Required for players to learn market dynamics and test predictions.
  
  ## How
  - Added MarketEngine module with OU process
  - Parameter tuning: κ=0.05, σ=0.02
  - Tested with 1000-run Monte Carlo simulation
  
  Fixes #42
  ```

### 5. Code Review
- Your teammate reviews the code
- They check for:
  - ✅ Does it work? (tested?)
  - ✅ Is it secure? (no exploits?)
  - ✅ Does it fit the design?
  - ✅ Is it documented?
- Address feedback, push updates to same branch
- Merge when approved ✅

---

## Testing Locally

### In Roblox Studio
1. Open the `.rbxl` (Roblox place file)
2. Insert your modules as ServerScripts/LocalScripts
3. Call functions in the command bar to test:
   ```lua
   local MarketEngine = require(game.ServerScriptService.MarketEngine)
   local market = MarketEngine.new({startPrice = 100, volatility = 0.02})
   print(market:tick(1))  -- Simulate 1 second
   ```

### Unit Tests
Create test files in `tests/`:
```lua
-- tests/MarketEngine.test.lua
local MarketEngine = require(game.ServerScriptService.MarketEngine)

-- Simple test pattern
local function testMarketTick()
    local market = MarketEngine.new({startPrice = 100, volatility = 0.02})
    market:tick(1)
    assert(market.price > 0, "Price should be positive")
    print("✓ Market tick test passed")
end

testMarketTick()
```

---

## Git Best Practices

### Commit Often
```bash
# Good: Small, logical commits
git commit -m "Add OU process calculation"
git commit -m "Tune volatility parameters"
git commit -m "Add unit tests for OU"

# Avoid: Giant commit with multiple unrelated changes
git commit -m "Added market engine, fixed UI, updated docs, removed unused code"
```

### Keep PRs Small
- 1 PR = 1 feature/fix
- If a task needs 3 PRs, open 3 PRs
- This makes review faster and merging safer

### Sync Before Pushing
```bash
git pull origin main  # Get latest changes
git push origin feature/42-implement-market-tick
```

---

## Common Tasks

### Running a Quick Test
```lua
-- In Roblox Studio command bar
local TradeProcessor = require(game.ServerScriptService.TradeProcessor)
local result = TradeProcessor.validateTrade({direction = "BUY", quantity = 10, price = 50})
print(result.success)
```

### Debugging
```lua
-- Add debug prints
print("Current price:", market.price)
print("Direction:", direction)
warn("Unexpected state:", game:GetService("RunService"):IsRunning())

-- Or use breakpoints in Roblox Studio debugger
```

### Reverting Changes
```bash
# Undo local changes to a file
git checkout src/Server/MarketEngine.lua

# Undo last commit (keep changes locally)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

---

## Security Checklist (For Your Cybersecurity Friend)

- [ ] **Server Validation**: All trade logic runs on server, not client
- [ ] **Price Integrity**: Cannot modify market price from client
- [ ] **Account Safety**: Use Roblox authentication (don't build custom login)
- [ ] **Exploit Prevention**: Check for negative balances, spam trading, price manipulation
- [ ] **Data Validation**: Sanitize all player inputs before processing

---

## When You Get Stuck

1. **Check existing code**: Look at similar implementations in `src/`
2. **Read API docs**: [Roblox Developer Hub](https://developer.roblox.com)
3. **Ask on GitHub**: Comment on the issue, tag your teammate
4. **Debug step-by-step**: Use `print()` statements liberally

---

## Questions?

Create a discussion or comment on related issues. Happy coding! 🚀
