module.exports = async function ({ getNamedAccounts, deployments }) {
  const { deploy } = deployments;

  const { deployer } = await getNamedAccounts();

  await deploy("AlunaToken", {
    from: deployer,
    log: true,
    deterministicDeployment: false,
    // args=['100000000000000000000000000']
  });
};

module.exports.tags = ["AlunaToken"];

