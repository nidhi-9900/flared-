// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IncomeLog {
    // Every income entry
    struct IncomeEntry {
        address from;      // kisne paisa bheja
        uint256 amount;    // kitna amount (in wei)
        uint256 timestamp; // kab bheja (block time)
        string note;       // optional note / reason
    }

    // All income records
    IncomeEntry[] private entries;

    // Contract owner (jisne deploy kiya)
    address public owner;

    // Events (for front-end / logs)
    event IncomeAdded(
        uint256 indexed index,
        address indexed from,
        uint256 amount,
        string note
    );

    event Withdraw(address indexed to, uint256 amount);

    // ✅ No input in deployment – simple constructor
    constructor() {
        owner = msg.sender; // deploy karne wala owner ban jaata hai
    }

    // 🔹 Add an income entry by sending ETH
    function addIncome(string calldata note) external payable {
        require(msg.value > 0, "Send some ether");

        entries.push(
            IncomeEntry({
                from: msg.sender,
                amount: msg.value,
                timestamp: block.timestamp,
                note: note
            })
        );

        emit IncomeAdded(entries.length - 1, msg.sender, msg.value, note);
    }

    // 🔹 Get one income entry by index
    function getEntry(uint256 index)
        external
        view
        returns (
            address from,
            uint256 amount,
            uint256 timestamp,
            string memory note
        )
    {
        require(index < entries.length, "Index out of range");
        IncomeEntry storage e = entries[index];
        return (e.from, e.amount, e.timestamp, e.note);
    }

    // 🔹 Total number of incomes stored
    function getTotalEntries() external view returns (uint256) {
        return entries.length;
    }

    // 🔹 Check how much ETH is stored in this contract
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    // 🔹 Owner can withdraw ETH from the contract
    function withdraw(address payable to, uint256 amount) external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= address(this).balance, "Not enough balance");

        to.transfer(amount);
        emit Withdraw(to, amount);
    }
}
