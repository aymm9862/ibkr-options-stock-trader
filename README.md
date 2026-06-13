# IBKR Options & Stock Click Trader

[中文](#中文) · [English](#english)

A lightweight desktop **click-to-trade** front end for [Interactive Brokers](https://www.interactivebrokers.com/) (IBKR), built with PyQt5 on top of the official `ibapi` TWS API. It contains **two independent programs** that share the same engine and widgets:

| Program | Entry point | What it trades |
| --- | --- | --- |
| **Options Click Trader** | `main.py` | US options (option chain → click a price → order) |
| **Stock Click Trader** | `stock_trader.py` | US stocks (price ladder → click a price → order) |

> ⚠️ **Disclaimer / 免责声明**: This is a personal, educational project. Trading options and stocks carries substantial risk of loss. The software is provided "as is" with **no warranty** — use it at your own risk, test with a **paper account first**, and verify every order before sending. The authors are not responsible for any financial loss.

---

## 中文

### 这是什么

一个连接 **盈透证券 (Interactive Brokers, IBKR)** 的桌面 **点价交易** 前端，用 Python + PyQt5 编写，底层走 IBKR 官方 `ibapi`。包含两个独立程序：

- **期权点价交易 (`main.py`)** — 期权链 + 点价梯（带盘口深度）+ 点击价格即下单 + 持仓面板（每仓位实时盈亏）+ 委托管理 + K 线图 + 账户栏（含外汇换汇）。
- **正股点价交易 (`stock_trader.py`)** — 点价梯（深度摆盘）+ 点击下单 + K 线图 + 正股持仓（今日盈亏）+ 委托管理。

两个程序可同时运行（使用不同的 TWS clientId：期权=10，正股=11）。

### 目标

把 IBKR 期权 / 正股的下单做成 **「在价格梯上点一下就成交」** 的体验，省去在 TWS 里反复填表的麻烦，并提供：
- 实时盘口深度（10 档）与点价梯联动；
- 模拟盘 (Paper) 与实盘 (Live) 一键切换；
- 每个持仓的实时盈亏（`reqPnLSingle`）；
- 拒单原因即时弹窗 + 自动落盘日志，便于排查。

### 需要什么

**软件 / 账号：**
1. **盈透证券账户 (IBKR)** — 实盘或模拟账户均可。
2. **TWS 或 IB Gateway** — 已安装并登录，且在
   `Global Configuration → API → Settings` 中勾选
   **Enable ActiveX and Socket Clients**。
3. **行情订阅** — 想看实时报价需要订阅对应的美股 / 期权行情数据包；
   否则只能用延迟 (Delayed) 或冻结 (Frozen) 数据。
4. **Python 3.10+**（Windows 上开发测试）。

**Python 依赖**（见 `requirements.txt`）：`PyQt5`、`ibapi==9.81.1`、`psutil`、`numpy`、`pyqtgraph`。

### 安装与运行

```bash
# 1) 克隆
git clone https://github.com/Hoary-Stock/ibkr-options-stock-trader.git
cd ibkr-options-stock-trader

# 2) （推荐）创建虚拟环境并装依赖
python -m venv .venv
.venv\Scripts\activate          # Windows
pip install -r requirements.txt

# 3) 打开 TWS / IB Gateway 并启用 API（见上）

# 4) 运行
python main.py            # 期权点价交易
python stock_trader.py    # 正股点价交易
```

Windows 用户也可双击 `start.bat`（期权）或 `start_stock.bat`（正股）。

> 一键装依赖：直接双击 `setup.bat`，它会建虚拟环境并安装 `requirements.txt`。

### 配置

所有参数集中在 `config.py`：

| 项 | 说明 |
| --- | --- |
| `IBKR_HOST` / 端口 | 默认 `127.0.0.1`；实盘 TWS=7496，模拟 TWS=7497，Gateway 实盘/模拟=4002/4001 |
| `IBKR_CLIENT_ID` / `IBKR_STOCK_CLIENT_ID` | 期权=10，正股=11（同一个 TWS 可多 client 并行，勿与你其他程序冲突） |
| `MARKET_DATA_TYPE` | 1=实时, 2=冻结, 3=延迟, 4=延迟冻结 |
| `DEFAULT_SYMBOLS` | 默认标的列表 |
| `TICK_SIZE_*` / `TICK_SIZE_OVERRIDES` | 最小报价单位（含 SPX 等指数期权覆盖） |
| `COMMISSION_*` | 手续费估算（IBKR Pro Fixed） |

**先用模拟盘**：在程序界面里把交易模式切到 Paper，或把端口指向模拟 TWS (7497)。

### 想基于它做自己的版本？

本仓库采用 **MIT 许可证**：欢迎自由下载、Fork、修改成你自己的版本（保留版权声明即可）。
你无法直接改动本仓库，但点右上角 **Fork** 即可得到一份完全属于你的副本随意改造。

---

## English

### What it is

A desktop **click-to-trade** front end for **Interactive Brokers (IBKR)**, written in Python + PyQt5 on the official `ibapi` TWS API. Two independent programs:

- **Options Click Trader (`main.py`)** — option chain + price ladder (with order-book depth) + click-a-price-to-order + position panel (live per-position P&L) + order management + K-line chart + account bar (with FX conversion).
- **Stock Click Trader (`stock_trader.py`)** — price ladder (depth book) + click-to-order + K-line chart + stock positions (today's P&L) + order management.

Both can run at the same time (different TWS clientIds: options = 10, stock = 11).

### Goal

Turn IBKR order entry into a **"click once on the price ladder and you're filled"** experience instead of repeatedly filling out TWS forms, plus:
- live 10-level order-book depth wired into the ladder;
- one-click switch between **Paper** and **Live** trading;
- real-time per-position P&L (`reqPnLSingle`);
- instant rejection popups + automatic on-disk logs for troubleshooting.

### What you need

**Software / accounts:**
1. **An Interactive Brokers (IBKR) account** — live or paper.
2. **TWS or IB Gateway** running and logged in, with **Enable ActiveX and Socket Clients** checked under `Global Configuration → API → Settings`.
3. **Market-data subscriptions** for real-time quotes (otherwise delayed/frozen data only).
4. **Python 3.10+** (developed and tested on Windows).

**Python dependencies** (see `requirements.txt`): `PyQt5`, `ibapi==9.81.1`, `psutil`, `numpy`, `pyqtgraph`.

### Install & run

```bash
git clone https://github.com/Hoary-Stock/ibkr-options-stock-trader.git
cd ibkr-options-stock-trader

python -m venv .venv
.venv\Scripts\activate            # Windows  (use: source .venv/bin/activate on macOS/Linux)
pip install -r requirements.txt

# Start TWS / IB Gateway and enable the API (see above), then:
python main.py            # Options Click Trader
python stock_trader.py    # Stock Click Trader
```

On Windows you can also double-click `start.bat` / `start_stock.bat`, or run `setup.bat` to create the venv and install dependencies in one step.

### Configuration

All settings live in `config.py` — host/ports (7496 live TWS, 7497 paper TWS, 4001/4002 Gateway), client IDs, market-data type, default symbols, tick sizes, and commission estimates. **Start with a paper account** by pointing the port at paper TWS (7497) or switching the in-app mode to Paper.

### Build your own version

This repository is **MIT-licensed** — you're free to download, fork, and adapt it into your own version (just keep the copyright notice). You can't modify this repo directly, but hit **Fork** and you'll have a copy that's entirely yours to change.

---

### Tech notes

- IBKR API: `ibapi==9.81.1` (PyPI latest). Upgrading to 10.x requires manual install from IBKR and changes to EWrapper callback signatures.
- Rejected orders are logged to `logs/order_rejects_YYYY-MM-DD.jsonl`; console output is redirected to `logs/app_*.log` when launched via `pythonw`. The `logs/` folder is git-ignored.
- A common cause of API order rejections is TWS's *Duplicate Order Precaution*; enable **Bypass Order Precautions for API Orders** under `API → Precautions`.

### License

[MIT](LICENSE) © 2026 Hoary-Stock
