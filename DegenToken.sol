// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

// DegenToken is an ERC-20 token with minting and burning capabilities,
// and role-based access controls to manage token operations.
contract DegenToken is ERC20, Ownable(msg.sender), AccessControl {
    // Define roles for the token
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    // Events for minting and burning tokens
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    // Constructor initializes the token with a name, symbol, and initial supply
    constructor(uint256 initialSupply) ERC20("Degen", "DGN") {
        _mint(msg.sender, initialSupply);

        // Set up roles
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // Set the deployer as the default admin
        _grantRole(MINTER_ROLE, msg.sender);        // Set the deployer as the default minter
        _grantRole(BURNER_ROLE, msg.sender);        // Set the deployer as the default burner
    }

    // Mint new tokens; only accounts with MINTER_ROLE can mint
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
        emit Mint(to, amount);
    }

    // Burn tokens from the sender's account; only accounts with BURNER_ROLE can burn
    function burn(uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }

    // Burn tokens from a specific account; only accounts with BURNER_ROLE can burn
    function burnFrom(address account, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(account, amount);
        emit Burn(account, amount);
    }

    // Grant MINTER_ROLE to an address; only the owner can call this
    function grantMinterRole(address account) public onlyOwner {
        grantRole(MINTER_ROLE, account);
    }

    // Revoke MINTER_ROLE from an address; only the owner can call this
    function revokeMinterRole(address account) public onlyOwner {
        revokeRole(MINTER_ROLE, account);
    }

    // Grant BURNER_ROLE to an address; only the owner can call this
    function grantBurnerRole(address account) public onlyOwner {
        grantRole(BURNER_ROLE, account);
    }

    // Revoke BURNER_ROLE from an address; only the owner can call this
    function revokeBurnerRole(address account) public onlyOwner {
        revokeRole(BURNER_ROLE, account);
    }
}
