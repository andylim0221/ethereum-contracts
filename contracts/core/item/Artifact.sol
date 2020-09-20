// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

import '@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/ERC721.sol';
import '../BaseContract.sol';
import './ArtifactInterfaceSupport.sol';
import './IArtifact.sol';
import '../consumable/ConsumableProvider.sol';
import '../consumable/ConsumableProviderInterfaceSupport.sol';
import '../Disableable.sol';
import '../transfer/BaseTransferring.sol';
import '../transfer/TransferringInterfaceSupport.sol';

abstract contract Artifact is
  IArtifact,
  BaseContract,
  BaseTransferring,
  ConsumableProvider,
  ERC721UpgradeSafe,
  Disableable
{
  uint256 private _initialUses;

  mapping(uint256 => uint256) private _usesLeft;
  uint256 private _totalUsesLeft;

  function _initializeArtifact(
    ContractInfo memory info,
    string memory baseUri,
    string memory symbol,
    IConsumable.ConsumableAmount[] memory amountsToProvide,
    uint256 initialUses
  ) internal initializer {
    _initializeBaseContract(info);
    _initializeConsumableProvider(amountsToProvide);
    _registerInterface(ArtifactInterfaceSupport.ARTIFACT_INTERFACE_ID);
    _registerInterface(ConsumableProviderInterfaceSupport.CONSUMABLE_PROVIDER_INTERFACE_ID);

    __ERC721_init(info.name, symbol);
    _registerInterface(TransferringInterfaceSupport.TRANSFERRING_INTERFACE_ID);
    _setBaseURI(baseUri);

    _initialUses = initialUses;
  }

  function initialUses() external override view returns (uint256) {
    return _initialUses;
  }

  function usesLeft(uint256 itemId) external override view returns (uint256) {
    return _usesLeft[itemId];
  }

  function totalUsesLeft() external override view returns (uint256) {
    return _totalUsesLeft;
  }

  function useItem(uint256 itemId, address action) external override onlyEnabled {
    address sender = _msgSender();
    address player = ownerOf(itemId);

    require(sender == player, 'Artifact: must be used by the owner');

    _usesLeft[itemId] = _usesLeft[itemId].sub(1, 'Artifact: no uses left for item');
    _totalUsesLeft = _totalUsesLeft.sub(1);

    _provideConsumables(action);

    emit Used(player, action, itemId);
  }

  function _mint(address to, uint256 itemId) internal override onlyEnabled {
    super._mint(to, itemId);

    _usesLeft[itemId] = _initialUses;
    _totalUsesLeft += _initialUses;

    _checkEnoughConsumable();
  }

  function _checkEnoughConsumable() internal {
    require(_canProvideMultiple(_totalUsesLeft), 'Artifact: not enough consumable for items');
  }

  uint256[50] private ______gap;
}
