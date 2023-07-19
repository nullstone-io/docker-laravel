group "default" {
  targets = [
    "php8-1",
    "php8-1-local",
  ]
}

target "php8-1" {
  dockerfile = "php8.1/Dockerfile"
  tags      = [
    "nullstone/laravel:php8.1",
    "nullstone/laravel:php8",
    "nullstone/laravel:latest"
  ]
}

target "php8-1-local" {
  dockerfile = "php8.1/local.Dockerfile"
  tags      = [
    "nullstone/laravel:php8.1-local",
    "nullstone/laravel:php8-local",
    "nullstone/laravel:local"
  ]
}
