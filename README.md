# DARM_Blockchain_Project: Digital Advertising and Reward Marketplace

## Project Overview

DARM_Blockchain_Project (Digital Advertising and Reward Marketplace) is a pioneering decentralized application (dApp) built on the Ethereum blockchain. It aims to transform the traditional digital advertising landscape by introducing transparency, efficiency, and fairness through smart contracts. This platform facilitates a direct, trustless ecosystem where advertisers can launch campaigns, publishers can display ads, and users can earn rewards for their engagement, all while mitigating common issues like ad fraud and opaque data practices.

## Key Features & Benefits

DARM leverages the power of blockchain technology to deliver a robust and equitable advertising ecosystem.

### Key Features:

*   **Decentralized Campaign Management:** Advertisers can create, configure, and manage their advertising campaigns directly on the blockchain using the `Campaign.sol` smart contract, ensuring immutable and auditable campaign parameters.
*   **Transparent Impression Tracking:** The `ImpressionTracking.sol` contract provides an on-chain mechanism to record and verify ad impressions, offering unparalleled transparency and combating ad fraud.
*   **Publisher Registration & Management:** A secure `PublisherRegistry.sol` contract allows publishers to register and get verified, enabling them to participate in advertising campaigns and ensuring a trustworthy network.
*   **Automated Reward Distribution:** `RewardDistribution.sol` automates the process of allocating and distributing rewards to users and publishers based on verifiable impressions and campaign rules, ensuring fair and timely payouts.
*   **Immutable Data & Auditability:** All campaign data, impressions, and reward distributions are recorded on the blockchain, providing a complete, immutable, and auditable history.

### Benefits:

*   **Enhanced Transparency:** Eliminates intermediaries and provides a clear view of campaign performance and reward distribution.
*   **Reduced Fraud:** Blockchain's inherent security features significantly reduce click fraud, impression fraud, and other malicious activities.
*   **Fair Compensation:** Ensures that publishers and users are equitably compensated for their contributions without hidden fees or delays.
*   **Increased Trust:** Fosters a trustworthy environment for advertisers, publishers, and users alike through verifiable actions and immutable records.
*   **Cost Efficiency:** Streamlines processes and reduces overheads typically associated with traditional ad networks.

## Prerequisites & Dependencies

To set up and run the DARM_Blockchain_Project locally, you will need the following software and tools:

*   **Node.js:** A JavaScript runtime environment (LTS version recommended).
    *   [Download Node.js](https://nodejs.org/en/download/)
*   **npm (Node Package Manager) or Yarn:** Package manager for Node.js projects (npm comes with Node.js).
*   **Truffle Suite:** A world-class development environment for Ethereum.
    *   Install globally: `npm install -g truffle`
*   **Ganache:** A personal Ethereum blockchain for development and testing.
    *   [Download Ganache](https://trufflesuite.com/ganache/)
*   **A Code Editor:** Visual Studio Code is highly recommended for Solidity and JavaScript development.
    *   [Download VS Code](https://code.visualstudio.com/)

## Installation & Setup Instructions

Follow these steps to get your local development environment for DARM up and running:

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/SakshiKukreja04/DARM_Blockchain_Project.git
    cd DARM_Blockchain_Project
    ```

2.  **Install Node.js Dependencies:**
    Install all required Node.js packages for the project.
    ```bash
    npm install
    ```
    *(If you prefer Yarn, you can use `yarn install`)*

3.  **Start Ganache:**
    Launch the Ganache desktop application or run `ganache-cli` in your terminal. Ensure it's running on a port (default is `7545`) that matches your `truffle-config.js` settings.

4.  **Compile Smart Contracts:**
    Navigate to the project root directory in your terminal and compile the Solidity contracts.
    ```bash
    truffle compile
    ```

5.  **Migrate Smart Contracts:**
    Deploy the compiled contracts to your local Ganache blockchain.
    ```bash
    truffle migrate --reset
    ```
    This will execute the deployment scripts located in the `migrations/` directory.

6.  **Run Tests (Optional but Recommended):**
    To ensure everything is working as expected, run the included tests.
    ```bash
    truffle test
    ```

You have now successfully set up the DARM_Blockchain_Project on your local machine!

## Usage Examples & API Documentation

After deploying the contracts, you can interact with them using the Truffle Console or integrate them into a frontend application.

### Interacting via Truffle Console:

1.  **Launch Truffle Console:**
    ```bash
    truffle console
    ```

2.  **Get Contract Instances:**
    Inside the console, you can retrieve deployed contract instances:
    ```javascript
    const Campaign = artifacts.require("Campaign");
    const PublisherRegistry = artifacts.require("PublisherRegistry");
    const RewardDistribution = artifacts.require("RewardDistribution");
    const ImpressionTracking = artifacts.require("ImpressionTracking");

    const campaignInstance = await Campaign.deployed();
    const publisherRegistryInstance = await PublisherRegistry.deployed();
    const rewardDistributionInstance = await RewardDistribution.deployed();
    const impressionTrackingInstance = await ImpressionTracking.deployed();

    console.log("Campaign Address:", campaignInstance.address);
    console.log("PublisherRegistry Address:", publisherRegistryInstance.address);
    // ... and so on for other contracts
    ```

3.  **Example Usage - Campaign Creation:**
    You can call functions on the deployed contracts. For instance, to create a campaign:
    ```javascript
    // Assuming the first account from Ganache is the advertiser
    const accounts = await web3.eth.getAccounts();
    const advertiser = accounts[0];

    // Create a new campaign (e.g., "Summer Sale" with a budget of 1 Ether and target 1000 impressions)
    // Note: Amount should be in Wei (1 Ether = 1e18 Wei)
    await campaignInstance.createCampaign("Summer Sale 2024", "Promoting summer products.", web3.utils.toWei("1", "ether"), 1000, { from: advertiser });

    const campaignCount = await campaignInstance.getCampaignCount();
    console.log("Total Campaigns:", campaignCount.toNumber());

    const campaignDetails = await campaignInstance.getCampaign(1); // Assuming campaign ID is 1
    console.log("Campaign 1 Details:", campaignDetails);
    ```

4.  **Example Usage - Publisher Registration:**
    ```javascript
    // Register a new publisher
    const publisher = accounts[1]; // Using a different account for publisher
    await publisherRegistryInstance.registerPublisher("MyAwesomeBlog.com", "publisher@example.com", { from: publisher });

    const isRegistered = await publisherRegistryInstance.isPublisherRegistered(publisher);
    console.log("Is publisher registered?", isRegistered);
    ```

These examples demonstrate basic interactions. A full-fledged dApp would involve a web frontend (e.g., React, Vue, Angular) using libraries like Web3.js or Ethers.js to interact with these smart contracts from a user's browser (e.g., via MetaMask).

## Configuration Options

The primary configuration file for this project is `truffle-config.js`.

### `truffle-config.js`

This file allows you to define various settings for your Truffle project, including:

*   **Network Configuration:** Define different Ethereum networks (e.g., `development` for Ganache, `ropsten` for public testnets, `mainnet`). For each network, you can specify the host, port, network ID, gas limit, and gas price.
    ```javascript
    module.exports = {
      networks: {
        development: {
          host: "127.0.0.1",     // Localhost (default: none)
          port: 7545,            // Standard Ganache port (default: none)
          network_id: "*",       // Any network (default: none)
        },
        // ropsten: {
        //   provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/YOUR_INFURA_PROJECT_ID`),
        //   network_id: 3,       // Ropsten's id
        //   gas: 5500000,        // Ropsten has a lower block limit than mainnet
        //   confirmations: 2,    // # of confs to wait between deployments. (default: 0)
        //   timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
        //   skipDryRun: true     // Skip dry run if it's too large to fit in a single tx
        // },
      },
      // ... other configurations
    };
    ```
    *   **External Networks:** The commented-out `ropsten` configuration shows how to connect to public testnets using `HDWalletProvider` and Infura. You would need to set `mnemonic` and `YOUR_INFURA_PROJECT_ID` as environment variables for security.
*   **Solidity Compiler Settings:**
    Specify the Solidity compiler version and optimizer settings.
    ```javascript
    compilers: {
      solc: {
        version: "0.8.19",    // Fetch exact version from solc-bin (default: truffle's version)
        // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
        settings: {          // See the solidity docs for advice about optimization
          optimizer: {
            enabled: true,
            runs: 200
          },
          evmVersion: "london" // or "berlin", "istanbul", etc.
        }
      }
    },
    ```
*   **Migration Files:** The `migrations/` directory contains JavaScript files that define the deployment order and logic for your smart contracts. `1_initial_migration.js` deploys the `Migrations` contract, and `2_deploy_contracts.js` deploys the core project contracts.

## Contributing Guidelines

We welcome contributions to the DARM_Blockchain_Project! If you're interested in improving the platform, please follow these guidelines:

1.  **Fork the Repository:** Start by forking the `DARM_Blockchain_Project` repository to your GitHub account.
2.  **Create a New Branch:** Create a new branch for your feature or bug fix. Use a descriptive name (e.g., `feature/add-reward-token` or `fix/impression-bug`).
    ```bash
    git checkout -b feature/your-feature-name
    ```
3.  **Make Your Changes:** Implement your feature or fix the bug. Ensure your code adheres to existing coding standards.
4.  **Write Tests:** For any new features or bug fixes, please add appropriate unit tests to the `test/` directory to ensure reliability.
5.  **Run Tests:** Before submitting, make sure all tests pass: `truffle test`.
6.  **Commit Your Changes:** Write clear, concise commit messages.
    ```bash
    git commit -m "feat: Add new reward token functionality"
    ```
7.  **Push to Your Fork:** Push your new branch to your forked repository.
    ```bash
    git push origin feature/your-feature-name
    ```
8.  **Open a Pull Request:** Create a pull request from your branch to the `main` branch of the original repository. Provide a detailed description of your changes and why they are necessary.

Your contributions help make DARM_Blockchain_Project better for everyone!

## License Information

This project currently **does not have an explicit open-source license specified**. By default, this implies "All Rights Reserved" in many jurisdictions, meaning that redistribution, modification, and commercial use are restricted.

For explicit licensing terms or to request permissions, please contact the repository owner, SakshiKukreja04.

It is highly recommended that a suitable open-source license (e.g., MIT, Apache 2.0, GPL) be added to the repository for clarity and to encourage broader community contributions and usage.

## Acknowledgments

We extend our gratitude to the following tools and resources that made this project possible:

*   **Truffle Suite:** For providing an excellent development framework for Ethereum.
*   **Solidity:** The foundational language for smart contract development.
*   **Ethereum Community:** For continuous innovation and resources in the blockchain space.
*   The conceptual design and initial ideas derived from the `CBDL_PPT (1).pdf` document within the repository.
