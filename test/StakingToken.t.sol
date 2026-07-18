// SPDX-License-Identifier: MIT

pragma solidity 0.8.35;

import "forge-std/Test.sol";
import "../src/StakingToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract StakingTokenTest is Test {

    StackingToken stakingToken;
    string _name = "Staking Token";
    string _symbol = "STK";
    address _randomUser = vm.addr(1);

    function setUp() public {
        stakingToken = new StackingToken(_name, _symbol);
    }

    function testMint() public {
        vm.startPrank(_randomUser);
        uint256 _amount = 1 ether;

        uint256 _initialBalance = IERC20(address(stakingToken)).balanceOf(_randomUser); // UserA have 10 STK
        stakingToken.mint(_amount);
        uint256 _finalBalance = IERC20(address(stakingToken)).balanceOf(_randomUser); // UserA have 11 STK

        assert(_finalBalance - _initialBalance == _amount); // 10 STK - 11 STK = 1 STK
        vm.stopPrank();
    }

}