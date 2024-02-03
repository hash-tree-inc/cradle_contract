// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface GCKLAY {
	function stakeFor(address recipient) external payable;
    function balanceOf(address account) external view returns (uint);
}