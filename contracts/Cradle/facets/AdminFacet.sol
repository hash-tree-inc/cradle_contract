// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AppStorage, Modifiers, LibAppStorage} from "../libraries/LibAppStorage.sol";
import {LibMeta} from "../../shared/libraries/LibMeta.sol";

contract AdminFacet is Modifiers {

    function setAdmin(address _admin) external onlyAdmin {
        s.admin = _admin;
    }

}