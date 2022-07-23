
# NFT MarketPlace in Nutshell

NFT marketPlace is a platform where user can mint and sell NFTs.

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

```
    RINKEBY_API_URL = "https://eth-rinkeby.alchemyapi.io/v2/YOUR_API_KEY"
    PRIVATE_KEY = "YOUR-METAMASK-PRIVATE_KEY"
    ETHERSCAN_API_KEY = "YOUR-ETHERSCAN_API_KEY"
```

## NPM Packages:

 - [Openzeppelin](https://docs.openzeppelin.com/)
 - [Hardhat Ethers](https://www.npmjs.com/package/hardhat-ethers)
 - [Chai](https://www.npmjs.com/package/chai)
 - [Ethers](https://www.npmjs.com/package/ethers)
 - [ethereum-waffle](https://www.npmjs.com/package/ethereum-waffle)
 - [dotenv](https://www.npmjs.com/package/dotenv)
 - [Hardhat-Etherscan](https://www.npmjs.com/package/hardhat-etherscan)

## Tech Stack:
 - [Node](https://nodejs.org/en/)
 - [Hardhat](https://hardhat.org/tutorial/)
 - [Solidity](https://docs.soliditylang.org/en/v0.8.13)

 
## Run Locally:

Clone the github repo:
```
https://github.com/Udeshyakr/NFT_MarketPlace.git
```

Install Node Modules
```
npm install
```

Compile
```
npx hardhat compile
```

Test
```
npx hardhat test
```

Deploy
```
node scripts/deploy.js
```

Deploy on Rinkey
```
npx hardhat run scripts/deploy.js --network rinkeby
```
Help
```
npx hardhat help
```

## Check at Rinkeby Testnet:
 - [MangoToken](https://rinkeby.etherscan.io/address/0x039166EDa85333c1c19f87218C425Bc06659d25d)
 - [NFTMarket](https://rinkeby.etherscan.io/address/0xe12515E48b656cA1196b58CfEEd8cc29795D3667)
 - [myEpicNFT](https://rinkeby.etherscan.io/address/0xCCd7aaD4f40e4E41e1aF6b1056d4EB2D3E421cCd)

 


