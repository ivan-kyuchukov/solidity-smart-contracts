// SPDX-License-Identifier: FTL
pragma solidity ^0.8.4;

contract BaseContract {

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}