// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract Child {
    string public name;
    address payable public owner;
    address payable public parent;

    constructor(string memory _name) {
        name = _name;
        owner = payable(tx.origin);
        parent = payable(msg.sender);
    }

    modifier mustBeOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }

    function donateToParent() public mustBeOwner {
        parent.transfer(address(this).balance);
    }

    function donate(uint amount) public payable {}

    function withdraw() public mustBeOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {}
}

contract Parent {
    string public name;
    address payable public owner;
    Child[] public children;

    constructor(string memory _name) {
        name = _name;
        owner = payable(msg.sender);
    }

    function donate(uint amount) public payable {}

    function withdraw() public {
        require(msg.sender == owner, "must be owner");
        owner.transfer(address(this).balance);
    }

    function createChild(string memory _name) public {
        require(children.length < 3, "No more children allowed");
        children.push(new Child(_name));
    }

    receive() external payable {}
}
