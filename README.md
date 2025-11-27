<!-- README.md -->
# Income Log dApp on Flare

## Contract Address

- **Network:** Flare Coston2 Testnet  
- **Contract Address:** `0x4e4bDE58200346d0c0F3FAEeE5Ec6d6E73Ee3377`  
- **Block Explorer:** https://coston2-explorer.flare.network/address/0x4e4bDE58200346d0c0F3FAEeE5Ec6d6E73Ee3377

---

## Description

Income Log is a simple, on-chain income tracking dApp deployed on the Flare Coston2 testnet.  
It allows users to record income entries directly on the blockchain by sending FLR (or test FLR) to a smart contract along with a human-readable note.

Each income entry is stored immutably with the following data:

- **Sender address** – who sent the funds  
- **Amount** – how much FLR was sent  
- **Timestamp** – when the income was recorded (block timestamp)  
- **Note** – a short description of the income (e.g., salary, freelance work, gift)

The accompanying frontend provides a simple interface for:

- Connecting a wallet
- Viewing the total contract balance
- Viewing the total number of income entries
- Adding new income records with an amount and note

This makes Income Log a clean starting point for financial tracking, analytics dashboards, or more advanced personal finance tools built on Flare.

---

## Features

- **On-chain Income Logging**
  - Record incomes by sending FLR to the contract via the `addIncome` function.
  - Every entry is stored permanently with metadata (sender, amount, timestamp, note).

- **Payable Smart Contract**
  - Uses a payable function (`addIncome`) to accept native FLR with each entry.
  - Contract balance represents the sum of all unwithdrawn income recorded.

- **Basic Analytics Primitives**
  - `getContractBalance()` exposes the contract's total FLR holdings.
  - `getTotalEntries()` returns the total number of income records stored.
  - `getEntry(index)` returns full details for a specific income entry.

- **Ownership and Withdrawal**
  - The contract tracks an `owner` (the deployer).
  - The owner can withdraw funds from the contract using `withdraw(to, amount)`.

- **Frontend Integration (React + wagmi + viem)**
  - Wallet connection gating: users must connect a wallet before interacting.
  - `useIncomeContract` hook abstracts reads and writes to the contract.
  - Loading, pending, confirming, and error states are handled cleanly in the UI.
  - Sample UI (`components/sample.tsx`) demonstrates a minimal but user-friendly interaction pattern.

---

## How It Solves the Problem

### The Problem

Personal and project-based income tracking is usually handled off-chain in spreadsheets, centralized dashboards, or banking exports. This creates several pain points:

- **Lack of transparency:** Collaborators or stakeholders cannot independently verify income flows.
- **Data fragmentation:** Income records live in multiple tools and formats.
- **Limited composability:** It is difficult to plug income data into other dApps or automated workflows.
- **Trust assumptions:** Centralized services can modify or lose financial records.

For blockchain-native users and projects building on Flare, there is a need for a simple, transparent, and composable way to log income events directly on-chain.

### The Solution

Income Log addresses these issues by turning income tracking into an on-chain primitive:

1. **Immutable, Transparent Records**

   Each income entry is stored on the Flare blockchain, making it:

   - **Verifiable:** Anyone can inspect the contract state or use the explorer to confirm entries.
   - **Tamper-resistant:** Once recorded, an income event cannot be silently altered or deleted.
   - **Shareable:** A single contract address represents the canonical source of truth for income events.

2. **Simple Interaction Model**

   The workflow is intentionally minimal:

   - Connect wallet.
   - Enter an **amount** (in FLR).
   - Add a short **note** describing the income.
   - Submit the transaction.

   The dApp then:

   - Sends the specified FLR amount to the contract.
   - Stores a structured record via the `addIncome` function.
   - Updates UI state to reflect the new contract balance and total entries.

3. **Composable On-chain Data**

   Because all data is stored in a public smart contract, it can be:

   - Queried by analytics dashboards.
   - Aggregated by off-chain services or indexers.
   - Integrated into other smart contracts (e.g., budgeting, revenue sharing, or DAO tools).

4. **Owner-Controlled Treasury**

   The contract’s balance represents an on-chain treasury of the incomes logged through it. The owner can:

   - Periodically **withdraw** accumulated funds to a chosen address.
   - Use the contract as a simple revenue pool for a project, product, or community.

5. **Educational and Extensible Design**

   The project is intentionally small and readable, making it ideal for:

   - Learning how to build a full stack dApp (Solidity + React + wagmi + viem).
   - Extending with features like:
     - Per-user income views
     - Tagging and categories
     - Export to CSV/JSON
     - Access control or role-based permissions
     - Automated reporting and notifications

### Use Cases and Benefits

- **Personal Finance Tracking**
  - Log salary, freelance earnings, gifts, or other incomes on-chain for a transparent personal ledger.

- **Project / Startup Revenue**
  - Use the contract as a simple revenue sink where all income streams are recorded and auditable.

- **Education and Demos**
  - Demonstrate basic smart contract interactions (payable functions, events, reads/writes) in workshops or tutorials.

- **Community or DAO Treasury**
  - Serve as a lightweight treasury contract where incoming funds are logged and later withdrawn by an authorized owner.

By combining a straightforward Solidity contract with a modern React frontend, Income Log showcases how Flare can be used to build transparent, user-friendly financial dApps with minimal complexity while remaining highly extensible.
