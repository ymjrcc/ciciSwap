// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 顶层合约，对应 Pool 页面，负责 Pool 的创建和管理
contract PoolManager {

    struct PoolInfo {
        address token0;
        address token1;
        uint32 index;
        uint8 feeProtocol;
        int24 tickLower;
        int24 tickUpper;
        int24 tick;
        uint160 sqrtPriceX96;
    }

    struct CreateAndInitializeParams {
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint160 sqrtPriceX96;
    }

    constructor() {}

    function getAllPools() external view returns (PoolInfo[] memory poolsInfo) {

    }

    function CreateAndInitializePoolIfNecessary(
        CreateAndInitializeParams calldata params
    ) external payable returns (address pool) {

    }

}
