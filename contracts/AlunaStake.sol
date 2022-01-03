// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

// This contract handles swapping to and from xALN, Aluna's staking token.
contract AlunaStake is ERC20("AlunaStake", "xALN"){
    using SafeMath for uint256;
    IERC20 public aluna;

    // Define the Aluna token contract
    constructor(IERC20 _aluna) public {
        aluna = _aluna;
    }

    // Stake. Pay some ALNs. Earn some shares.
    // Locks Aluna and mints xAluna
    function enter(uint256 _amount) public {
        // Gets the amount of Aluna locked in the contract
        uint256 totalAluna = aluna.balanceOf(address(this));
        // Gets the amount of xAluna in existence
        uint256 totalShares = totalSupply();
        // If no xAluna exists, mint it 1:1 to the amount put in
        if (totalShares == 0 || totalAluna == 0) {
            _mint(msg.sender, _amount);
        } 
        // Calculate and mint the amount of xAluna the Aluna is worth. 
        // The ratio will change overtime, as xAluna is burned/minted and Aluna deposited + gained 
        // from fees / withdrawn.
        else {
            uint256 what = _amount.mul(totalShares).div(totalAluna);
            _mint(msg.sender, what);
        }
        // Lock the Aluna in the contract
        aluna.transferFrom(msg.sender, address(this), _amount);
    }

    // Unstake. Claim back your ALNs.
    // Unlocks the staked + gained Aluna and burns xAluna
    function leave(uint256 _share) public {
        // Gets the amount of xAluna in existence
        uint256 totalShares = totalSupply();
        // Calculates the amount of Aluna the xAluna is worth
        uint256 what = _share.mul(aluna.balanceOf(address(this))).div(totalShares);
        _burn(msg.sender, _share);
        aluna.transfer(msg.sender, what);
    }
}