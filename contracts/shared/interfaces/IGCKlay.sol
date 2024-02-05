// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGCKLAY {
	function stakeFor(address recipient) external payable;
    function balanceOf(address account) external view returns (uint);
}