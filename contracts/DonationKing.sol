// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract DonationKing {
    address payable public king;
    uint256 internal totalAmountAvailable;

    function setKing(address payable _king) public {
        king = _king;
    }

    function donate() public payable {}

    function distribute() public {
        king.transfer(address(this).balance);
    }

    receive() external payable {}
}
