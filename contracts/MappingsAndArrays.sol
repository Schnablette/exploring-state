// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract MappingsAndArrays {
    struct AmountsStruct {
        address addr;
        uint256 amount;
    }

    AmountsStruct[] amountsArray;

    mapping(address => uint256) amountsMapping;

    function storeInArray(uint256 _num) public {
        amountsArray.push(AmountsStruct(msg.sender, _num));
    }

    function storeInMapping(uint256 _num) public {
        amountsMapping[msg.sender] = _num;
    }

    function updateArray(uint256 _num) public {
        for (uint i = 0; i < amountsArray.length; i++) {
            if (amountsArray[i].addr == msg.sender) {
                amountsArray[i].amount = _num;
                break;
            }
        }
    }

    function updateMapping(uint256 _num) public {
        amountsMapping[msg.sender] = _num;
    }
}
