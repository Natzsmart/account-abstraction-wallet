
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

/// @title SmartWallet simulating EIP-4337 functionality with bonus features
contract SmartWallet {
    address public owner;
    uint256 public nonce;

    constructor(address _owner) {
        owner = _owner;
        nonce = 0;
    }

    /// @notice Execute a single call from the wallet
    function execute(address to, uint256 value, bytes calldata data) external {
        require(msg.sender == owner, "Only owner can execute");
        nonce++;

        (bool success, ) = to.call{value: value}(data);
        require(success, "Call failed");
    }

    /// @notice Batch multiple calls in one transaction
    function executeBatch(address[] calldata targets, bytes[] calldata data) external {
        require(msg.sender == owner, "Only owner can execute");
        require(targets.length == data.length, "Mismatched inputs");
        nonce++;

        for (uint256 i = 0; i < targets.length; i++) {
            (bool success, ) = targets[i].call(data[i]);
            require(success, "Batch call failed");
        }
    }

    /// @notice Simulate signature validation
    function validateUserOp(bytes32 userOpHash, bytes calldata signature) external view returns (bool) {
        return keccak256(abi.encodePacked(owner, userOpHash)) == keccak256(signature);
    }

    receive() external payable {}
}

/// @title Paymaster supporting ERC20 gas payments
contract Paymaster {
    event GasSponsored(address indexed user, uint256 gasUsed, address token, uint256 amount);

    address public acceptedToken;
    address public feeReceiver;
    uint256 public fixedFee;

    constructor(address _token, address _feeReceiver, uint256 _fee) {
        acceptedToken = _token;
        feeReceiver = _feeReceiver;
        fixedFee = _fee;
    }

    /// @notice Accept ERC20 gas fee
    function sponsorGas(address user) external {
        uint256 startGas = gasleft();

        require(user != address(0), "Invalid user");

        // Charge fixed ERC20 fee
        require(IERC20(acceptedToken).transferFrom(user, feeReceiver, fixedFee), "Fee payment failed");

        uint256 gasUsed = startGas - gasleft();
        emit GasSponsored(user, gasUsed, acceptedToken, fixedFee);
    }
}
