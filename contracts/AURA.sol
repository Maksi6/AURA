// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Импорт стандартного интерфейса ERC20
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract SimpleToken is IERC20 {
    // Настройки токена
    string public name = "Aurora Nebula"; // Красивое название
    string public symbol = "AURA";        // Тикер
    uint8 public decimals = 18;           // Стандарт дробности

    // 1 000 000 токенов (учитывая 18 знаков после запятой)
    uint256 private _totalSupply = 1000000 * 10**uint256(decimals);
    
    mapping(address => uint256) private _balances;

    constructor() {
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }
}