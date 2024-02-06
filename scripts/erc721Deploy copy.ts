import { ethers, upgrades } from "hardhat";

async function main() {
  const admin = (await ethers.provider.getSigner()).address;
  const Erc721 = await ethers.getContractFactory("CradleLand");
  const erc721 = await upgrades.deployProxy(Erc721,[admin,admin,admin,admin]);
  await erc721.waitForDeployment();
  console.log("erc721 deployed to:", await erc721.getAddress());
  // 0xD0015Cb815375938af6c788Dfc9bCFB924451A5d
}

main();