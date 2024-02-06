// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AppStorage, Modifiers, LibAppStorage} from "../libraries/LibAppStorage.sol";
import {LibMeta} from "../../shared/libraries/LibMeta.sol";

contract AdminFacet is Modifiers {

    function setContract(string memory _name, address _contractAddr) external onlyAdmin {
        s.contracts[_name] = _contractAddr;
    }

}