// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
// Specifies the version of Solidity to use. Version 0.8.18 or higher is required.

/*
   REQUIREMENTS
   1. Your contract will have public variables that store the details about your coin (Token Name, Token Abbrv., Total Supply)
   2. Your contract will have a mapping of addresses to balances (address => uint)
   3. You will have a mint function that takes two parameters: an address and a value.
      The function then increases the total supply by that number and increases the balance 
      of the address by that amount
   4. Your contract will have a burn function, which works the opposite of the mint function, as it will destroy tokens.
      It will take an address and value just like the mint functions. It will then deduct the value from the total supply 
      and from the balance of the address.
   5. Lastly, your burn function should have conditionals to make sure the balance of the account is greater than or equal 
      to the amount that is supposed to be burned.
*/

contract MyToken {
    // Public variables to store the details about the coin
    string public name = "MyToken";   
    string public symbol = "MTK";      
    uint256 public totalSupply;      

    // Mapping to store balances of addresses
    mapping(address => uint256) public balances;

    // Mint function to increase total supply and balance of a given address
    function mint(address _to, uint256 _value) public {
        totalSupply += _value;      
        balances[_to] += _value;    
    }

    // Burn function to decrease total supply and balance of a given address
    function burn(address _from, uint256 _value) public {
        require(balances[_from] >= _value, "Insufficient balance to burn");  
        totalSupply -= _value;     
        balances[_from] -= _value; 
    }
}
