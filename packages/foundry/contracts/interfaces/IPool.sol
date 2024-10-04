// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IPool {
    struct Position {
        uint128 liquidity; // 该 position 拥有的流动性
        uint128 tokensOwed0; // 该 position 可提取的 token0 数量
        uint128 tokensOwed1; // 该 position 可提取的 token1 数量
        uint256 feeGrowthInside0LastX128; // 上次提取手续费时的 feeGrowthGlobal0X128
        uint256 feeGrowthInside1LastX128; // 上次提取手续费时的 feeGrowthGlobal1X128
    }

    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function fee() external view returns (uint24);
    function tickLower() external view returns (int24);
    function tickUpper() external view returns (int24);
    function sqrtPriceX96() external view returns (uint160);
    function tick() external view returns (int24);
    function liquidity() external view returns (uint128);

    function initialize(uint160 sqrtPriceX96) external;

    // feeGrowthGlobal0X128 记录从创建到现在，每个流动性累计产生的 token0 的手续费
    function feeGrowthGlobal0X128() external view returns (uint256);
    // feeGrowthGlobal1X128 记录从创建到现在，每个流动性累计产生的 token1 的手续费
    function feeGrowthGlobal1X128() external view returns (uint256);

    function mint(
        address recipient, 
        uint128 amount, 
        bytes calldata data
    ) external returns (uint256 amount0, uint256 amount1);

    function collect(address recipient) external returns (uint128 amount0, uint128 amount1);

    function burn(uint128 amount) external returns (uint128 amount0, uint128 amount1);

    function swap(
        address recipient,
        bool zeroForOne,
        int256 amountSpecified,
        uint160 sqrtPriceLimitX96,
        bytes calldata data
    ) external returns(int256 amount0, int256 amount1);

    event Mint(address sender, address indexed owner, uint128 amount, uint256 amount0, uint256 amount1);
    event Collect(address indexed owner, address recipient, uint128 amount0, uint128 amount1);
    event Burn(address indexed owner, uint128 amount, uint256 amount0, uint256 amount1);
    event Swap(
        address indexed sender, 
        address indexed recipient, 
        int256 amount0, 
        int256 amount1,
        uint160 sqrtPriceX96,
        uint128 liquidity,
        int24 tick
    );

}
