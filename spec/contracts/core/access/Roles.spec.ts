import {
  ADMIN,
  checkDelegatingRoles,
  checkRoles,
  checkSuperAdmin,
  checkSuperAdminDelegation,
  createRoles,
  MINTER,
  TRANSFER_AGENT,
} from '../../../helpers/AccessHelper';
import { ERC165_ID, ROLE_DELEGATE_ID } from '../../../helpers/ContractIds';
import { shouldSupportInterface } from '../../../helpers/ERC165';

describe('supportsInterface', () => {
  shouldSupportInterface('ERC165', createRoles, ERC165_ID);
  shouldSupportInterface('RoleDelegate', createRoles, ROLE_DELEGATE_ID);
});

describe('check roles', () => {
  checkSuperAdmin(createRoles, (roles, options) => roles.forSuperAdmin(options));

  checkRoles('Admin', ADMIN, {
    createRoles,
    isInRole: (roles, role) => roles.isAdmin(role),
    forRole: (roles, options) => roles.forAdmin(options),
    addToRole: (roles, role, options) => roles.addAdmin(role, options),
    renounceRole: (roles, options) => roles.renounceAdmin(options),
    revokeRole: (roles, role, options) => roles.revokeAdmin(role, options),
  });

  checkRoles('Minter', MINTER, {
    createRoles,
    isInRole: (roles, role) => roles.isMinter(role),
    forRole: (roles, options) => roles.forMinter(options),
    addToRole: (roles, role, options) => roles.addMinter(role, options),
    renounceRole: (roles, options) => roles.renounceMinter(options),
    revokeRole: (roles, role, options) => roles.revokeMinter(role, options),
  });

  checkRoles('Transfer Agent', TRANSFER_AGENT, {
    createRoles,
    isInRole: (roles, role) => roles.isTransferAgent(role),
    forRole: (roles, options) => roles.forTransferAgent(options),
    addToRole: (roles, role, options) => roles.addTransferAgent(role, options),
    renounceRole: (roles, options) => roles.renounceTransferAgent(options),
    revokeRole: (roles, role, options) => roles.revokeTransferAgent(role, options),
  });
});

describe('check delegating roles', () => {
  const createDelegatingRoles = (address: string) => createRoles(address);

  checkSuperAdminDelegation(createDelegatingRoles, (roles, options) => roles.forSuperAdmin(options));

  checkDelegatingRoles('Admin', ADMIN, {
    createDelegatingRoles,
    isInRole: (roles, role) => roles.isAdmin(role),
    forRole: (roles, options) => roles.forAdmin(options),
    addToRole: (roles, role, options) => roles.addAdmin(role, options),
  });

  checkDelegatingRoles('Minter', MINTER, {
    createDelegatingRoles,
    isInRole: (roles, role) => roles.isMinter(role),
    forRole: (roles, options) => roles.forMinter(options),
    addToRole: (roles, role, options) => roles.addMinter(role, options),
  });

  checkDelegatingRoles('Transfer Agent', TRANSFER_AGENT, {
    createDelegatingRoles,
    isInRole: (roles, role) => roles.isTransferAgent(role),
    forRole: (roles, options) => roles.forTransferAgent(options),
    addToRole: (roles, role, options) => roles.addTransferAgent(role, options),
  });
});