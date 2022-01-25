// SPDX-License-Identifier: FTL
pragma solidity ^0.8.4;

import "./BaseContract.sol";
import "./Allowance.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract SharedWallet is Allowance, BaseContract {

    using SafeMath for uint;

    event TokensReceived(address indexed _fromWho, uint _amount);
    event TokensWithdrawn(address _byWho, address indexed _toWho, uint _amount);
    
    function withdrawTokens(address payable _to, uint tokensToWithdraw) public payable ownerOrAllowed(tokensToWithdraw) {
        require(tokensToWithdraw <= address(this).balance, "There's not enough tokens in the contract!");
        addressBook[_to].balance = addressBook[_to].balance.sub(tokensToWithdraw, "There's not enough tokens in the address balance!");
        _to.transfer(tokensToWithdraw);
        emit TokensWithdrawn(msg.sender, _to, tokensToWithdraw);
    }

    receive() external payable {
        addressBook[msg.sender].balance += msg.value;
        emit TokensReceived(msg.sender, msg.value);
    }

    function renounceOwnership() override public view onlyOwner {
        revert("Can't renounce ownership here.");
    }
}