# Roblox Trading Game - Development Roadmap

## Phase 1: Proof of Concept (Weeks 1-2)
**Goal:** Playable trade loop with real market simulation

### Deliverables
- [ ] **Market Engine Module** (`src/Server/MarketEngine.lua`)
  - Implement simple GBM (Geometric Brownian Motion)
  - Tick function that updates price based on random walk
  - Parameter tuning: volatility, drift
  - Output: 1000-run Monte Carlo backtest showing realistic price curves

- [ ] **Trade Processor Module** (`src/Server/TradeProcessor.lua`)
  - Accept trade: `{playerId, direction, entryPrice, quantity, stopLoss}`
  - Validate: sufficient balance, reasonable quantity
  - Return: `{success, tradeId, message}`
  - Log all trades for audit trail

- [ ] **Basic Trading UI** (`src/Client/UI/Trading/TradeEntry.lua`)
  - Input fields: Price prediction, quantity
  - Stop-loss slider
  - "Submit Trade" button
  - Display live P&L

- [ ] **Simple XP System** (`src/Server/PlayerState.lua`)
  - Correct direction guess = +10 XP
  - Track player: cash, level, XP, portfolio
  - Save/load from DataStore

- [ ] **Testing & Validation**
  - Can you exploit negative balance? ❌ Should block on server
  - Does market look realistic? Check price distribution
  - Does XP system motivate play? A 10 minute session should earn ~50 XP

**Success Criteria:**
- Player can spin money → enter 3 trades → see results and XP gain
- Market prices look like real stock charts (not random noise)
- No exploits (server validates everything)

---

## Phase 2: Market Intelligence (Weeks 3-4)
**Goal:** Learnable market patterns, technical indicators

### Deliverables
- [ ] **Mean-Reversion Market Model**
  - Switch from GBM → Ornstein-Uhlenbeck process
  - Parameter: mean-reversion speed (κ), long-term mean (μ)
  - Creates "bounce-back" behavior that skilled players can predict
  - A/B test: players should predict 55%+ accuracy with practice

- [ ] **Random Market Events**
  - Earnings reports: ±5-10% price shock (predictable day)
  - Market crashes: ±15-20% (rare, teaches risk management)
  - Logging: store event history in DataStore for replay

- [ ] **Technical Indicators** (Phase 2A)
  - Simple Moving Average (20-period, 50-period)
  - Bollinger Bands (SMA ± 2σ)
  - Make available at L10+ only (progression gate)

- [ ] **Market Replay System**
  - Players can study past market days
  - Replay: scroll through day, see price history
  - Backtest: test strategy on recorded day without real money

- [ ] **Volatility Clustering**
  - Implement: quiet days followed by volatile days (realistic)
  - Parameter: volatility mean-reversion time-constant
  - Effect: teaches traders about risk concentration

**Success Criteria:**
- Skilled players (L10+) predict 60%+ of trades correctly
- Market patterns are learnable but not trivial
- Technical indicators give edge but aren't foolproof

---

## Phase 3: Progression & Assets (Weeks 5-6)
**Goal:** Long-term engagement, investment vehicles

### Deliverables
- [ ] **Level & XP Rework**
  - Exponential XP curve: L1 = 100 XP, L2 = 120 XP, L3 = 144 XP (1.2x growth)
  - Level 50 = 9,100+ XP total
  - Reward progression: each 5 levels unlock something

- [ ] **Unlock System**
  - L1-5: Basic market only
  - L10: Unlock SMA indicator
  - L15: Unlock second market (stable/defensive)
  - L25: Unlock RSI/MACD indicators
  - L40: Unlock exotic market (high-volatility)

- [ ] **Real Estate Investment**
  - Asset types: Starter ($5k), Apartment ($50k), Building ($500k)
  - Passive income: 2-5% annual return (compounded monthly)
  - Low correlation with stock market (diversification lesson)
  - UI: portfolio view showing real estate + stocks

- [ ] **Bank Savings Account**
  - Cash in bank earns 1% annual interest (0.0083% daily)
  - Liquidity: withdraw instantly (unlike real estate)
  - Mechanic: teaches risk/reward (risky trading vs safe savings)

- [ ] **Advanced Portfolio Tracking**
  - Display: net worth, asset allocation (pie chart)
  - Metrics: Sharpe ratio, max drawdown, win rate, ROI
  - Daily P&L chart showing wealth over time
  - Export trades as CSV for external analysis

**Success Criteria:**
- Players reach L20+ and feel progression (new tools unlock)
- Real estate owners see passive income and understand diversification
- Portfolio view looks professional (could be screenshot for resume)

---

## Phase 4: Multiplayer & Social (Weeks 7-8)
**Goal:** Competition, knowledge sharing, streamer appeal

### Deliverables
- [ ] **Leaderboard System**
  - Ranked by: Net worth, ROI %, Win rate, Current level
  - Weekly reset option (seasonal rankings)
  - Cosmetic rewards: badges, profile frames for top 10

- [ ] **Trading Journal Export**
  - Download trades as CSV: Date, Entry, Exit, P&L, Reason
  - Include market context: volatility, events that day
  - Enables: community strategy discussion, blog posts

- [ ] **Social Features** (Low Priority)
  - Optional: guild/team system
  - Optional: spectate live trader
  - Optional: share achievements (screenshot trades)

**Success Criteria:**
- Leaderboards show healthy competition (not dominated by one player)
- CSV export is clean and useful for analysis
- Trading journal data can be used for business articles

---

## Phase 5: Polish & Optimization (Weeks 9+)
**Goal:** Professional feel, performance, exploit prevention

### Deliverables
- [ ] **UI/UX Polish**
  - Responsive design: works on mobile too?
  - Smooth animations: price charts animate, buttons have feedback
  - Accessibility: large text option, colorblind mode?
  - Onboarding: tutorial for new players

- [ ] **Performance Optimization**
  - Profile: does market tick at 60fps or is it laggy?
  - Optimize: cull off-screen GUI, batch market updates
  - Scale: can 100 concurrent players each with 10 trades? 1000?

- [ ] **Exploit & Balance Testing**
  - Spam trading: can you execute 1000 trades/sec? (Should block)
  - Price manipulation: can you modify market price? (Should fail server-side)
  - Negative balance: can you go into debt? (Should block)
  - Wealth inequality: Gini coefficient ~0.4-0.6 (not too unfair)

- [ ] **Documentation**
  - Architecture doc: explain server/client flow
  - Market model doc: explain OU process parameters
  - Player guide: how to get started, what each indicator means
  - Contributing guide: how teammates can extend the game

**Success Criteria:**
- Game is stable and fun for 1+ hour session
- No known exploits
- New player understands game in <5 minutes
- Code is documented enough for external contributors

---

## Phase 6+: Post-Launch Features (Optional)

- [ ] Leverage trading (advanced players only, 2-5x multiplier)
- [ ] Shorting (sell stocks you don't own, bet on price drop)
- [ ] Options trading (calls, puts — advanced game mechanic)
- [ ] AI competitors (NPCs with different trading styles)
- [ ] Seasonal events (Black Swan challenges, market crashes to recover from)
- [ ] Community tournaments (prize pools, bragging rights)
- [ ] YouTube integration (stream your trades, earn cosmetics)

---

## Success Metrics

Track these during development:

| Metric | Target | Why |
|--------|--------|-----|
| **New player retention (Day 1→7)** | >50% | If people quit after day 1, game isn't fun |
| **Average session length** | 20-30 min | Long enough to feel progress, not grindy |
| **Player win rate** | 50-55% | Should be ~50% + skill edge, not unbeatable |
| **Level distribution** | Peak at L8-12 | Most players progress, not stuck forever |
| **Wealth inequality (Gini)** | 0.40-0.60 | Fairness between casual and hardcore players |
| **Exploit attempts** | 0 known | Server-side validation is working |

---

## Parallel Work for Your Friend (Cybersecurity)

### Security Tasks (Can start anytime)
- [ ] **Account Security**
  - Implement: proper DataStore encryption
  - Prevent: account takeover, session hijacking
  - Test: bruteforce attempts

- [ ] **Trade Validation**
  - Implement: server-side anti-cheat
  - Prevent: client-side price modification, infinite trades
  - Whitelist: only valid order types accepted

- [ ] **Exploit Audit**
  - Test: negative balance exploits
  - Test: spam trading
  - Test: price manipulation
  - Document: findings and fixes

- [ ] **Data Privacy**
  - Implement: GDPR-compliant data deletion
  - Protect: trade history from unauthorized access
  - Log: all data access for audit trail

---

## Timeline Summary

```
Week 1-2  │ Phase 1: Market + Basic Trading
Week 3-4  │ Phase 2: Intelligence + Indicators  
Week 5-6  │ Phase 3: Progression + Assets
Week 7-8  │ Phase 4: Multiplayer + Social
Week 9+   │ Phase 5: Polish + Launch Prep
```

**Target Launch:** Week 10 (MVP ready for testing)

---

## How to Track Progress

- Use GitHub Issues for each task (see ISSUES_TEMPLATE)
- Assign to yourself when starting
- Label by phase: `Phase-1`, `Phase-2`, etc.
- Update: reopen issue when blocked, close when done
- PR = proof of work (links to issue automatically)

---

## Questions?

- Design unclear? Open a discussion issue
- Task too big? Split it into smaller issues
- Need help? Comment and tag your teammate

Let's build something awesome! 🚀
