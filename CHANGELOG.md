# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.0.0-rc1] - 2025-06-25

**Breaking change:** Images are stored in the `storage` directory relative to the application directory (this would be `/app/storage` within the Docker container). Ensure that this directory is writable for the application and do not forget to back it up. When using Docker, ensure that you mount that directory as a volume.

### Added

- Scan code using camera and autodetect barcode type
- Attach images
- List of gift cards now shows their balance

### Fixed

- Fix editing of gift cards not resetting balance to 0

## [2.1.0] - 2025-06-17

### Added

- Create gift cards and track their balance

## [2.0.0-rc1] - 2024-07-26

### Added

- Search field to search for coupons and loyalty cards
- Notifications when a coupon is soon to expire. Configure them in your user's profile.
- Support for UPC 12 barcodes (same as EAN13 prefixed with a `0`)

### Changed

- You now need to set the `HOST` environment variable to your domain name. For example `coupons.example.com`.
- Many dependency upgrades
