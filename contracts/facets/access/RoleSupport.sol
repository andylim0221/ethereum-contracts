/*
 * Copyright (c) 2021 The Paypr Company, LLC
 *
 * This file is part of Paypr Ethereum Contracts.
 *
 * Paypr Ethereum Contracts is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Paypr Ethereum Contracts is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Paypr Ethereum Contracts.  If not, see <https://www.gnu.org/licenses/>.
 */

// SPDX-License-Identifier: GPL-3.0-only

pragma solidity ^0.8.4;

library RoleSupport {
  bytes32 public constant SUPER_ADMIN_ROLE = 0x00;
  bytes32 public constant ADMIN_ROLE = keccak256('paypr.Admin');
  bytes32 public constant DELEGATE_ADMIN_ROLE = keccak256('paypr.DelegateAdmin');
  bytes32 public constant DIAMOND_CUTTER_ROLE = keccak256('paypr.DiamondCutter');
  bytes32 public constant DISABLER_ROLE = keccak256('paypr.Disabler');
  bytes32 public constant LIMITER_ROLE = keccak256('paypr.Limiter');
  bytes32 public constant MINTER_ROLE = keccak256('paypr.Minter');
  bytes32 public constant TRANSFER_AGENT_ROLE = keccak256('paypr.Transfer');
}
