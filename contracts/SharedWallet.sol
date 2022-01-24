pragma solidity ^0.8.4;

contract SharedWallet {

    struct Properties {
        uint balance;
        uint allowance;
        uint remainingAllowance;
    }

    address owner;
    mapping(address => Properties) private addressBook;

    event MyEvent(address from, address to, uint tokens);

    constructor() {
        owner = msg.sender;
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getAddressBalance(address addressToCheck) public view returns (uint) {
        return addressBook[addressToCheck].balance;
    }

    function sendTokens() public payable {
        addressBook[msg.sender].balance += msg.value;
    }

    function withdrawTokens(address payable _to, uint tokensToWithdraw) public {
        bool isOwner = _to == owner;
        uint allowance = isOwner ? address(this).balance : addressBook[_to].allowance;
        require(tokensToWithdraw <= addressBook[_to].balance, "Insufficient balance!");
        require(tokensToWithdraw <= allowance, "You are not allowed to withdraw that amount!");

        emit MyEvent(msg.sender, _to, 123);

        if (addressBook[_to].remainingAllowance - tokensToWithdraw <= 0) {
            addressBook[_to].remainingAllowance = 0;
        }
        else {
            addressBook[_to].remainingAllowance -= tokensToWithdraw;
        }
         

        addressBook[_to].balance -= tokensToWithdraw;
        _to.transfer(tokensToWithdraw);
    }

    function changeAddressAllowance(address addressToChange, uint newAllowance) public {
        require(msg.sender == owner, "You're not the owner!");
        addressBook[addressToChange].remainingAllowance = newAllowance;
        addressBook[addressToChange].allowance = newAllowance;
    }

}