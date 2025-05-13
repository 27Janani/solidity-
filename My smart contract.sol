 SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
  string public myString  = "My string";
  bool public boolean1  ="true";
  uint public myUnit = 1;
  int public myInt = 1;
  address public myAddress = 0x3b9aB87DEcaABC02284FAbf6083376Da6eC9B670;

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


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControl {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied!");
        _;
    }

    uint public value;

    function setValue(uint _value) public onlyOwner {
        value = _value;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeRegistry {
    struct Employee {
        string name;
        uint salary;
    }

    mapping(address => Employee) public employees;

    function register(string memory _name, uint _salary) public {
        employees[msg.sender] = Employee(_name, _salary);
    }

    function getSalary() public view returns (uint) {
        return employees[msg.sender].salary;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmployeeRegistry {
    struct Employee {
        string name;
        uint salary;
    }

    mapping(address => Employee) public employees;

    function register(string memory _name, uint _salary) public {
        employees[msg.sender] = Employee(_name, _salary);
    }

    function getSalary() public view returns (uint) {
        return employees[msg.sender].salary;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint) public balances;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }
}



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    string public name = "SimpleToken";
    string public symbol = "STK";
    uint8 public decimals = 18;
    uint public totalSupply;

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor(uint _initialSupply) {
        totalSupply = _initialSupply * (10 ** uint(decimals));
        balanceOf[msg.sender] = totalSupply; // Assign all tokens to the contract creator
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Animal {
    function sound() public pure virtual returns (string memory) {
        return "Some sound";
    }
}

contract Dog is Animal {
    function sound() public pure override returns (string memory) {
        return "Bark!";
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample {
    string public lastCalled;

    receive() external payable {
        lastCalled = "receive";
    }

    fallback() external payable {
        lastCalled = "fallback";
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLock {
    uint public unlockTime;
    address public owner;

    constructor(uint _durationInSeconds) payable {
        owner = msg.sender;
        unlockTime = block.timestamp + _durationInSeconds;
    }

    function withdraw() public {
        require(block.timestamp >= unlockTime, "Too early");
        require(msg.sender == owner, "Not owner");
        payable(owner).transfer(address(this).balance);
    }

    function getTimeLeft() public view returns (uint) {
        if (block.timestamp >= unlockTime) return 0;
        return unlockTime - block.timestamp;
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SavingsPool {
    address public owner;
    mapping(address => uint) public balances;
    uint public unlockTime;

    constructor(uint _durationInDays) {
        owner = msg.sender;
        unlockTime = block.timestamp + (_durationInDays * 1 days);
    }

    function deposit() external payable {
        require(msg.value > 0, "Deposit must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        require(block.timestamp >= unlockTime, "Funds are locked");
        uint amount = balances[msg.sender];
        require(amount > 0, "No funds to withdraw");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value >= 0.01 ether, "Min 0.01 ETH to enter");
        players.push(msg.sender);
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager");
        uint index = random() % players.length;
        payable(players[index]).transfer(address(this).balance);
        players = new address ; // reset
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address public seller;
    uint public amount;

    constructor(address _seller) payable {
        buyer = msg.sender;
        seller = _seller;
        amount = msg.value;
    }

    function release() public {
        require(msg.sender == buyer, "Only buyer can release funds");
        payable(seller).transfer(amount);
        
    }
}


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingWithError {
    error AlreadyVoted(address voter);
    error InvalidCandidate(string candidate);

    mapping(address => bool) public hasVoted;
    mapping(string => uint) public votes;

    function vote(string memory candidate) public {
        if (hasVoted[msg.sender]) {
            revert AlreadyVoted(msg.sender);
        }

        if (
            keccak256(bytes(candidate)) != keccak256(bytes("Alice")) &&
            keccak256(bytes(candidate)) != keccak256(bytes("Bob"))
        ) {
            revert InvalidCandidate(candidate);
        }

        hasVoted[msg.sender] = true;
        votes[candidate]++;
    }
}
    

    // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiSigWallet {
    address[] public owners;
    uint public approvalsNeeded;

    struct Transaction {
        address to;
        uint amount;
        uint approvals;
        bool executed;
        mapping(address => bool) approvedBy;
    }

    Transaction[] public transactions;

    modifier onlyOwner() {
        bool isOwner = false;
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) isOwner = true;
        }
        require(isOwner, "Not an owner");
        _;
    }

    constructor(address[] memory _owners, uint _approvalsNeeded) {
        owners = _owners;
        approvalsNeeded = _approvalsNeeded;
    }

    function submitTransaction(address _to, uint _amount) public only
