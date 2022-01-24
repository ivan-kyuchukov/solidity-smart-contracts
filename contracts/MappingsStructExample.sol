pragma solidity ^0.8.4;

contract MappingsStructExample {

    address owner;
    mapping(address => uint) public balanceReceived;

    constructor() {
        owner = msg.sender;
    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSend);
    }

    function getOwner() public view returns(address) {
        return owner;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function getTokens() public payable {
        balanceReceived[msg.sender] += msg.value;
    }
}