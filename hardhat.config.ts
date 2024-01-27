import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import "dotenv/config";
import '@openzeppelin/hardhat-upgrades';

const config: HardhatUserConfig = {
  solidity: {
    version:"0.8.22",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200,
    },
  }
  },
  namedAccounts: {
    deployer: 0,
  },
  networks: {
    live: {
      url: process.env.KLAYTN_NODE_MAIN_ENDPOINT,
      accounts: [process.env.LIVE_PRIV_KEY || ""],
      chainId: 8217,
      gasPrice: 25000000000,
    },
    test: {
      url: process.env.KLAYTN_NODE_TEST_ENDPOINT,
      accounts: [process.env.TEST_PRIV_KEY || ""],
      chainId: 1001,
      gasPrice: 25000000000,
    },
  },
};

export default config;
