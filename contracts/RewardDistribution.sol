// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RewardDistribution {

    address public admin;
    address public campaignContract;

    constructor(address _campaignContract) {
        require(_campaignContract != address(0), "Invalid campaign address");
        admin = msg.sender;
        campaignContract = _campaignContract;
    }

    event RewardPaid(address user, address publisher, uint amount);

    function distributeReward(
        address payable user,
        address payable publisher
    ) public payable {

        require(msg.value > 0, "Send ETH to distribute");

        uint totalReward = msg.value;

        uint userShare = (totalReward * 70) / 100;
        uint publisherShare = (totalReward * 30) / 100;

        user.transfer(userShare);
        publisher.transfer(publisherShare);

        emit RewardPaid(user, publisher, totalReward);
    }
}