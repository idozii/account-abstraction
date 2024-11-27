// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AccountAbstraction {
    struct UserOperation {
        address sender;
        uint256 nonce;
        bytes initCode;
        bytes callData;
        uint256 callGasLimit;
        uint256 verificationGasLimit;
        uint256 preVerificationGas;
        uint256 maxFeePerGas;
        uint256 maxPriorityFeePerGas;
        bytes paymasterAndData;
        bytes signature;
    }

    UserOperation public userOp;

    function constructUserOperation(
        address _sender,
        uint256 _nonce,
        bytes memory _initCode,
        bytes memory _callData
    ) public {
        userOp.sender = _sender;
        userOp.nonce = _nonce;
        userOp.initCode = _initCode;
        userOp.callData = _callData;
    }

    function estimateGas(
        uint256 _callGasLimit,
        uint256 _verificationGasLimit,
        uint256 _preVerificationGas
    ) public {
        userOp.callGasLimit = _callGasLimit;
        userOp.verificationGasLimit = _verificationGasLimit;
        userOp.preVerificationGas = _preVerificationGas;
    }

    function setPaymasterAndData(bytes memory _paymasterAndData) public {
        userOp.paymasterAndData = _paymasterAndData;
    }

    function setGasFees(
        uint256 _maxFeePerGas,
        uint256 _maxPriorityFeePerGas
    ) public {
        userOp.maxFeePerGas = _maxFeePerGas;
        userOp.maxPriorityFeePerGas = _maxPriorityFeePerGas;
    }

    function signUserOperation(bytes memory _signature) public {
        userOp.signature = _signature;
    }

    function getUserOperation() public view returns (UserOperation memory) {
        return userOp;
    }

}