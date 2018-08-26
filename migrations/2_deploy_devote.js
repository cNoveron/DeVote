var DeVote = artifacts.require("DeVote");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(DeVote,accounts[0],accounts[1])
}