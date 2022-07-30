// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.1 <0.9.0;

contract Modifiers {
    constructor() {
        owner = payable(msg.sender);
    }

    address payable owner;
    uint totalDonations;

    modifier increment() {
        totalDonations++;
        _;
    }

    modifier mustBeOwner() {
        require(msg.sender == owner, "You must be the owner to call this");
        _;
    }

    modifier cantBeOwner() {
        require(msg.sender != owner, "You must not be the owner to donate");
        _;
    }

    function withdraw() external mustBeOwner {
        require(address(this).balance > 1 ether, "Cannot withdraw");
        owner.transfer(address(this).balance);
    }

    function seeBalance() public view mustBeOwner returns (uint256) {
        return (address(this).balance);
    }

    receive() external payable cantBeOwner increment {}
}
