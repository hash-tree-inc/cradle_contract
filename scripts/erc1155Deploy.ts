import { ethers, upgrades } from "hardhat";

async function main() {
  const admin = (await ethers.provider.getSigner()).address;
  const Erc1155 = await ethers.getContractFactory("CradleAsset");
  const erc1155 = await upgrades.deployProxy(Erc1155,[admin,admin,admin,admin]);
  await erc1155.waitForDeployment();
  console.log("erc1155 deployed to:", await erc1155.getAddress());
  // 0x99dc87cc452e770C20125b2435f2e989bEdfEdD1
}

main();