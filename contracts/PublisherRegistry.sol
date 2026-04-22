// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PublisherRegistry {

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    struct Publisher {
        address wallet;
        string website;
        bool isApproved;
        bool isBlacklisted;
        uint reputationScore;
    }

    mapping(address => Publisher) public publishers;

    event PublisherRegistered(address publisher);
    event PublisherApproved(address publisher);
    event PublisherBlacklisted(address publisher);

    // REGISTER PUBLISHER
    function registerPublisher(string memory _website) public {

        publishers[msg.sender] = Publisher({
            wallet: msg.sender,
            website: _website,
            isApproved: false,
            isBlacklisted: false,
            reputationScore: 0
        });

        emit PublisherRegistered(msg.sender);
    }

    // APPROVE PUBLISHER (only admin)
    function approvePublisher(address _publisher) public {
        require(msg.sender == admin, "Only admin");

        publishers[_publisher].isApproved = true;

        emit PublisherApproved(_publisher);
    }

    // BLACKLIST PUBLISHER
    function blacklistPublisher(address _publisher) public {
        require(msg.sender == admin, "Only admin");

        publishers[_publisher].isBlacklisted = true;

        emit PublisherBlacklisted(_publisher);
    }

    // UPDATE REPUTATION
    function updateReputation(address _publisher, uint score) public {
        require(msg.sender == admin, "Only admin");

        publishers[_publisher].reputationScore = score;
    }

    // CHECK VALIDITY
    function isValidPublisher(address _publisher) public view returns (bool) {
        return (
            publishers[_publisher].isApproved &&
            !publishers[_publisher].isBlacklisted
        );
    }
}