// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {LibDiamond} from "../../shared/libraries/LibDiamond.sol";
import {LibMeta} from "../../shared/libraries/LibMeta.sol";


struct User {
    address user;
    string name;
    uint256 updatedAt;
    uint256 createdAt;
}

struct Character {
    uint256 characterId;
    // 힘
    uint256 str;
    // 민첩
    uint256 dex;
    // 체력
    uint256 con;
    // 운
    uint256 luck;
    // 지혜
    uint256 wis;
    

}

struct AppStorage {
    address admin;
}

library LibAppStorage {
    function diamondStorage() internal pure returns (AppStorage storage ds) {
        assembly {
            ds.slot := 0
        }
    }
    function abs(int256 x) internal pure returns (uint256) {
        return uint256(x >= 0 ? x : -x);
    }

}

contract Modifiers {
    AppStorage internal s;

    modifier onlyAdmin {
        LibDiamond.enforceIsContractOwner();
        _;
    }




}