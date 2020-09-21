// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import './IConsumable.sol';
import './IConvertibleConsumable.sol';

interface IConsumableExchange is IConsumable {
  /**
   * @dev Emitted when the exchange rate changes for `token`.
   * `exchangeRate` is the new exchange rate
   */
  event ExchangeRateChanged(IConvertibleConsumable indexed token, uint256 exchangeRate);

  /**
   * @dev Returns the total number of convertibles registered asn part of this exchange.
   */
  function totalConvertibles() external view returns (uint256);

  /**
   * @dev Returns the convertible with the given index. Reverts if index is higher than totalConvertibles.
   */
  function convertibleAt(uint256 index) external view returns (IConvertibleConsumable);

  /**
   * @dev Returns whether or not the token at the given address is convertible
   */
  function isConvertible(IConvertibleConsumable token) external view returns (bool);

  /**
   * @dev Returns exchange rate of the given token
   *
   * eg if exchange rate is 1000, then 1 this consumable == 1000 associated tokens
   */
  function exchangeRateOf(IConvertibleConsumable token) external view returns (uint256);

  /**
   * @dev Exchanges the given amount of this consumable to the given token for the sender
   *
   * The sender must have enough of this consumable to make the exchange.
   *
   * When complete, the sender should transfer the new tokens into their account.
   */
  function exchangeTo(IConvertibleConsumable tokenAddress, uint256 amount) external;

  /**
   * @dev Exchanges the given amount of the given token to this consumable for the sender
   *
   * Before calling, the sender must provide allowance of the given token for the appropriate amount.this
   *
   * When complete, the sender will have the correct amount of this consumable.
   */
  function exchangeFrom(IConvertibleConsumable token, uint256 tokenAmount) external;

  /**
   * @dev Registers a token with this exchange, using the given `exchangeRate`.
   *
   * NOTE: Can only be called when the token has no current `exchangeRate`
   */
  function registerToken(uint256 exchangeRate) external;
}