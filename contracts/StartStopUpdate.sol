pragma solidity ^0.8.7;

contract StartStopUpdate {
    address owner;
    uint contractBalance;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAllMoney(address payable _to) public {
        require(_to == owner, "You are not the owner!");
        _to.transfer(contractBalance);
    }

    function getOwner() public view returns(address) {
        return owner;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getTokens() public payable {
        contractBalance += msg.value;
    }
} 