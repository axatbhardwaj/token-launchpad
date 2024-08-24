// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20} from "";

contract TokenLaunchpad {

    // Token struct
    struct Token {
        address tokenAddress;
        uint256 tokenPrice;
        uint256 tokenSupply;
        uint256 tokenSold;
        uint256 tokenStart;
        uint256 tokenEnd;
        bool tokenStatus;
    }

}