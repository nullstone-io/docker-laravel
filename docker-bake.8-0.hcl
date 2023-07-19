group "default" {
  targets = [
    "php8-0",
    "php8-0-local",
  ]
}

target "php8-0" {
  dockerfile = "php8.0/Dockerfile"
  tags      = [
    "nullstone/laravel:php8.0"
  ]
}

target "php8-0-local" {
  dockerfile = "php8.0/local.Dockerfile"
  tags      = [
    "nullstone/laravel:php8.0-local"
  ]
}
