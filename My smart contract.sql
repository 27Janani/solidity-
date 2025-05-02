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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {
    address public owner;

    constructor() {
        owner = msg.sender; // creator of the contract
    }

    // Deposit ether into contract
    receive() external payable {}

    // Withdraw all ether to owners address
    function withdraw() public {
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    mapping(string => uint) public votes;

    function vote(string memory candidate) public {
        votes[candidate] += 1;
    }

    function getVotes(string memory candidate) public view returns (uint) {
        return votes[candidate];
    }
}
