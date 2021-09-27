const main = async () => {
  // ** Compiles contract and generates build under artifacts directory
  const nftContractFactory = await hre.ethers.getContractFactory('TheEpics');

  // ** Creates a local network and deploys the contract
  // ** This network will be destroyed when this script is done executing
  const nftContract = await nftContractFactory.deploy();

  // ** Wait until the contract is deployed on the network
  await nftContract.deployed();

  // ** Output the address of the newly deployed contract!
  console.log("Contract deployed to:", nftContract.address);

  // ** Call the mint function
  let tx = await nftContract.makeAnEpicNFT();

  // ** Wait for mint to occur
  await tx.wait();

  // ** Mint another one
  tx = await nftContract.makeAnEpicNFT();

  // ** Wait for second mint
  await tx.wait();
};

const exec = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

exec();
