// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
// @openzeppelin ERC20 interface
import "../shared/interfaces/IERC20.sol";
import "../shared/interfaces/IGCKlay.sol";
import "../shared/interfaces/IPangeaSwap.sol";
import "../shared/interfaces/IPangeaHelper.sol";

// struct ExactOutputSingleParams {
//         address tokenIn; /// @dev the input token address. If tokenIn is address(0), msg.value will be wrapped and used as input token
//         uint256 amountOut; /// @dev The amount of output tokens to receive
//         uint256 amountInMaximum; /// @dev maximum available amount of input token after swap
//         address pool; /// @dev pool address to swap
//         address to; /// @dev address to receive
//         bool unwrap; /// @dev unwrap if output token is wrapped klay
//     }


contract CradleAMM is Initializable, PausableUpgradeable, AccessControlUpgradeable, UUPSUpgradeable {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

    // 0x999999999939ba65abb254339eec0b2a0dac80e9
    GCKLAY gcklay;
    // 
    IERC20 cradle;
    // 0x17Ac28a29670e637c8a6E1ec32b38fC301303E34
    IPangeaSwap pangeaSwap;
    // 0xe80fe14d4c67598a2a8f107f1b95fecc2bb08e7d
    IPangeaHelper pangeaHelper;
    // 0x9f8a222fd0b75239b32aa8a97c30669e5981db05
    address public gcklayPool;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address defaultAdmin, address pauser, address upgrader)
        initializer public
    {
        __Pausable_init();
        __AccessControl_init();
        __UUPSUpgradeable_init();

        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(PAUSER_ROLE, pauser);
        _grantRole(UPGRADER_ROLE, upgrader);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyRole(UPGRADER_ROLE)
        override
    {}

    function _setTokens(address _gcklay, address _cradle, address _pangea) external onlyRole(DEFAULT_ADMIN_ROLE) {
        gcklay = GCKLAY(_gcklay);
        cradle = IERC20(_cradle);
        pangeaSwap = IPangeaSwap(_pangea);
    }


    function cradleBuy() external payable {
        gcklay.stakeFor{value: msg.value}(address(this));
        cradle.mint(msg.sender, msg.value);        
    }

    function cradleRefund(uint _refundAmount) external {
    

        cradle.burnFrom(msg.sender, _refundAmount);

        uint amountOut = refundCalculation(_refundAmount);
        
        pangeaSwap.exactOutputSingle(
            IPangeaSwap.ExactOutputSingleParams({
                tokenIn: address(gcklay),
                amountOut: _refundAmount,
                amountInMaximum: amountOut,
                pool: gcklayPool,
                to: address(this),
                unwrap: true
            })
        );

        
        

    }

    function refundCalculation(uint _refundAmount) internal view returns (uint){
        (uint amountOut,) = IPangeaHelper(pangeaHelper).calculateExactInputSingle(
            address(gcklayPool),
            address(gcklay),
            _refundAmount
        );

        return amountOut;
    }

}



// 0xc07f5c32
// 000000000000000000000000999999999939ba65abb254339eec0b2a0dac80e9
// 0000000000000000000000000000000000000000000000005401ab65de44948c
// 00000000000000000000000000000000000000000000000053926f4ed6e99f84
// 0000000000000000000000009f8a222fd0b75239b32aa8a97c30669e5981db05
// 000000000000000000000000e3b8773ad509c04744071d8f151e7d2d44e35ba2
// 0000000000000000000000000000000000000000000000000000000000000001

