// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract B {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    address public sender;
    uint256 public num;
    uint256 public value;

    // ! It calls function from contract B and sets values on their storage slots
    // * num = _num;
    // * sender = msg.sender;
    // * value = msg.value;
    // ! first storage slot in contract A (sender) will get NUM value,
    // ! 2nd storage slot in contract A (num) -> msg.sender
    // ! 3rd storage slot in A (value) -> value
    function setVars(address _contract, uint256 _num) public payable {
        (bool success, bytes memory data) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
    }
}
