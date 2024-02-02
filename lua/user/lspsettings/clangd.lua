return {
  custom_capabilities = function(capabilities) {
    capabilities.offsetEncoding = { "utf-16" }
    return capabilities
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
}
