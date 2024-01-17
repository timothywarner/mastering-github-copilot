# Get all Key Vaults in the subscription
$vaults = Get-AzKeyVault

# Loop through each Key Vault
foreach ($vault in $vaults) {
  # Get all secrets in the Key Vault
  $secrets = Get-AzKeyVaultSecret -VaultName $vault.VaultName

  # Loop through each secret
  foreach ($secret in $secrets) {
    # Check if the secret name includes "vm"
    if ($secret.Name -like "*vm*") {
      # Get the secret's last accessed time
      $lastAccessed = (Get-AzKeyVaultSecret -VaultName $vault.VaultName -Name $secret.Name).Attributes.Updated

      # Create a custom object and output it
      $output = New-Object PSObject -Property @{
        Vault = $vault.VaultName
        Secret = $secret.Name
        Last_accessed = $lastAccessed
      }

      # Output the custom object
      $output
    }
  }
} | Format-Table