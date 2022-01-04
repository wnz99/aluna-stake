async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const ReFi = await ethers.getContractFactory("ReFi");
  const token = await ReFi.deploy(
    "0x62A35D16E770A3A7DD7017B9544CBA8959A72c79",
    "0x83ebE709B6B9e8461A8F91A538ad5F1688fF08f0",
    ["0x901AD5cA66dc307C8635D9644dF1cb8EfcD667C0"]
  );

  console.log("ReFi address:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
