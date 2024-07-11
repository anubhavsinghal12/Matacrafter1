pragma solidity ^0.8.0;

contract Example {
    address public owner;
    uint public balance;
    mapping(address => uint) public deposits;

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
        deposits[msg.sender] += amount;
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= balance, "Insufficient balance");
        uint previousBalance = balance;
        balance -= amount;
        assert(balance == previousBalance - amount);
        deposits[msg.sender] -= amount;
    }

    function emergencyWithdraw() public onlyOwner {
        require(balance > 0, "Balance is already zero, nothing to withdraw");
        balance = 0;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        owner = newOwner;
    }

    function ownerDepositBalance() public view returns (uint) {
        return deposits[owner];
    }

    receive() external payable {
        balance += msg.value;
    }
}
