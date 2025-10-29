policy "deny_public_storage" {
  source            = "deny_public_storage.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "enforce_allowed_regions" {
  source            = "enforce_allowed_regions.sentinel"
  enforcement_level = "hard-mandatory"
}
