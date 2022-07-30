// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const [deployer, addr1, addr2, addr3, addr4, addr5] =
    await hre.ethers.getSigners();

  const Parent = await hre.ethers.getContractFactory("Parent");
  const parent = await Parent.deploy("ParentContract");

  await parent.deployed();

  console.log("PARENT DEPLOYED TO: ", parent.address);

  await parent.connect(addr1).createChild("firstChild");

  const firstChild = await parent.children(0);

  console.log("FIRSTCHILD DEPLOYED TO: ", firstChild);

  await parent.connect(addr2).donate({ value: ethers.utils.parseEther("1") });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
