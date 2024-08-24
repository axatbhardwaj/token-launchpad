//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {TokenIERC} from "./TokenIERC20.sol";
contract TokenLaunchpad {
    // Event to log the creation of a new token
    event TokenCreated(address indexed tokenAddress, string name, string symbol, uint8 decimals, uint256 totalSupply);

    /**
     * @dev Function to create a new token using the TokenIERC contract
     * @param name The name of the token
     * @param symbol The symbol of the token
     * @param decimals The number of decimals the token uses
     * @param totalSupply The total supply of the token
     * @return The address of the newly created token
     */
    function createToken(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 totalSupply
    ) external returns (address) {
        TokenIERC token = new TokenIERC(name, symbol, decimals, totalSupply); // Create a new token
        emit TokenCreated(address(token), name, symbol, decimals, totalSupply); // Emit an event to log the creation of a new token
        return address(token); // Return the address of the newly created token
    }
}