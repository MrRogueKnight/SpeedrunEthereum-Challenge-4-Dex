
---

# 🪙 Minimum Viable Exchange – Challenge 4 (SpeedRunEthereum)

A fully-functional Decentralized Exchange (DEX) for swapping ETH and ERC20 tokens (\$BAL), adding/removing liquidity, and viewing on-chain events — built as part of the [SpeedRunEthereum Challenge 4](https://speedrunethereum.com/challenge/mvexchange).

---

## 🌐 Live Demo

🚀 **Deployed Frontend**: [https://challenge-4-dex-khaki.vercel.app](https://challenge-4-dex-khaki.vercel.app)

🔍 **Verified Contract on Sepolia**: [DEX on Etherscan](https://sepolia.etherscan.io/address/0x0B41D2aB33cdcbae843c8c0635139147A316639d)

📦 **GitHub Repo**: [github.com/MrRogueKnight/SpeedrunEthereum-Challenge-4-Dex](https://github.com/MrRogueKnight/SpeedrunEthereum-Challenge-4-Dex)

---

## 📖 About the Project

This project implements a **basic Automated Market Maker (AMM)** DEX similar to Uniswap V1. It allows users to:

* 🔁 **Swap ETH for \$BAL (Balloons)** and vice versa using the constant product formula.
* 💧 **Add liquidity** to the pool by depositing ETH and \$BAL.
* 🧪 **Withdraw liquidity**, receiving ETH and \$BAL in proportion to your liquidity share.
* 🧾 **Track real-time events** (Swaps, Liquidity Added/Removed) from the blockchain.
* 🔐 All trades and liquidity actions are permissionless and managed by smart contracts.

---

## ⚙️ Tech Stack

* **Solidity** – DEX and ERC20 Token (Balloons) contracts
* **Hardhat** – Smart contract deployment & testing
* **Next.js** – Frontend framework
* **Tailwind CSS** – UI styling
* **viem + wagmi** – Wallet connection and blockchain interactions
* **Vercel** – Frontend hosting
* **Sepolia** – Public Ethereum testnet for contract deployment

---

## 🛠 Features

| Feature                     | Description                                                                  |
| --------------------------- | ---------------------------------------------------------------------------- |
| 💱 Swap ETH ↔️ \$BAL        | Uses AMM pricing formula: `x * y = k` to ensure fair, slippage-based trading |
| 💧 Add/Remove Liquidity     | Earn LP tokens by depositing ETH and \$BAL in a 1:1 ratio                    |
| 📡 Real-time Event Feed     | View blockchain events like swaps, deposits, and withdrawals on frontend     |
| 🔒 Verified Contracts       | Verified DEX contract on [Etherscan](https://sepolia.etherscan.io/)          |
| 🔗 Public Deployed Frontend | Accessible via Vercel – no local setup needed                                |

---

## 🧪 How to Use the DEX

### 🔗 Step-by-Step Usage (on Sepolia Testnet)

> 🦊 Ensure MetaMask is connected to the **Sepolia** network.

#### 1. Connect Wallet

Click **Connect Wallet** (top-right) to link MetaMask or any wallet.

#### 2. Initialize Pool (if not yet done)

Deposit 1:1 ETH and \$BAL to create the initial liquidity pool.

#### 3. Swap ETH for \$BAL

* Enter ETH amount in the “Swap ETH for \$BAL” input
* Click **Swap**
* Confirm transaction in MetaMask

#### 4. Swap \$BAL for ETH

* Enter \$BAL amount in the “Swap \$BAL for ETH” input
* Click **Swap**
* Confirm transaction

#### 5. Add Liquidity

* Enter ETH and approve \$BAL
* Click **Deposit Liquidity**
* Confirm both approval and deposit

#### 6. Remove Liquidity

* Enter amount of liquidity tokens to withdraw
* Click **Withdraw Liquidity**
* Confirm in wallet

#### 7. View Events

* Go to the **/events** page to view historical on-chain actions

---

## 📦 Local Development Setup

### 🔧 Prerequisites

* Node.js (v18+ recommended)
* Yarn
* MetaMask (with Sepolia ETH + \$BAL tokens)

### 📁 Clone the Repo

```bash
git clone https://github.com/MrRogueKnight/SpeedrunEthereum-Challenge-4-Dex
cd SpeedrunEthereum-Challenge-4-Dex
```

### 📦 Install Dependencies

```bash
yarn install
```

### ⚙️ Generate Deployer Wallet

```bash
yarn generate
```

### 🔍 Check Deployer Address Balance

```bash
yarn account
```

### 🚀 Deploy Contracts to Sepolia

```bash
yarn deploy --network sepolia
```

### 🔍 Verify Contracts

```bash
yarn verify --network sepolia
```

### 🖥 Run Frontend Locally

```bash
cd packages/nextjs
yarn dev
```

---

## 🌍 Environment Variables

Configure these in `.env` and `.env.local` as needed:

```env
# Alchemy for Sepolia
NEXT_PUBLIC_ALCHEMY_API_KEY=your-alchemy-key
ETHERSCAN_API_KEY=your-etherscan-key
```

You can also configure these directly on [Vercel’s Environment Settings](https://vercel.com/dashboard) for production.

---

## 🔍 Contract Details

* **DEX Contract**: [0x0B41D2aB33cdcbae843c8c0635139147A316639d](https://sepolia.etherscan.io/address/0x0B41D2aB33cdcbae843c8c0635139147A316639d)
* **\$BAL Token**: [0xf727015879dD082144dCc97addFEf26220E381a7](https://sepolia.etherscan.io/address/0xf727015879dD082144dCc97addFEf26220E381a7)

---

## 🧑‍🚀 Author & Submission

* 👨‍💻 **Builder**: [0x58ad103D0C0E69250CaC89Ddf0BDaD396914C411](https://speedrunethereum.com/builders/0x58ad103D0C0E69250CaC89Ddf0BDaD396914C411)
* 🎯 **Challenge**: [Minimum Viable Exchange – Challenge 4](https://speedrunethereum.com/challenge/mvexchange)
* 🧪 **Frontend**: [https://challenge-4-dex-khaki.vercel.app](https://challenge-4-dex-khaki.vercel.app)

---

## 📜 License

MIT License. Use freely for learning, hacking, or forking!

---

