// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract CustomToken is ERC20, Ownable (msg.sender){
    uint256 private _cap;
    uint256 private _totalBurned;

    event TokensMinted(address indexed to, uint256 amount);
    event TokensBurned(address indexed from, uint256 amount);

    constructor(uint256 cap_) ERC20("CustomToken", "CTK") {
        require(cap_ > 0, "ERC20Capped: cap is 0");
        _cap = cap_;
    }

    // Only the owner can mint tokens, with a cap
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        _mint(to, amount);
        emit TokensMinted(to, amount);
    }

    // Any user can burn their own tokens
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        _totalBurned += amount;
        emit TokensBurned(msg.sender, amount);
    }




    // Getter function for the cap
    function cap() public view returns (uint256) {
        return _cap;
    }

    // Getter function for total burned tokens
    function totalBurned() public view returns (uint256) {
        return _totalBurned;
    }
}

