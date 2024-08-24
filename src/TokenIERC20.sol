// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the IERC20 interface from OpenZeppelin
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // IERC only has declarations, no implementations

// Custom errors
error InsufficientBalance(uint256 amount);
error InsufficientAllowance(uint256 amount);
error TransferFailed();

/**
 * @title TokenIERC
 * @dev Implementation of the IERC20 interface
 */
contract TokenIERC is IERC20 {
    // Public variables for token details
    string public name; // Token name
    string public symbol; // Token symbol
    uint8 public decimals; // Number of decimals the token uses
    uint256 public totalSupply; // Total supply of the token

    // Mappings to store balances and allowances
    mapping(address => uint256) public balanceOf; // Mapping from address to balance
    mapping(address => mapping(address => uint256)) public allowance; // Mapping from owner to spender to allowance

    /**
     * @dev Constructor to initialize the token with its details and assign the total supply to the deployer
     * @param name The name of the token
     * @param symbol The symbol of the token
     * @param decimals The number of decimals the token uses
     * @param totalSupply The total supply of the token
     */
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 totalSupply
    ) {
        name = name;
        symbol = symbol;
        decimals = decimals;
        totalSupply = totalSupply;
        balanceOf[msg.sender] = totalSupply; // Assign the total supply to the contract deployer
    }

    /**
     * @dev Approve a spender to spend a certain amount of tokens on behalf of the caller
     * @param spender The address of the spender
     * @param amount The amount of tokens to approve
     * @return A boolean value indicating whether the operation succeeded
     */
    function approve(
        address spender,
        uint256 amount
    ) external override returns (bool) {
        allowance[msg.sender][spender] = amount; // Set the allowance
        return true; // Return true to indicate success
    }

    /**
     * @dev Transfer tokens from the caller to a recipient
     * @param recipient The address of the recipient
     * @param amount The amount of tokens to transfer
     * @return A boolean value indicating whether the operation succeeded
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        if (balanceOf[msg.sender] < amount) {
            revert InsufficientBalance(amount); // Revert with custom error if balance is insufficient
        }
        balanceOf[msg.sender] -= amount; // Subtract the amount from the caller's balance
        balanceOf[recipient] += amount; // Add the amount to the recipient's balance
        return true; // Return true to indicate success
    }

    /**
     * @dev Transfer tokens from one address to another, using an allowance
     * @param sender The address of the sender
     * @param recipient The address of the recipient
     * @param amount The amount of tokens to transfer
     * @return A boolean value indicating whether the operation succeeded
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        if (balanceOf[sender] < amount) {
            revert InsufficientBalance(amount); // Revert with custom error if balance is insufficient
        }
        if (allowance[sender][msg.sender] < amount) {
            revert InsufficientAllowance(amount); // Revert with custom error if allowance is insufficient
        }
        balanceOf[sender] -= amount; // Subtract the amount from the sender's balance
        balanceOf[recipient] += amount; // Add the amount to the recipient's balance
        allowance[sender][msg.sender] -= amount; // Subtract the amount from the caller's allowance
        return true; // Return true to indicate success
    }
}
