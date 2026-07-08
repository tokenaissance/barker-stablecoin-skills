# Barker MCP — Install Guide

Barker is a **remote, hosted MCP server** — no npm install, no local process to run. Point your MCP client at the hosted endpoint and go.

- **Endpoint (Streamable HTTP):** `https://mcp.barker.money`
- **Discovery (no auth):** https://api.barker.money/llms.txt
- **Payment model:** pay-per-call via HTTP 402 / x402, settled in USDC / USDT0 on X Layer, Base, Ethereum, Polygon, or Arbitrum. `initialize` and `tools/list` are free (the full tool catalog is visible without payment); only `tools/call` settles a 402. Your agent completes payment (e.g. via an OKX OnchainOS or wallet payment skill) and retries.

## Claude Code

```bash
claude mcp add --transport http barker https://mcp.barker.money
```

## Cursor / Cline / other MCP hosts

Add a remote (HTTP) MCP server pointing at `https://mcp.barker.money`:

```json
{
  "mcpServers": {
    "barker": {
      "url": "https://mcp.barker.money",
      "transport": "streamable-http"
    }
  }
}
```

## Tools (10)

**Data & judgment:** `barker_defi_vaults`, `barker_market_overview`, `barker_market_trend`, `barker_yield_advisor`, `barker_pool_search`, `barker_pool_detail`, `barker_pool_history`, `barker_crosschain_routes`.

**Execution (non-custodial):** `barker_executable_pools`, `barker_execution_quote` — Barker builds an unsigned deposit/redeem transaction; your own wallet signs and broadcasts. Barker never holds funds and never broadcasts; vault shares always go to the signer. Same-chain only.

---

Powered by **Barker — Yield Primitive for the Agent Economy**. Every agent touching stablecoins eventually plugs in. https://barker.money
