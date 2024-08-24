// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {IERC20} from "../lib/openzeppelin-contracts-upgradeable/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract TokenLaunchpad {

    // Token struct
    struct Token {
        uint256 tokenPrice;
        uint256 tokenSupply;
        uint256 tokenSold;
        address tokenAddress; 
        address tokenOwner;
        bool tokenStatus;
    }

    // token ID
    uint256 public tokenID;

    //token ampping to store token details using ids
    mapping(uint256 => Token) public tokens;

    function mintToken(
        unint256 tokenPrice,
        uint256 tokenSupply,
        address tokenAddress

    )  returns (bool) {
        tokenID++;
        Token memory newToken = Token(
            tokenPrice,
            tokenSupply,
            0,
            tokenAddress,
            tx.origin,
            true
        );
        tokens[tokenID] = newToken;
        return true;
    }

    function buyToken(uint256 _tokenID, uint256 _tokenAmount) public payable {
        Token storage token = tokens[_tokenID];
        require(token.tokenStatus, "Token is not available");
        require(token.tokenSold + _tokenAmount <= token.tokenSupply, "Token is not available");
        require(msg.value == token.tokenPrice * _tokenAmount, "Invalid amount");
        IERC20(token.tokenAddress).transfer(msg.sender, _tokenAmount);
        token.tokenSold += _tokenAmount;
    }

}