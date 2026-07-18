// SPDX-License-Identifier: MIT

pragma solidity 0.8.35;

import "forge-std/Test.sol";
import "../src/StakingToken.sol";
import "../src/StakingApp.sol";

contract StakingAppTest is Test {

    StackingToken stakingToken;
    StakingApp stakingApp;
    // StackingToken variables
    string _name = "Staking Token";
    string _symbol = "STK";
    // StakingApp variables
    address _owner = vm.addr(1);
    uint256 _stakingPeriod = 100000000;
    uint256 _fixedStakingAmount = 10;
    uint256 _rewardPerPeriod = 1 ether;

    function setUp() public {
        // Setup code for the test environment
        stakingToken = new StackingToken(_name, _symbol);
        stakingApp = new StakingApp(address(stakingToken), _owner, _stakingPeriod, _fixedStakingAmount, _rewardPerPeriod);
    }

    function testDepositTokens() public {
        // Test code for depositTokens function
    }

    function testWithdrawTokens() public {
        // Test code for withdrawTokens function
    }

}