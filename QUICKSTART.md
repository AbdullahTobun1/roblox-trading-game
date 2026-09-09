# Quick Start Guide for Your Team

## ✅ Setup Complete!

Your Roblox Trading Game project is ready. Here's what's been created:

```
C:\Users\abdit\roblox-trading-game\
├── README.md                 # Project overview
├── CONTRIBUTING.md           # Coding standards & workflow
├── .gitignore               # Git configuration
├── docs/
│   └── ROADMAP.md           # 9-week development plan
├── src/
│   ├── Server/
│   │   ├── MarketEngine/    # Market simulation (STARTER CODE)
│   │   └── TradeProcessor/  # Trade validation (STARTER CODE)
│   ├── Client/UI/           # (Ready for UI implementation)
│   └── Shared/              # (Ready for shared utilities)
└── tests/
    └── MarketEngine.test.lua # Unit tests (example)
```

---

## 🚀 Next Steps (Today!)

### Step 1: Open in VS Code
```bash
code C:\Users\abdit\roblox-trading-game
```

**Install extensions:**
- `Lua` by Sumneko
- `Roblox LSP` by Nightrains  
- `GitLens` for commit history

### Step 2: Review the Starter Code
- Open `src/Server/MarketEngine/MarketEngine.lua`
  - This is your **market simulation engine** with GBM (Geometric Brownian Motion)
  - **TODO:** Test it, tune parameters, upgrade to OU process in Phase 2

- Open `src/Server/TradeProcessor/TradeProcessor.lua`
  - Validates trades, calculates P&L, computes XP scores
  - **TODO:** Integrate with MarketEngine

- Read `docs/ROADMAP.md` → understand the 9-week plan

### Step 3: Set Up GitHub (for collaboration)

#### Option A: Create a new GitHub repo (RECOMMENDED)
```bash
cd C:\Users\abdit\roblox-trading-game

# Replace YOUR-USERNAME with your GitHub username
git remote add origin https://github.com/YOUR-USERNAME/roblox-trading-game.git
git branch -M main
git push -u origin main
```

Then, add your friend as a collaborator:
1. Go to github.com/YOUR-USERNAME/roblox-trading-game/settings/access
2. Click "Add people" 
3. Invite your friend's GitHub username

#### Option B: Create a GitHub org (for shared ownership)
If you want both names on the repo, create an organization:
1. github.com/settings/organizations → "New organization"
2. Name it: `roblox-trading` or similar
3. Both of you join
4. Create repo under org, push code there

### Step 4: Split Up Work
**For You (Quant/Math focus):**
- [ ] Understand & test `MarketEngine.lua` 
- [ ] Run 1000-day simulation, plot prices
- [ ] Tune volatility/drift parameters (make it look realistic)
- [ ] Implement Ornstein-Uhlenbeck process (Phase 2)
- [ ] Add random market events (crashes, rallies)

**For Your Friend (Cybersecurity focus):**
- [ ] Review `TradeProcessor.lua` for security bugs
- [ ] Add server-side validation to prevent exploits
- [ ] Design data storage (PlayerState.lua)
- [ ] Plan authentication & account security

---

## 📋 Phase 1 Tasks (This Week)

Create these GitHub issues and assign them:

### Issue 1: Test & Tune Market Engine
```markdown
## Market Simulation Validation

Verify that MarketEngine produces realistic price movements.

### Acceptance Criteria
- [ ] Run 1000 ticks, plot price history
- [ ] Check: mean = expected, std dev ≈ volatility
- [ ] Prices look like real stock chart (not random noise)
- [ ] No negative prices
- [ ] Comment with findings + chart

### Files
- src/Server/MarketEngine/MarketEngine.lua
- tests/MarketEngine.test.lua
```

### Issue 2: Implement Trade Validation
```markdown
## Trade Validation on Server

Integrate MarketEngine with TradeProcessor to handle trade logic.

### Acceptance Criteria
- [ ] Player submits trade request
- [ ] Server validates: sufficient cash, reasonable price
- [ ] Server accepts/rejects trade
- [ ] Log trade to history
- [ ] No client-side price manipulation possible

### Files
- src/Server/TradeProcessor/TradeProcessor.lua
- src/Server/PlayerState.lua (new)
```

### Issue 3: Basic Trading UI
```markdown
## Trading UI Mockup

Create Roblox GUI for entering trades (even if non-functional).

### Acceptance Criteria
- [ ] Price prediction input field
- [ ] Quantity slider (1-100)
- [ ] Stop-loss input
- [ ] "Execute Trade" button
- [ ] Display current player cash

### Files
- src/Client/UI/Trading/TradeEntry.lua (new)
```

---

## 🔄 Typical Workflow

```bash
# You (or your friend) want to work on an issue:

# 1. Create a branch
git checkout -b feature/42-market-engine-tuning

# 2. Make changes in VS Code
# ... edit files ...

# 3. Test in Roblox Studio
# Insert MarketEngine script, run tests

# 4. Commit & push
git add .
git commit -m "Tune market engine parameters for realism

- Adjusted volatility: 0.02 → 0.025
- Added drift: μ = 0.0005
- Tested 1000-run Monte Carlo
- Mean ≈ 100, StdDev ≈ 2.5 (matches expected)

Fixes #42"

git push origin feature/42-market-engine-tuning

# 5. Open Pull Request on GitHub
# (GitHub will prompt you with a link)
# Title: "Tune market engine parameters for realism"
# Description: Copy your commit message

# 6. Your friend reviews, approves
# 7. Merge to main ✅
```

---

## 💬 Communication

- **Design questions?** → Open a GitHub discussion or issue with `design-discussion` label
- **Blocked on a task?** → Comment on the GitHub issue
- **Need to pair program?** → Use VS Code Live Share (free extension)
- **Share findings?** → Create a wiki page or discussion post

---

## 📚 Resources

### Lua/Roblox
- [Roblox API Reference](https://developer.roblox.com/docs)
- [Lua 5.1 Manual](https://www.lua.org/manual/5.1/)

### Quantitative Finance
- **GBM**: YouTube search "Geometric Brownian Motion tutorial"
- **Ornstein-Uhlenbeck**: [Wikipedia](https://en.wikipedia.org/wiki/Ornstein%E2%80%93Uhlenbeck_process)
- **Backtesting**: Will implement together in Phase 2

### Roblox Development Workflow
- See `CONTRIBUTING.md` for detailed coding standards

---

## 🎯 Success Criteria (End of Week 1)

- [ ] Code pushed to GitHub
- [ ] Market engine produces realistic-looking prices
- [ ] Trade validation prevents exploits
- [ ] Both teammates have run code locally
- [ ] 3-5 GitHub issues created for next tasks

---

## ⚡ If You Get Stuck

1. **MarketEngine not working?**
   - Add `print()` statements to debug
   - Check: is `startPrice` being set?
   - Verify: `_generateGaussian()` returns numbers

2. **Git error?**
   ```bash
   git status  # See what's going on
   git log --oneline  # See commit history
   git diff  # See what changed
   ```

3. **Need help?**
   - Comment on GitHub issue with your question
   - Tag your teammate
   - Include: what you tried, what happened, error message

---

## 🎮 Ready to Build?

1. Open VS Code
2. Read `README.md` (5 min overview)
3. Read `docs/ROADMAP.md` (understand Phase 1)
4. Open `src/Server/MarketEngine/MarketEngine.lua` (review code)
5. Create GitHub repo and push
6. Open first GitHub issue
7. **Start coding!** 🚀

Good luck! This is going to be awesome.

---

**Questions?** Reply to this document or create a GitHub discussion.
