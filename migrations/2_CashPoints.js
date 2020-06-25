var cashpoints = artifacts.require("CashPoints");

 module.exports = function(deployer, network, accounts) {
   // deployment steps
   deployer.deploy(cashpoints, {from: accounts[0]});
 };