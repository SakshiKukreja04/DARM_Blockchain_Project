// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Campaign {

    struct CampaignData {
        uint id;
        address advertiser;
        uint totalBudget;
        uint remainingBudget;
        uint rewardPerClick;
        string targetingRules;
        bool isActive;
    }

    uint public campaignCount;

    mapping(uint => CampaignData) public campaigns;

    // EVENT (for logs)
    event CampaignCreated(uint id, address advertiser);
    event CampaignStatusChanged(uint id, bool status);

    // CREATE CAMPAIGN
    function createCampaign(
        uint _rewardPerClick,
        string memory _targetingRules
    ) public payable {

        require(msg.value > 0, "Budget must be greater than 0");

        campaignCount++;

        campaigns[campaignCount] = CampaignData({
            id: campaignCount,
            advertiser: msg.sender,
            totalBudget: msg.value,
            remainingBudget: msg.value,
            rewardPerClick: _rewardPerClick,
            targetingRules: _targetingRules,
            isActive: true
        });

        emit CampaignCreated(campaignCount, msg.sender);
    }

    // ACTIVATE / PAUSE CAMPAIGN
    function setCampaignStatus(uint _id, bool _status) public {
        require(msg.sender == campaigns[_id].advertiser, "Not owner");

        campaigns[_id].isActive = _status;

        emit CampaignStatusChanged(_id, _status);
    }

    // DEDUCT FUNDS (used by reward contract)
    function deductBudget(uint _id, uint amount) public {
        require(campaigns[_id].remainingBudget >= amount, "Insufficient funds");

        campaigns[_id].remainingBudget -= amount;
    }

    // GET CAMPAIGN DETAILS
    function getCampaign(uint _id) public view returns (CampaignData memory) {
        return campaigns[_id];
    }
}