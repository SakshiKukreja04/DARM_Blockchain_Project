// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ImpressionTracking {

    address public oracle;   // trusted verifier

    struct ClickData {
        bytes32 clickHash;
        uint campaignId;
        uint timestamp;
    }

    mapping(bytes32 => bool) public recordedClicks; // prevent duplicates
    ClickData[] public clicks;

    event ClickRecorded(bytes32 clickHash, uint campaignId, uint timestamp);

    constructor(address _oracle) {
        oracle = _oracle;
    }

    modifier onlyOracle() {
        require(msg.sender == oracle, "Only oracle can call");
        _;
    }

    function recordClick(
        bytes32 _clickHash,
        uint _campaignId
    ) public onlyOracle {

        require(!recordedClicks[_clickHash], "Duplicate click");

        recordedClicks[_clickHash] = true;

        clicks.push(ClickData({
            clickHash: _clickHash,
            campaignId: _campaignId,
            timestamp: block.timestamp
        }));

        emit ClickRecorded(_clickHash, _campaignId, block.timestamp);
    }

    function getTotalClicks() public view returns (uint) {
        return clicks.length;
    }
}