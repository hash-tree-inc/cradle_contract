import { ethers, upgrades } from "hardhat";

async function main() {
  const admin = (await ethers.provider.getSigner()).address;
  const Erc20 = await ethers.getContractFactory("CradleToken");
  const erc20 = await upgrades.deployProxy(Erc20,[admin,admin,admin,admin]);
  await erc20.waitForDeployment();
  console.log("erc20 deployed to:", await erc20.getAddress());
  // 0x5f1Ad6065648C31160c1D0Eb44508c08fC5e11a2
}

main();