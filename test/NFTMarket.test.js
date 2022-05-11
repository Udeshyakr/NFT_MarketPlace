const { expect } = require("chai");
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat");

let owner;
let listNFT;
let buyNFTs;


describe("NFTMarket", () =>{
    it("should deploy NFTMarket contract", async ()=>{
      const[owner,addr1, buyerAddress] = await ethers.getSigners();
      //console.log(owner);
      const MangoToken = await ethers.getContractFactory("MangoToken");
      const initialSupply = BigNumber.from(1000000);
      const mangoToken = await MangoToken.deploy(initialSupply);
      await mangoToken.deployed();
      const mangoTokenAddress = mangoToken.address;
      console.log(mangoTokenAddress);

      const NFTMarket = await ethers.getContractFactory("NFTMarket");
      const nftMarket = await NFTMarket.deploy(mangoTokenAddress);
      await nftMarket.deployed();
      const nftMarketAddress = nftMarket.address;
      console.log(nftMarketAddress);

      const myEpicNFT = await ethers.getContractFactory("myEpicNFT");
      const nft = await myEpicNFT.deploy(nftMarketAddress);
      await nft.deployed();
      const nftAddress = nft.address;
      console.log(nftAddress);


      await nft.makeAnEpicNFT('ABCD');
      console.log("token Id is created with name ABCD");

      await nftMarket.connect(owner).listNFTs(nftAddress, 1, 100, 8);
      await nft.balanceOf(owner.address);
      console.log(owner.address);


      await mangoToken.connect(owner).transfer(addr1.address, 1000);
      //await mangoToken.connect(addr1).approve();
      await mangoToken.connect(addr1).approve(
        nftMarketAddress,
        BigNumber.from(1000)
        // 10000
      );
      await nft.balanceOf(owner.address);
      //await mangoToken.connect(owner).transfer(addr1.address, 1000);

      

      
      await nftMarket.connect(addr1).buyNFT(1);
      const amount = await nft.balanceOf(addr1.address);
      console.log(amount.toString());


    });

  })