# Roblox Trading Game 📈🎮

A Roblox game where players learn quantitative finance through trading, investing, and portfolio management. Features realistic market simulations, technical indicators, and progression systems.

**Made by:** You & Your Friend (Cybersecurity specialist)

---

## 🎯 Project Overview

Players start with random capital from a spinner, then:
- **Trade stocks** with real market algorithms (Ornstein-Uhlenbeck process)
- **Earn XP** based on trade success and portfolio management
- **Unlock better tools**: technical indicators, new markets, advanced assets
- **Invest in real estate** for passive income
- **Compete on leaderboards** and track performance with real quant metrics

**Educational Goal:** Learn quantitative finance, market microstructure, risk management, and portfolio theory while building your quant portfolio.

---

## 🚀 Quick Start

### Prerequisites
- Roblox Studio installed
- Git installed
- VS Code (recommended)
- Lua language server extension (for VS Code autocomplete)

### Setup

```bash
# Clone the repo
git clone https://github.com/[your-username]/roblox-trading-game.git
cd roblox-trading-game

# Open in Roblox Studio
# File → Open → Select this folder as a BasePlace

# Or open in VS Code
code .
```

---

## 📁 Project Structure

```
roblox-trading-game/
├── src/
│   ├── Server/              # Server-side logic
│   │   ├── MarketEngine/    # Price simulation & market ticks
│   │   ├── TradeProcessor/  # Trade validation & execution
│   │   └── PlayerState/     # Account & portfolio data
│   ├── Client/              # Client-side UI & tools
│   │   ├── UI/              # Roblox GUI components
│   │   └── Predictors/      # Technical indicator calculators
│   └── Shared/              # Constants & utilities used by both
├── docs/                    # Design docs, architecture
├── tests/                   # Unit tests
└── .github/                 # GitHub workflows, templates
```

---

## 🔄 Development Workflow

### 1. **Claiming Work**
- Check [GitHub Issues](../../issues) for tasks (labeled by area)
- Assign yourself: "I'll work on this"
- Create a branch: `git checkout -b market-algo-#123`

### 2. **Coding in VS Code**
- Edit `.lua` files in `src/`
- Use Lua language server for autocomplete
- Reference [Roblox API docs](https://developer.roblox.com/docs)

### 3. **Testing in Roblox Studio**
- Save changes in VS Code
- Switch to Roblox Studio → **Sync** to see changes live
- Or reload: `File → Revert` (clears cache)

### 4. **Pushing & PR**
```bash
git add .
git commit -m "Implement market tick system (fixes #123)"
git push origin market-algo-#123
```
- Open PR on GitHub, link the issue
- Explain what you built and why
- Request review from your teammate

---

## 📊 Current Priorities (MVP Phase)

1. **[Phase 1]** Market simulator with basic GBM
2. **[Phase 1]** Trade entry UI mockup
3. **[Phase 1]** Simple XP system for correct predictions
4. **[Phase 2]** Mean-reversion & random events
5. **[Phase 2]** Technical indicators (moving average)

See [ROADMAP.md](docs/ROADMAP.md) for full timeline.

---

## 🤝 Contributing

Both teammates can work in parallel:
- **Quant/Math focus**: Market algorithms, XP/progression logic
- **Cybersecurity focus**: Data validation, exploit prevention, secure storage

See [CONTRIBUTING.md](CONTRIBUTING.md) for code style, testing requirements, and PR checklist.

---

## 📚 Resources for Learning

### Quantitative Finance
- **Stochastic Processes**: [Sheldon Ross - Stochastic Processes](https://www.amazon.com/Stochastic-Processes-Sheldon-M-Ross/dp/0470691476)
- **Black-Scholes & GBM**: [Hull - Options, Futures, and Derivatives](https://www.amazon.com/Options-Futures-Other-Derivatives-10th/dp/0136939155)
- **Practical**: Build a Monte Carlo simulator as you go

### Roblox & Lua
- [Roblox API Reference](https://developer.roblox.com/docs)
- [Lua 5.1 Reference](https://www.lua.org/manual/5.1/)
- [Roblox Code Style Guide](https://developer.roblox.com/docs/studio/script-performance)

### Market Microstructure
- Learn as you implement: bid-ask spreads, slippage, order flow

---

## 🎓 Why This Project is Great for Your Goals

✅ **Stochastic Processes** — You'll implement Ornstein-Uhlenbeck & GBM  
✅ **Backtesting** — Build a test suite for market models  
✅ **Risk Metrics** — Calculate Sharpe ratio, drawdown, VaR  
✅ **Full-Stack** — Server architecture, data persistence, client UI  
✅ **Resume Builder** — Real market simulator you built from scratch  

---

## 💬 Questions?

- **Design questions?** → Create an issue with label `design-discussion`
- **Blocked on a task?** → Comment on the GitHub issue or message in Discord
- **Found a bug?** → Create an issue with label `bug`

---

## 📄 License

MIT License (see LICENSE file)

---

**Last Updated:** Sept 2026  
**Status:** Pre-Alpha (actively developing Phase 1)
