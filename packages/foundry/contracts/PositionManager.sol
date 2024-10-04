// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 顶层合约，对应 Position 页面，负责 LP 头寸和流动性的管理
contract PositionManager {
    
    struct PositionInfo {
        address owner;
        address token0;
        address token1;
        uint32 index;
        uint24 fee;
        uint128 liquidity;
        int24 tickLower;
        int24 tickUpper;
        uint256 tokensOwed0;
        uint256 tokensOwed1;
    }

    struct MintParams {
        address token0;
        address token1;
        uint32 index;
        uint256 amount0Desired;
        uint256 amount1Desired;
        address recipient;
        uint256 deadline;
    }

    constructor() {}

    function getPositionInfo (uint256 positionId) external view returns (PositionInfo memory positionInfo) {
        
    }

    function mint(MintParams calldata params) external payable returns(
        uint256 positionId,
        uint128 liquidity,
        uint256 amount0,
        uint256 amount1
    ) {
        
    }

    function burn(uint256 positionId) external returns(
        uint256 amount0,
        uint256 amount1
    ) {
        
    }

    function collect(uint256 positionId, address recipient) external returns(
        uint256 amount0,
        uint256 amount1
    ) {
        
    }
}