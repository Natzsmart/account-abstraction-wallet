# EIP-4337 Smart Wallet

This project implements a simplified **Account Abstraction (EIP-4337)** smart wallet in Solidity. 
It demonstrates core features of the new Ethereum account model, including gasless transactions, batch execution, and ERC20 gas payments via a Paymaster contract.

---

## Features

- **Basic Smart Wallet**  
  - Stores an owner address  
  - Allows executing single or multiple (batch) calls  
  - Prevents replay attacks using a nonce  
  - Simulates signature validation for UserOperations  

- **Paymaster Contract**  
  - Accepts gas payments in ERC20 tokens instead of ETH  
  - Logs gas sponsorship events  

- **Bonus Features**  
  - Batch multiple calls in one transaction  
  - ERC20-based gas payment for improved UX  

---

## Why Account Abstraction (EIP-4337)?

EIP-4337 allows user accounts to be controlled by smart contracts rather than private keys alone. This enables customizable validation logic, meta-transactions, and gas payment flexibility, greatly improving the Web3 user experience.

---

## Project Structure

- `SmartWallet.sol` — The core wallet contract implementing execute, executeBatch, and user operation validation logic.  
- `Paymaster.sol` — Contract to accept ERC20 tokens as gas payment and sponsor transactions.

---

## Getting Started

1. Compile the contracts using Solidity `^0.8.26`.  
2. Deploy `SmartWallet` by providing the owner address.  
3. Deploy the `Paymaster` contract with the ERC20 token address it accepts.  
4. Use `SmartWallet.execute()` or `executeBatch()` to call other contracts or transfer ETH/tokens.  
5. Use the `Paymaster` to pay for gas with ERC20 tokens instead of ETH.  

---

## Testing

Use Remix IDE or Hardhat to interact with and test:  
- Single and batch transactions  
- Gas payment flows via the Paymaster  
- Signature validation simulation  

---

## License

MIT License

---

## Acknowledgments

Inspired by the Ethereum Improvement Proposal [EIP-4337](https://eips.ethereum.org/EIPS/eip-4337) and related smart contract patterns.

---

Feel free to contribute or suggest improvements!

