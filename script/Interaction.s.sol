// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {AccountAbstraction} from "../src/AccountAbstraction.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract EstimateAndSetGasFee is Script {
    function estimateGas(address accountAbstraction) public {
        vm.startBroadcast();   
        AccountAbstraction(payable(accountAbstraction)).estimateGas(100000, 100000, 100000);
        vm.stopBroadcast();
    }

    function setGasFee(address accountAbstraction) public {
        vm.startBroadcast();
        AccountAbstraction(payable(accountAbstraction)).setGasFees(100000, 100000);
        vm.stopBroadcast();
    }

    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment("AccountAbstraction", block.chainid);
        estimateGas(contractAddress);
        setGasFee(contractAddress);
    }
}

contract SetPaymasterAndDataAndSign is Script {
    function setPaymasterAndData(address accountAbstraction) public {
        vm.startBroadcast();
        AccountAbstraction(payable(accountAbstraction)).setPaymasterAndData("0x");
        vm.stopBroadcast();
    }

    function signUserOperation(address accountAbstraction) public {
        vm.startBroadcast();
        AccountAbstraction(payable(accountAbstraction)).signUserOperation("0x");
        vm.stopBroadcast();
    }

    function run() external {
        address contractAddress = DevOpsTools.get_most_recent_deployment("AccountAbstraction", block.chainid);
        setPaymasterAndData(contractAddress);
        signUserOperation(contractAddress);
    }
}