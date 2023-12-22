// deploy/01_deploy_my_token.js
const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {

  console.log("Starting deployment script...");

  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log('secerthash',secretHash);

  await deploy('MyToken', {
    from: deployer,
    args: [deployer], // replace with actual constructor arguments
    log: true,
  });
};
module.exports.tags = ['MyToken'];
