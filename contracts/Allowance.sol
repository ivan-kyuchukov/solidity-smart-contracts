// SPDX-License-Identifier: FTL
pragma solidity ^0.8.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {

    event AllowanceChanged(address _forWho, address indexed _fromWho, uint _oldAmount, uint _newAmount);

    struct Properties {
        uint balance;
        uint allowance;
    }

    mapping(address => Properties) public addressBook;

    modifier ownerOrAllowed(uint amount) {
        require(owner() == msg.sender || addressBook[msg.sender].allowance >= amount, "You are not allowed!");
        _;
    }

    function changeAddressAllowance(address addressToChange, uint newAllowance) public onlyOwner {
        emit AllowanceChanged(addressToChange, msg.sender, addressBook[addressToChange].allowance, newAllowance);
        addressBook[addressToChange].allowance = newAllowance;
    }
}