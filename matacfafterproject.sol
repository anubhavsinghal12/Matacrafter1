// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    address public owner;
    uint public balance;

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function deposit(uint amount) public onlyOwner {
        require(amount > 0, "Deposit amount must be greater than zero");
        balance += amount;
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= balance, "Insufficient balance");

        // Demonstrating the use of assert()
        uint oldBalance = balance;
        balance -= amount;
        assert(balance == oldBalance - amount);
    }

    function emergencyWithdraw() public onlyOwner {
        // Use revert() to abort the transaction with a custom error message
        if (balance == 0) {
            revert("Balance is already zero, nothing to withdraw");
        }

        // Reset balance to zero and transfer all funds to the owner
    
        balance = 0;
      
    }

    // Fallback function to accept Ether
    receive() external payable {
        balance += msg.value;
    }
}

