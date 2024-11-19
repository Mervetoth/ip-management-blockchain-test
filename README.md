
# Documentation: Deploying and Managing the IP Management Smart Contract

This report provides a step-by-step guide on compiling, deploying, and interacting with the `IpManagement` smart contract. It includes all commands executed using `Truffle`.

---

## **1. Compile the Smart Contract**

Run the following command to compile the smart contract:

```bash
PS D:\5sae2\stage ete\ip-management-blockchain-test> npx truffle compile
```

Output:
- Contracts compiled successfully, and artifacts are stored in the `build/contracts` directory.

---

## **2. Deploy the Smart Contract**

Deploy the contract to the development blockchain:

```bash
PS D:\5sae2\stage ete\ip-management-blockchain-test> npx truffle migrate --reset
```

Output:
- `IpManagement` contract deployed successfully with details, including the contract address.

---

## **3. Open Truffle Console**

To interact with the smart contract:

```bash
PS D:\5sae2\stage ete\ip-management-blockchain-test> truffle console --network development
```

---

## **4. Interact with the Contract**

### **Step 1: Get the Deployed Instance**
```javascript
const ipManagement = await IpManagement.deployed();
```

### **Step 2: Set Owner Address (Account[0])**
```javascript
const owner = (await web3.eth.getAccounts())[0];
```

### **Step 3: Register a New IP**
Register a new IP titled *"blockchain-ip-management-system-summer-internship"*:

```javascript
const ipId = await ipManagement.registerIP(
    owner, 
    "blockchain-ip-management-system-summer-internship", 
    "Blockchain", 
    "A system for managing IPs using blockchain for summer internship project.", 
    "https://example.com/document", 
    "pending", 
    ["blockchain", "management", "internship"], 
    { from: owner }
);
```

### **Step 4: Transfer the IP to Account[5]**
Transfer ownership of the IP to account[5], including a payment of `0.1 Ether`:

```javascript
await ipManagement.transferIP(
    ipId.logs[0].args.ipId.toNumber(), 
    (await web3.eth.getAccounts())[5], 
    { from: (await web3.eth.getAccounts())[0], value: web3.utils.toWei("0.1", "ether") }
);
```

---

## **5. Additional Tests**

### **Attempting Invalid Transfer**
Trying to transfer the IP again from the original owner results in an error:

```javascript
await ipManagement.transferIP(
    ipId.logs[0].args.ipId.toNumber(), 
    (await web3.eth.getAccounts())[8], 
    { from: (await web3.eth.getAccounts())[0], value: web3.utils.toWei("30", "ether") }
);
// Error: Only the owner can transfer this IP
```

### **Valid Transfer from Current Owner**
Transfer the IP from account[5] to account[8]:

```javascript
await ipManagement.transferIP(
    ipId.logs[0].args.ipId.toNumber(), 
    (await web3.eth.getAccounts())[8], 
    { from: (await web3.eth.getAccounts())[5], value: web3.utils.toWei("30", "ether") }
);
```

---

## **Summary**
- **Contract Deployment**: Successful
- **IP Registered**: *blockchain-ip-management-system-summer-internship* by account[0]
- **Ownership Transfers**:
  1. From account[0] to account[5] with `0.1 Ether`
  2. From account[5] to account[8] with `30 Ether`

The smart contract and ownership management processes function as expected.
