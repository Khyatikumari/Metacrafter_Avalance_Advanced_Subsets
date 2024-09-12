# Metacrafter_Avalance_Advanced_Subsets
Create a DeFi Kingdom clone 🏰 using GamingVault on Avalanche. Players battle, explore, earn tokens 🪙, and rank on leaderboards. Deploy custom smart contracts with low fees, player achievements, and wallet integration.

# Description
ERC20 GameToken and Gaming_Vault are two smart contracts included in the project that are intended to allow for a decentralized gaming environment on the Avalanche blockchain. Using digital assets, players can travel, shop, and fight while winning rewards in unique tokens. Based on their badges, players are given option boards, which they can share with friends in the game.

# Configuring an EVM Subnet: A Step-by-Step Guide

a) Curl -sSfL https ://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s to deploy your EVM subnet using the Avalanche CLI Avalanche-CLI Addition to PATH:.bashrc export PATH=~/bin:$PATH Run avalanche --version to verify that your installation is working. The operating version of the tool ought should print.

b) Create a subnet in Metamask. Make sure your own EVM subnet is added to Metamask so you can connect with it. Sending events and interacting with installed smart contracts on your subnet are made possible by Metamask.

c) Verify that this is the Metamask network that you like. Switch to a custom EVM subnet for your Metamask network to ensure that all interactions and transactions take place on the appropriate network.

d) Link Remix to the Metamask. Utilize the Injected Provider service to establish a connection between the Remix IDE and Metamask. Remix may interact with your Metamask account through this connection, enabling you to launch contracts straight from the Remix UI.

e) Establish your currency. Run the GameToken.sol and Remix enter into a pact. You can use this token as in-game cash. for instance, KHYT

f) Activate Intelligent Contracts Your solid smart contract code should be copied and pasted into Remix. Gather contracts and use Remix's deployment interface to distribute them to your personalized EVM subnet.

# ERC20.sol
The ERC20.sol contract is a token contract that functions similarly to an ERC20 token and has basic features like minting or burning tokens, granting allowances, and transferring tokens. Important characteristics consist of:
Management of Tokens
The contract controls the overall amount of tokens available, keeps track of each account's balance, and oversees the allocation of funds for delegated transfers. Transfers: Through allowances, users can designate other persons to transfer tokens on their behalf or send tokens to other addresses. Burning and Minting The generation of new tokens, their addition to the caller's account, and their removal from the caller's balance are all made possible by the contract.

# Gaming_Vault.sol
The GamingVault smart contract enables players to deposit and withdraw tokens, engage in battles, explore for rewards, and purchase items. Players' achievements, token balances, and scores are tracked, with a dynamic leaderboard to rank participants. The contract also tracks voting rights, which are granted based on player performance. Players can transfer tokens to others and register new accounts with a unique name and level. Battles are simulated based on token balances, with winners gaining additional tokens and scores. Exploration rewards players with tokens to incentivize engagement. A dynamic leaderboard ranks players by token balance and battles won, ensuring competition among participants. 
Leaderboard:
Ranks players based on token balance and battles won.
Automatically updated after key actions like deposits, withdrawals, battles, and explorations.
Integration:
Uses an ERC20 token for all token-related transactions.
Players can register with unique names and initial tokens to join the game.

# Author: 
Khyati kumari

# License:
This project is licensed under the MIT License
