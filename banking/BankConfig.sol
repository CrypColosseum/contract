// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;


import "@pancakeswap/pancake-swap-lib/contracts/access/Ownable.sol";
import "@pancakeswap/pancake-swap-lib/contracts/math/SafeMath.sol";

import "../interfaces/IBank.sol";


contract BankConfig is IBankConfig, Ownable {
    /// The portion of interests allocated to the reserve pool.
    uint public override getReservePoolBps;

    /// Interest rate model
    InterestModel public interestModel;

    constructor(uint _reservePoolBps, InterestModel _interestModel) public {
        setParams(_reservePoolBps, _interestModel);
    }

    /// @dev Set all the basic parameters. Must only be called by the owner.
    /// @param _reservePoolBps The new interests allocated to the reserve pool value.
    /// @param _interestModel The new interest rate model contract.
    function setParams(uint _reservePoolBps, InterestModel _interestModel) public onlyOwner {
        getReservePoolBps = _reservePoolBps;
        interestModel = _interestModel;
    }

    /// @dev Return the interest rate per second, using 1e18 as denom.
    function getInterestRate(uint debt, uint floating) external view override returns (uint) {
        return interestModel.getInterestRate(debt, floating);
    }
}
