// SPDX-License-Identifier: MIT

pragma solidity 0.8.35;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StackingToken is ERC20 {

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(uint256 _amount) external {
        _mint(msg.sender, _amount);
    }

}