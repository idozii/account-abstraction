// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {AccountAbstraction} from "../../src/AccountAbstraction.sol";
import {Test} from "forge-std/Test.sol";
import {DeployAccountAbstraction} from "../../script/DeployAccountAbstraction.s.sol";
import {Ownable} from "../../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {AggregatorV3Interface} from "../../lib/chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract AccountAbstractionTest is Test {
     AccountAbstraction public accountAbstraction;
     address public priceFeed;

     address public constant SENDER = address(1);

     function setUp() external {
         DeployAccountAbstraction deployAccountAbstraction = new DeployAccountAbstraction();
         (accountAbstraction, ) = deployAccountAbstraction.run();
         vm.deal(SENDER, 100 ether);
     }

}