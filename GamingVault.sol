// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./GameToken.sol";

contract GamingVault {
    ERC20 public immutable token;

    struct Player {
        uint tokenBalance;
        uint score;
        uint achievements;
        uint battlesWon;
        uint explorationsCount;
        bool votingRight;
        uint playerLevel;
        string playerName;
    }
 function _mintTokens(address _to, uint _amount) private {
        totalTokens += _amount;
        players[_to].tokenBalance += _amount;
    }

    function _burnTokens(address _from, uint _amount) private {
        totalTokens -= _amount;
        players[_from].tokenBalance -= _amount;
    }
 function depositTokens(uint _amount) external {
        uint newTokens;
        if (totalTokens == 0) {
            newTokens = _amount;
        } else {
            newTokens = (_amount * totalTokens) / token.balanceOf(address(this));
        }

        _mintTokens(msg.sender, newTokens);
        token.transferFrom(msg.sender, address(this), _amount);
        updateLeaderboard();
    }

    function withdrawTokens(uint _amount) external {
        uint withdrawAmount = (_amount * token.balanceOf(address(this))) / totalTokens;
        _burnTokens(msg.sender, _amount);
        token.transfer(msg.sender, withdrawAmount);
        updateLeaderboard();
    }
 function registerPlayer(string memory _name, uint _level, uint _initialTokens) external {
        playerIdCounter++;
        address playerAddress = address(uint160(playerIdCounter));
        
        players[playerAddress] = Player(_initialTokens, 0, 0, 0, 0, false, _level, _name);
        playerAddresses.push(playerAddress);

        simulateBattles(playerAddress, 0); // Simulate 0 battle wins
        simulateExplorations(playerAddress, 0); // Simulate exploring 0 times

        updateLeaderboard();
    }

    function battle(address _opponent) external {
        require(players[msg.sender].tokenBalance > 0, "Insufficient balance");
        require(players[_opponent].tokenBalance > 0, "Opponent has insufficient balance");

        bool win = (block.timestamp % 2 == 0); // Simple condition for win
        if (win) {
            players[_opponent].battlesWon++;
            players[_opponent].score += 10;
        }
        if (players[_opponent].score >= 10) {
            players[_opponent].votingRight = true;
        }

        updateLeaderboard();
    }
    function explore() external {
        require(players[msg.sender].tokenBalance > 0, "Insufficient balance");
        uint explorationReward = 50; // Reward for exploration
        players[msg.sender].explorationsCount++;
        players[msg.sender].tokenBalance += explorationReward; // Update token balance
        updateLeaderboard();
    }

    function purchaseItem(uint _cost) external {
        require(players[msg.sender].tokenBalance >= _cost, "Insufficient balance");
        players[msg.sender].tokenBalance -= _cost; // Deduct tokens
        // Item purchase logic goes here
    }

    function transferTokens(address _recipient, uint _amount) external {
        require(players[msg.sender].tokenBalance >= _amount, "Insufficient balance");
        players[msg.sender].tokenBalance -= _amount;
        players[_recipient].tokenBalance += _amount;
    }

    function getLeaderboard() external view returns (address[] memory) {
        address[] memory sortedPlayers = new address[](playerAddresses.length);
        for (uint i = 0; i < playerAddresses.length; i++) {
            sortedPlayers[i] = playerAddresses[i];
        }
  // Sort by token balance, and if tied, by battles won
        for (uint i = 0; i < sortedPlayers.length; i++) {
            for (uint j = i + 1; j < sortedPlayers.length; j++) {
                address playerA = sortedPlayers[i];
                address playerB = sortedPlayers[j];
                if (players[playerA].tokenBalance < players[playerB].tokenBalance ||
                    (players[playerA].tokenBalance == players[playerB].tokenBalance &&
                    players[playerA].battlesWon < players[playerB].battlesWon)) {
                    address temp = sortedPlayers[i];
                    sortedPlayers[i] = sortedPlayers[j];
                    sortedPlayers[j] = temp;
                }
            }
        }
        return sortedPlayers;
    }

    function getPlayer(address _player) external view returns (Player memory) {
        return players[_player];
    }

    function removePlayer(address playerAddress) private {
        delete players[playerAddress];
        // Remove player address from playerAddresses array
        for (uint i = 0; i < playerAddresses.length; i++) {
            if (playerAddresses[i] == playerAddress) {
                playerAddresses[i] = playerAddresses[playerAddresses.length - 1];
                playerAddresses.pop();
                break;
            }
        }
    }
 function simulateBattles(address playerAddress, uint count) private {
        for (uint i = 0; i < count; i++) {
            players[playerAddress].battlesWon++;
            players[playerAddress].score += 10;
        }
        updateLeaderboard();
    }

    function simulateExplorations(address playerAddress, uint count) private {
        for (uint i = 0; i < count; i++) {
            players[playerAddress].explorationsCount++;
            uint explorationReward = 50;
            players[playerAddress].tokenBalance += explorationReward;
        }
        updateLeaderboard();
    }

    function updateLeaderboard() private {
        // Sort leaderboard
        for (uint i = 0; i < playerAddresses.length; i++) {
            for (uint j = i + 1; j < playerAddresses.length; j++) {
                if (players[playerAddresses[i]].tokenBalance < players[playerAddresses[j]].tokenBalance ||
                    (players[playerAddresses[i]].tokenBalance == players[playerAddresses[j]].tokenBalance &&
                    players[playerAddresses[i]].battlesWon < players[playerAddresses[j]].battlesWon)) {
                    address temp = playerAddresses[i];
                    playerAddresses[i] = playerAddresses[j];
                    playerAddresses[j] = temp;
                }
            }
        }
    }
}
