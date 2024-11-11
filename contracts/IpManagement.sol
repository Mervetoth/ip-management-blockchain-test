// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IpManagement {
    struct IP {
        uint id;
        address creator; // Address of the creator
        address owner; // Address of the owner
        string title; // Title of the intellectual property
        string[] keywords; // Array of keywords related to the IP
        string classification; // Classification type (e.g., type of IP)
        string description; // Description of the IP
        string documentUrl; // URL to the document representing the IP
        string status; // Status of the IP (e.g., pending, approved)
        bool visibility; // Visibility flag to determine if the IP is public or private
    }

    // Mapping to store IP ownerships
    mapping(uint => IP) public ipRecords;
    uint public ipCounter = 0; // Keeps track of the number of IPs registered

    event IPRegistered(uint indexed ipId, address indexed owner, string title);
    event IPTransferred(
        uint indexed ipId,
        address indexed from,
        address indexed to
    );

    // Function to register a new IP with an explicit owner
    function registerIP(
        address _owner, // Explicit owner
        string memory _title,
        string memory _classification,
        string memory _description,
        string memory _documentUrl,
        string memory _status,
        string[] memory _keywords
    ) public returns (uint) {
        ipCounter++; // Increment the IP counter to assign a new ID

        // Create a new IP entry
        IP storage newIP = ipRecords[ipCounter];
        newIP.id = ipCounter;
        newIP.creator = msg.sender; // Creator is the one who registers the IP
        newIP.owner = _owner; // Assign the specified owner
        newIP.title = _title;
        newIP.classification = _classification;
        newIP.description = _description;
        newIP.documentUrl = _documentUrl;
        newIP.status = _status;
        newIP.keywords = _keywords;
        newIP.visibility = true; // Default to public visibility

        emit IPRegistered(ipCounter, _owner, _title); // Emit an event for IP registration
        return ipCounter; // Return the IP ID
    }

    // Function to transfer IP rights
    function transferIP(uint ipId, address payable to) public payable {
        IP storage ip = ipRecords[ipId]; // Get the IP by ID
        require(ip.owner == msg.sender, "Only the owner can transfer this IP"); // Ensure the caller is the owner
        require(msg.value > 0, "Ether must be sent to transfer IP rights"); // Ensure Ether is sent with the transaction

        ip.owner = to; // Transfer ownership
        to.transfer(msg.value); // Transfer Ether to the new owner

        emit IPTransferred(ipId, msg.sender, to); // Emit an event for the transfer
    }

    // Function to get details of an IP by its ID
    function getIP(
        uint ipId
    )
        public
        view
        returns (
            string memory,
            address,
            address,
            string memory,
            string[] memory,
            string memory,
            string memory,
            string memory,
            bool
        )
    {
        IP memory ip = ipRecords[ipId];
        return (
            ip.title,
            ip.creator,
            ip.owner,
            ip.classification,
            ip.keywords,
            ip.description,
            ip.documentUrl,
            ip.status,
            ip.visibility
        );
    }
}
