// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Sample{
    uint128 public a;
    address public owner;
    mapping (address=>uint256) public acc;
    
    constructor(){
        a = 10;
        owner = msg.sender;
    }

    event Sent(address from, address to, uint amount);

    modifier ownerOnly() {
        require(msg.sender == owner,'Restricted Access');
        _;
    }

    function readValue() public view returns (uint128) {
        return a;
    }

    function appendValue(uint128 b) public ownerOnly {
        a = a + b;
    }

    function giveMoneyTo(address dest) public payable {
        acc[dest] += msg.value;
    }

    function checkBalance() public view returns (uint256) {
        return acc[msg.sender];
    }

    function withdrawMoney(uint256 amt) public payable {
        require(amt <= acc[msg.sender],'Insufficient Funds');
        acc[msg.sender] -= amt;
        payable(msg.sender).transfer(amt);
        
    }

}
