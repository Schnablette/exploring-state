// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const addresses = ([
    deployer,
    addr1,
    addr2,
    addr3,
    addr4,
    addr5,
    addr6,
    addr7,
    addr8,
    addr9,
    addr10,
  ] = await hre.ethers.getSigners());

  const MAA = await hre.ethers.getContractFactory("MappingsAndArrays");
  const maa = await MAA.deploy();

  await maa.deployed();

  console.log("MappingsAndArrays deployed to: ", maa.address);

  for (i = 0; i < 11; i++) {
    if (i != 0) {
      await maa.connect(addresses[i]).storeInArray(i);
      await maa.connect(addresses[i]).storeInMapping(i);
    }
  }

  maa.storeInArray(1524);
  maa.storeInMapping(1524);

  maa.updateArray(24);
  maa.updateMapping(24);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
