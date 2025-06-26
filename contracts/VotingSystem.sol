// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VotingSystem {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public admin;
    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    bool public votingEnded;

    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
        votingEnded = false;
    }

    // Function 1: Vote for a candidate
    function vote(uint candidateIndex) public {
        require(!votingEnded, "Voting has ended.");
        require(!hasVoted[msg.sender], "You have already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate.");

        candidates[candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    // Function 2: Get total candidates
    function getCandidateCount() public view returns (uint) {
        return candidates.length;
    }

    // Function 3: End voting (Admin only)
    function endVoting() public {
        require(msg.sender == admin, "Only admin can end the voting.");
        votingEnded = true;
    }

    // Function 4: Get winner
    function getWinner() public view returns (string memory winnerName) {
        require(votingEnded, "Voting is still ongoing.");
        uint maxVotes = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = candidates[winnerIndex].name;
    }
}
