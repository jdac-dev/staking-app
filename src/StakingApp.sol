// SPDX-License-Identifier: MIT

pragma solidity 0.8.35;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


// Rules Staking
// 1. User only can stake the amount fixed by the owner of the contract
// 2. User reward is calculated by period of staking
// 3. The staking period is fixed by the owner of the contract and can be changed by the owner of the contract

contract StakingApp is Ownable {

    // Variables
    address public stakingToken;
    uint256 public stakingPeriod;
    uint256 public fixedStakingAmount;
    uint256 public rewardPerPeriod;
    mapping(address => uint256) public userStakingBalance;
    mapping(address => uint256) public userElapsedPeriod;

    // Events
    event SetStakingPeriod(uint256 _newStakingPeriod);
    event DepositTokens(address _userAddress, uint256 _depositAmount);
    event WithdrawTokens(address _userAddress, uint256 _withdrawAmount);
    event EtherSet(uint256 _amount);

    constructor(address _stakingToken, address _owner, uint256 _stakingPeriod, uint256 _fixedStakingAmount, uint256 _rewardPerPeriod) Ownable(_owner) {
        stakingToken = _stakingToken;
        stakingPeriod = _stakingPeriod;
        fixedStakingAmount = _fixedStakingAmount;
        rewardPerPeriod = _rewardPerPeriod;
    }

    // Functions

    // External functions
    // 1. Deposit function
    function depositTokens(uint256 _tokenAmountToDeposit) external {
        require(_tokenAmountToDeposit == fixedStakingAmount, "StakingApp: Invalid deposit amount");
        require(userStakingBalance[msg.sender] == 0, "StakingApp: User already has a staking balance");

        IERC20(stakingToken).transferFrom(msg.sender, address(this), _tokenAmountToDeposit);
        userStakingBalance[msg.sender] += _tokenAmountToDeposit;
        userElapsedPeriod[msg.sender] = block.timestamp;

        emit DepositTokens(msg.sender, _tokenAmountToDeposit);
    }

    // 2. Withdraw function
    function withdrawTokens() external { // CEI Pattern
        require(userStakingBalance[msg.sender] > 0, "StakingApp: User has no staking balance");
        // require(block.timestamp >= stakingPeriod, "StakingApp: Staking period not yet completed");

        uint256 userBalance = userStakingBalance[msg.sender];
        userStakingBalance[msg.sender] = 0;

        IERC20(stakingToken).transfer(msg.sender, userBalance);

        emit WithdrawTokens(msg.sender, userBalance);
    }

    // 3. Claim function
    function claimTokens() external {
        //1. Check if user has a staking balance
        require(userStakingBalance[msg.sender] == fixedStakingAmount, "StakingApp: User has no staking balance");
        //2. Check if user has completed the staking period
        uint _elapsedPeriod = block.timestamp - userElapsedPeriod[msg.sender];
        require(_elapsedPeriod >= stakingPeriod, "StakingApp: Staking period not yet completed");
        //3. Calculate the reward amount    

        //4. Update the user's staking balance and start time
        userElapsedPeriod[msg.sender] = block.timestamp;

        //5. Transfer the reward amount to the user
        (bool success, ) = msg.sender.call{value: rewardPerPeriod}("");
        require(success, "StakingApp: Failed to transfer reward");
    }





    receive() external payable onlyOwner {
        emit EtherSet(msg.value);
    }
    //function feedContract() external payable onlyOwner {}

    function setStakingPeriod(uint256 _newStakingPeriod) external onlyOwner {
        stakingPeriod = _newStakingPeriod;
        emit SetStakingPeriod(_newStakingPeriod);
    }
}