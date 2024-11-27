// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployAccountAbstraction} from "../../script/DeployAccountAbstraction.s.sol";
import {AccountAbstraction} from "../../src/AccountAbstraction.sol";
import {EstimateAndSetGasFee} from "../../script/Interaction.s.sol";
import {SetPaymasterAndDataAndSign} from "../../script/Interaction.s.sol";

contract InteractionTest is Test {
    AccountAbstraction public accountAbstraction;
    EstimateAndSetGasFee public estimateAndSetGasFee;
    SetPaymasterAndDataAndSign public setPaymasterAndDataAndSign;

    address public constant SENDER = address(0);

    function setUp() external {
        DeployAccountAbstraction deployAccountAbstraction = new DeployAccountAbstraction();
        (accountAbstraction, ) = deployAccountAbstraction.run();
        estimateAndSetGasFee = new EstimateAndSetGasFee();
        setPaymasterAndDataAndSign = new SetPaymasterAndDataAndSign();
        vm.deal(SENDER, 100 ether);
    }

    function test_can_estimate_gas_and_set_gas_fee() public{
        estimateAndSetGasFee.run();
        assertEq(accountAbstraction.userOp.callGasLimit, 100000);
        assertEq(accountAbstraction.userOp.verificationGasLimit, 100000);
        assertEq(accountAbstraction.userOp.preVerificationGas, 100000);
        assertEq(accountAbstraction.userOp.maxFeePerGas, 100000);
        assertEq(accountAbstraction.userOp.maxPriorityFeePerGas, 100000);
    }

    function test_can_set_paymaster_and_data_and_sign() public {
        setPaymasterAndDataAndSign.run();
        assertEq(accountAbstraction.userOp.paymasterAndData, "0x");
        assertEq(accountAbstraction.userOp.signature, "0x");
    }
}