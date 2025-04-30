// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
  string public myString  = "My string";
  bool public boolean1  ="true";
  uint public myUnit = 1;
  int public myInt = 1;
  address public myAddress = 0x3b9aB87DEcaABC02284FAbf6083376Da6eC9B670



}


contract SimpleStorage {
    uint public data;

    function set(uint _data) public {
        data = _data;
    }

    function get() public view returns (uint) {
        return data;
    }
}