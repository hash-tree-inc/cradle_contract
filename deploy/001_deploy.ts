import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import fs from "fs";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { getNamedAccounts, deployments, getChainId } = hre;

  const { diamond } = deployments;

  const { deployer, diamondAdmin } = await getNamedAccounts();

  await diamond.deploy("Cradle_Dev", {
    from: deployer,
    owner: diamondAdmin,
    facets: [""],
  });
  
  const networkName = deployments.getNetworkName();
  if (networkName == "test") {
    const abi = JSON.parse(
      fs.readFileSync("./deployments/test/Cradle_Dev.json", "utf8")
    ).abi;
  
    fs.writeFileSync("./Cradle_Dev.json", JSON.stringify(abi));
  } else {
    const abi = JSON.parse(
      fs.readFileSync("./deployments/live/Cradle_Dev.json", "utf8")
    ).abi;
  
    fs.writeFileSync("./Cradle_Dev.json", JSON.stringify(abi));
  }
};

export default func;