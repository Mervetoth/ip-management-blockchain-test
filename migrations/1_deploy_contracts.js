const ConvertLib = artifacts.require("ConvertLib");
const IpManagement = artifacts.require("IpManagement");

module.exports = function (deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, IpManagement);
  deployer.deploy(IpManagement);
};
