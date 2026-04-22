const Campaign = artifacts.require("Campaign");
const PublisherRegistry = artifacts.require("PublisherRegistry");
const RewardDistribution = artifacts.require("RewardDistribution");
const ImpressionTracking = artifacts.require("ImpressionTracking");

module.exports = async function (deployer, network, accounts) {
  // Deploy Campaign
  await deployer.deploy(Campaign);
  const campaign = await Campaign.deployed();

  // Deploy Publisher Registry
  await deployer.deploy(PublisherRegistry);

  // Deploy Impression Tracking (accounts[0] = oracle)
  await deployer.deploy(ImpressionTracking, accounts[0]);

  // Deploy Reward Distribution
  await deployer.deploy(RewardDistribution, campaign.address);
};