pragma solidity ^0.8.7;

contract StartStopUpdate {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAllMoney(address payable _to) public {
        require(_to == owner, "You are not the owner!");
    }

    function getOwner() public view returns(address) {
        return owner;
    }
} 