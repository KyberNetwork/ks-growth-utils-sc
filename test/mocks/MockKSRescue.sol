// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@src/KSRescue.sol';

contract MockKSRescue is KSRescue {
  constructor() Ownable(msg.sender) {}
}
