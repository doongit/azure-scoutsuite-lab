policy "deny_public_storage" {
  source            = "policies/deny_public_storage.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "enforce_allowed_regions" {
  source            = "policies/enforce_allowed_regions.sentinel"
  enforcement_level = "hard-mandatory"
}
