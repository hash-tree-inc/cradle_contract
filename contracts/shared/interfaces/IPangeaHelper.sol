// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


   interface IPangeaHelper {

   function calculateExactInputSingle(
        address pool,
        address tokenIn,
        uint256 exactAmountIn
    ) external view returns (uint256 amountOut, uint256 price);
   }