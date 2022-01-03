async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const AlunaStake = await ethers.getContractFactory("AlunaStake");
  const token = await AlunaStake.deploy(
    "0x0C8c86d11650e3C72356045A518B7Cd1DBacD3e6"
  );

  console.log("Aluna Stake address:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
