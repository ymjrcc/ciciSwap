// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "./interfaces/IFactory.sol";
import "./Pool.sol";

// 底层合约，Pool 的工厂合约
contract Factory is IFactory {

    mapping(address => mapping(address => address[])) public pools;

    Parameters public override parameters;

    constructor() {}

    function sortToken(address tokenA, address tokenB) private pure returns (address, address) {
        return tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
    }

    function getPool(address tokenA, address tokenB, uint32 index) external view override returns(address) {
        require(tokenA != tokenB, "IDENTICAL_ADDRESSES");
        require(tokenA > address(0) && tokenB > address(0), "ZERO_ADDRESS");

        address token0;
        address token1;
        (token0, token1) = sortToken(tokenA, tokenB);

        return pools[token0][token1][index];
    }

    function createPool(
        address tokenA,
        address tokenB,
        int24 tickLower,
        int24 tickUpper,
        uint24 fee
    ) external override returns(address pool) {
        require(tokenA != tokenB, "IDENTICAL_ADDRESSES");
        require(tokenA > address(0) && tokenB > address(0), "ZERO_ADDRESS");

        address token0;
        address token1;
        (token0, token1) = sortToken(tokenA, tokenB);

        address[] memory existingPools = pools[token0][token1];

        for(uint256 i = 0; i < existingPools.length; i++) {
            IPool currentPool = IPool(existingPools[i]);
            if(
                currentPool.tickLower() == tickLower && 
                currentPool.tickUpper() == tickUpper && 
                currentPool.fee() == fee
            ) {
                return existingPools[i];
            }
        }

        parameters = Parameters({
            factory: address(this),
            tokenA: tokenA,
            tokenB: tokenB,
            tickLower: tickLower,
            tickUpper: tickUpper,
            fee: fee
        });

        bytes32 salt = keccak256(abi.encodePacked(token0, token1, tickLower, tickUpper, fee));

        pool = address(new Pool{salt: salt}());

        pools[token0][token1].push(pool);

        delete parameters;

        emit PoolCreated(token0, token1, uint32(existingPools.length), tickLower, tickUpper, fee, pool);
    }

}
