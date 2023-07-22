group "default" {
  targets = [
    "php8-1",
    "php8-1-local",
    "php8-0",
    "php8-0-local",
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
