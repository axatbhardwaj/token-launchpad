//spdx-license-identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title TokenERC
 * @dev Implementation of the ERC20 token standard
 */
contract TokenERC is ERC20 {
    /**
     * @dev Constructor to initialize the token with its details and mint the total supply to the deployer
     * @param name The name of the token
     * @param symbol The symbol of the token
     * @param totalSupply The total supply of the token
     */
    constructor(
        string memory name, // pratikToken
        string memory symbol, //PRTK
        uint256 totalSupply // 50000000000000000000000 wie
    ) ERC20(name, symbol) {
        _mint(msg.sender, totalSupply); // Mint the total supply to the contract deployer
    }
}
