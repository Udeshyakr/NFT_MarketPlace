const hre = require('hardhat');
const { BigNumber } = require('ethers');

async function main() {
  const MangoToken = await hre.ethers.getContractFactory('MangoToken');
  const initialSupply = BigNumber.from(1000000);
  const mangoToken = await MangoToken.deploy(initialSupply);

  await mangoToken.deployed();

  console.log('mangoToken deployed to:', mangoToken.address);

  // For NFTMarket Place

  const NFTMarket = await hre.ethers.getContractFactory('NFTMarket');
  const nftMarket = await NFTMarket.deploy(mangoToken.address);

  await nftMarket.deployed();

  console.log('NFTMarket deployed to:', nftMarket.address);

  // For NFT

  const NFT = await hre.ethers.getContractFactory('myEpicNFT');
  const nft = await NFT.deploy(nftMarket.address);

  await nft.deployed();

  console.log('NFT deployed to:', nft.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });