// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    struct Voter {
        bool hasVoted;
        uint choice;
    }

    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    address public owner;

    constructor(string[] memory candidateNames) {
        owner = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({name: candidateNames[i], voteCount: 0}));
        }
    }

    function vote(uint candidateIndex) public {
        require(!voters[msg.sender].hasVoted, "Already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate.");

        voters[msg.sender] = Voter({hasVoted: true, choice: candidateIndex});
        candidates[candidateIndex].voteCount++;
    }

    function getResults() public view returns (string[] memory names, uint[] memory votes) {
        names = new string[](candidates.length);
        votes = new uint[](candidates.length);
        for (uint i = 0; i < candidates.length; i++) {
            names[i] = candidates[i].name;
            votes[i] = candidates[i].voteCount;
        }
        return (names, votes);
    }
}
