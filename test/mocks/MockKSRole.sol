// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@src/KyberSwapRole.sol';

contract MockKSRole is KyberSwapRole {
  address public zohar;

  constructor() Ownable(msg.sender) {}

  function setZohar(
    address _zohar
  ) external onlyOperator {
    zohar = _zohar;
  }

  function setZohar2(
    address _zohar
  ) external whenNotPaused {
    zohar = _zohar;
  }

  function setZohar3(
    address _zohar
  ) external whenPaused {
    zohar = _zohar;
  }
}
