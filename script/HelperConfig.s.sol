// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {Constants} from "../script/Constants.sol";
import {MockV3Aggregator} from "@chainlink/contracts/src/v0.8/tests/MockV3Aggregator.sol";

contract HelperConfig is Script, Constants {
     error HelperConfig__InvalidChainID();
     struct NetWorkConfig {
          address priceFeed;
     }

     NetWorkConfig public localNetWorkConfig;
     mapping(uint256 => NetWorkConfig) public s_networkConfig;

     constructor() {
          s_networkConfig[sepoliaID] = getSepoliaNetWorkConfig();
     }

     function getSepoliaNetWorkConfig() public pure returns(NetWorkConfig memory) {
          return NetWorkConfig({
               priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
          });
     }

     function getBNBNetWorkConfig() public pure returns(NetWorkConfig memory) {
          return NetWorkConfig({
               priceFeed: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
          });
     }

     function getAnvilNetWorkConfig() public returns(NetWorkConfig memory) {
          vm.startBroadcast();
          MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(DECIMALS, PRICE);
          vm.stopBroadcast();
          localNetWorkConfig = NetWorkConfig({
               priceFeed: address(mockV3Aggregator)
          });
          return localNetWorkConfig;
     }

     function getNetWorkConfig(uint256 chainID) public returns(NetWorkConfig memory) {
          if(s_networkConfig[chainID].priceFeed != address(0)) {
               return s_networkConfig[chainID];
          } else if (chainID == anvilID) {
               return getAnvilNetWorkConfig();     
          } else if (chainID == bnbID) {
               return getBNBNetWorkConfig();
          } else {
               revert HelperConfig__InvalidChainID();
          }
     }
}