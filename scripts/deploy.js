const hre = require("hardhat");

async function main() {
  const BlockCerts = await hre.ethers.getContractFactory("BlockCerts");
  const blockCerts = await BlockCerts.deploy();

  await blockCerts.deployed();

  console.log("BlockCerts deployed to:", blockCerts.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
