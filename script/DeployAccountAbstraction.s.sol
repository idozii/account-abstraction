// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {AccountAbstraction} from "../src/AccountAbstraction.sol";
import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployAccountAbstraction is Script {
    AccountAbstraction public accountAbstraction;
    HelperConfig public helperConfig;
    
    function run() external returns(AccountAbstraction, HelperConfig) {
        helperConfig = new HelperConfig();
        vm.startBroadcast();
        accountAbstraction = new AccountAbstraction();
        vm.stopBroadcast();

        return (accountAbstraction, helperConfig);
    }
}
