# IP Management Blockchain Test

This project is a testing environment for blockchain-based Intellectual Property (IP) Management, enabling the registration and transfer of IP ownership on the blockchain.

## Prerequisites

- [Node.js and npm](https://nodejs.org/en/download/)
- [Truffle](https://www.trufflesuite.com/truffle): Install globally with `npm install -g truffle`
- [Ganache](https://www.trufflesuite.com/ganache) for local blockchain testing

## Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Mervetoth/ip-management-blockchain-test.git
   cd ip-management-blockchain-test
   ```

2. **Install Dependencies**:
   ```bash
   npm install
   ```

## Commands

### Compile Contracts

Compiles Solidity contracts, generating the ABI and bytecode:

```bash
npx truffle compile
```

### Deploy Contracts

Deploys contracts to the blockchain. `--reset` ensures a fresh deployment:

```bash
npx truffle migrate --reset
```

### Register IP on the Blockchain

Use the following in the Truffle console to register IP:

```javascript
let keywords = ["art", "digital", "painting"];
let result = await instance.registerIP(
    "0x5564d20c5B1A68B66EaAF8664839ff219E08273",  // Owner address
    "Digital Art Piece",                         // Title
    "Artwork",                                   // Category
    "A beautiful digital painting.",             // Description
    "https://example.com/artwork",               // URL
    keywords,                                    // Keywords
    "approved",                                  // Status
    { from: accounts[0] }
);

let ipId = result.logs[0].args.ipId.toNumber();  // Get unique IP ID
```

### Transfer IP Ownership

Transfer IP to another account with a transaction fee:

```javascript
await instance.transferIP(ipId, accounts[1], { 
    from: "0x5564d20c5B1A68B66EaAF8664839ff219E08273", 
    value: web3.utils.toWei('75', 'ether') 
});
```

## Running the Project

To start, open the Truffle console:

```bash
npx truffle console
```

From the console, use the commands above to interact with the contracts.
