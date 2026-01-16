#!/usr/bin/env bash
set -euo pipefail

# Required env inputs:
#   RG         (resource group)
#   KV_NAME    (key vault name)
#   VM_NAME    (vm name)
# Optional:
#   ROLE_NAME  (role to expect, default: Key Vault Secrets User)

ROLE_NAME="${ROLE_NAME:-4633458b-17de-408a-b874-0445c86b69e6}"

echo "Smoke tests: RG=${RG} KV=${KV_NAME} VM=${VM_NAME}"

# 1) Test - VM exists and has system managed identity
echo " - Test 1 - Checking VM with system managed identity exists ..."
VM_JSON=$(az vm show -g "$RG" -n "$VM_NAME" --query "{id:id, principalId:identity.principalId}" -o json)
PRINCIPAL_ID=$(jq -r '.principalId' <<<"$VM_JSON")
if [[ -z "$PRINCIPAL_ID" || "$PRINCIPAL_ID" == "null" ]]; then
  echo "FAIL: VM has no managed identity" >&2
  exit 2 # exit is non zero to indicate failure starting from 2 onwards
fi
echo "   principalId=$PRINCIPAL_ID"

# 2) Test - Key Vault exists
echo " - Test 2 - Checking Key Vault exists..."
KV_ID=$(az keyvault show -n "$KV_NAME" -g "$RG" --query id -o tsv)
if [[ -z "$KV_ID" ]]; then
  echo "FAIL: Key Vault not found" >&2
  exit 3
fi
echo "   kv id=$KV_ID"

# 3) Test - Secret exists in Key Vault
echo " - Test 3 - Checking secret exists in Key Vault..."
SECRET_ID=$(az keyvault secret show --vault-name "$KV_NAME" --name vm-admin-password --query id -o tsv || true)
if [[ -z "$SECRET_ID" ]]; then
  echo "FAIL: Secret vm-admin-password not found in $KV_NAME" >&2
  exit 4
fi
echo "   secret id=$SECRET_ID"

# 4) Test - Role assignment exists for VM principal on Key Vault
echo " - Test 4 - Checking role assignments for VM principal on Key Vault..."
ROLE_FOUND=$(az role assignment list --scope "$KV_ID" --assignee "$PRINCIPAL_ID" --query "[].roleDefinitionId" -o tsv | grep -i "$ROLE_NAME" || true)
if [[ -z "$ROLE_FOUND" ]]; then
  echo "FAIL: No role assignment matching $ROLE_NAME for principal $PRINCIPAL_ID on $KV_ID" >&2
  exit 5
fi
echo "   VM identity exists at Key Vault scope with role $ROLE_NAME"

# 5) Test - Vnet exists
echo " - Test 5 - Checking VNet exists..."
VNET_JSON=$(az network vnet show -g "$RG" -n "$VNET_NAME" --query "{id:id,addressSpace:addressSpace.addressPrefixes}" -o json 2>/dev/null || true)
if [[ -z "$VNET_JSON" || "$VNET_JSON" == "null" ]]; then
  echo "FAIL: VNet $VNET_NAME not found in $RG" >&2
  exit 6
fi
echo "  VNet exists with address space: $(jq -r '.addressSpace | join(", ")' <<<"$VNET_JSON")"

echo "SMOKE TESTING COMPLETE: all tests passed"