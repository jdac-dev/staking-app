// SPDX-License-Identifier: MIT

pragma solidity 0.8.35;

import "@openzeppelin/contracts/access/Ownable.sol";


// Rules Staking
// 1. User only can stake the amount fixed by the owner of the contract
// 2. User reward is calculated by period of staking
// 3. The staking period is fixed by the owner of the contract and can be changed by the owner of the contract

contract StakingApp is Ownable {

    // Variables
    address public stakingToken;
    uint256 public stakingPeriod;

    // Events
    event SetStakingPeriod(uint256 _newStakingPeriod);

    constructor(address _stakingToken, address _owner, uint256 _stakingPeriod) Ownable(_owner) {
        stakingToken = _stakingToken;
        stakingPeriod = _stakingPeriod;
    }

    // Functions

    // External functions


    // Internal functions



    function setStakingPeriod(uint256 _newStakingPeriod) external onlyOwner {
        stakingPeriod = _newStakingPeriod;
        emit SetStakingPeriod(_newStakingPeriod);
    }
}