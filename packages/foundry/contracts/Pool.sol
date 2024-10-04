// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "./libraries/TickMath.sol";

import "./interfaces/IPool.sol";
import "./interfaces/IFactory.sol";

// 最底层合约，对应一个交易池，记录了当前价格、头寸、流动性等信息
contract Pool is IPool {

    address public immutable override factory;
    address public immutable override token0;
    address public immutable override token1;
    uint24 public immutable override fee;
    int24 public immutable override tickLower;
    int24 public immutable override tickUpper;
    
    uint160 public override sqrtPriceX96;
    int24 public override tick;
    uint128 public override liquidity;
    uint256 public override feeGrowthGlobal0X128;
    uint256 public override feeGrowthGlobal1X128;

    mapping (address => Position) public positions;
    
    constructor() {
        (factory, token0, token1, tickLower, tickUpper, fee) = IFactory(msg.sender).parameters();
    }

    function initialize(uint160 sqrtPriceX96_) external override {
        // 通过价格获取 tick，判断 tick 是否在 tickLower 和 tickUpper 之间
        tick = TickMath.getTickAtSqrtRatio(sqrtPriceX96_);
        require(
            tick >= tickLower && tick < tickUpper, 
            "sqrtPriceX96 should be within the range of [tickLower, tickUpper)"
        );
        // 初始化 Pool 的 sqrtPriceX96
        sqrtPriceX96 = sqrtPriceX96_;
    }

    struct ModifyPositionParams {
        address owner;
        int128 liquidityDelta; // 流动性变化量
    }

    // 修改交易池整体的流动性 liquidity 
    // 通过新增的流动性计算 amount0 和 amount1
    function _modifyPosition(
        ModifyPositionParams memory params
    ) private returns (int256 amount0, int256 amount1) {

    }

    // Get the pool's balance of token0
    function balance0() private view returns (uint256) {
        return IERC20(token0).balanceOf(address(this));
    }

    // Get the pool's balance of token1
    function balance1() private view returns (uint256) {
        return IERC20(token1).balanceOf(address(this));
    }

    function mint(
        address recipient, 
        uint128 amount, // 流动性
        bytes calldata data
    ) external override returns (uint256 amount0, uint256 amount1) {

    }

    function collect(address recipient) external override returns (uint128 amount0, uint128 amount1) {

    }

    function burn(uint128 amount) external override returns (uint128 amount0, uint128 amount1) {

    }

    function swap(
        address recipient,
        bool zeroForOne,
        int256 amountSpecified,
        uint160 sqrtPriceLimitX96,
        bytes calldata data
    ) external override returns(int256 amount0, int256 amount1) {

    }

}