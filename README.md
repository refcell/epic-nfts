# Epic NFTS

```
🚨​ Epic NFTs not deployed on Mainnet 🚨​
🚨​ Only deployed on Rinkeby Test network 🚨​
```

Main contract is: `contracts/WavePortal.sol`

Contract ABI is generated at `artifacts/contracts/WavePortal.sol/WavePortal.json`

Account configuration for deployment is handled with environment variables.
Create a `.env` file in the base directory with the same variables as `.env.example`, but with values filled in.

### Compiling

```bash
npx hardhat compile
```

### Testing

```bash
npx hardhat test
```

### Mock Deploying

Run:

```bash
npx hardhat run scripts/run.js
```

### Deploying

Run:

```bash
npx hardhat run scripts/deploy.js --network rinkeby
```