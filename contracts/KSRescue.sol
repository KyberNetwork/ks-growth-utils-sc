// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@src/KyberSwapRole.sol';
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from '@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol';

abstract contract KSRescue is KyberSwapRole {
  using SafeERC20 for IERC20;

  error InvalidRecipient();
  error NativeTransferFailed();

  address private constant ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

  function rescueFunds(address token, uint256 amount, address recipient) external onlyOwner {
    require(recipient != address(0), InvalidRecipient());
    if (amount == 0) amount = _getAvailableAmount(token);
    if (amount > 0) {
      if (_isETH(token)) {
        (bool success,) = recipient.call{value: amount}('');
        require(success, NativeTransferFailed());
      } else {
        IERC20(token).safeTransfer(recipient, amount);
      }
    }
  }

  function _getAvailableAmount(address token) internal view virtual returns (uint256 amount) {
    if (_isETH(token)) {
      amount = address(this).balance;
    } else {
      amount = IERC20(token).balanceOf(address(this));
    }
    if (amount > 0) --amount;
  }

  function _isETH(address token) internal pure returns (bool) {
    return (token == ETH_ADDRESS);
  }
}
