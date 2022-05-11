const { expect } = require("chai");
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat");

describe("MangoToken", function (){
    it("should return correct Symbol", async ()=>{
      const [owner] = await ethers.getSigners();
      console.log(owner);
      const MangoToken = await ethers.getContractFactory("MangoToken");
      const initialSupply = BigNumber.from(1000000);
      const mangoToken = await MangoToken.deploy(initialSupply);
      await mangoToken.deployed();
      const ownerBalance = await mangoToken.balanceOf(owner.address);
      expect(await mangoToken.totalSupply()).to.equal(ownerBalance);
      console.log(ownerBalance);
      expect(await mangoToken.symbol()).to.equal("Mango");

    });

    it("should return correct name", async() =>{
      const MangoToken = await ethers.getContractFactory("MangoToken");
      const initialSupply = BigNumber.from(1000000);
      const mangoToken = await MangoToken.deploy(initialSupply);
      await mangoToken.deployed();

      expect(await mangoToken.name()).to.equal("MangoToken");
    })
  })