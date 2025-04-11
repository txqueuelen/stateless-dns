# Changelog

## Unreleased

## v0.6.1 - 2025-04-11

### ⛓️ Dependencies
- Updated registry.k8s.io/external-dns/external-dns to v0.16.1 - [Changelog 🔗](https://github.com/kubernetes-sigs/external-dns/releases/tag/v0.16.1)
- Updated ghcr.io/txqueuelen/powerdns-docker/powerdns to v4.9.4

## v0.6.0 - 2024-08-09

### 🚀 Enhancements
- Allow specifying `ipFamilyPolicy` on all services.

## v0.5.1 - 2024-08-09

### ⛓️ Dependencies
- Updated ghcr.io/txqueuelen/powerdns-docker/powerdns:v4.9.1 docker digest to fe49318

## v0.5.0 - 2024-07-08

### Note
We are upgrading changing the bare minimum to make it work. We still have to re-read all the changelog and add all new features to this chart (or migrate to the one upstream if we can).

### 🚀 Enhancements
- Upgrade external-dns to 0.14.2

## v0.4.1 - 2024-06-18

### ⛓️ Dependencies
- Updated ghcr.io/txqueuelen/powerdns-docker/powerdns to v4.9.1

## v0.4.0 - 2024-06-17

### Note
All the previous release contain no changelog as it was no automation.
I am solving this with this PR/release/automation that automates the generation of change logs and releases.
I am leveraging this 0ver to do a breaking change. I am changing the URL for this chart from oci://ghcr.io/txqueuelen/charts to oci://ghcr.io/txqueuelen/pdns-stateless.
It seemed that is awesome to have all charts on the same path and loved that Github supported it but I found that is hard to follow the origin of a chart. Users expect to have the chart in a repository called `charts`.
This breaking change should not affect too much as almost no user is using this release note is a way of documenting the changes.
Luckily there are only a few 0ver releases from here once we merge all dependencies that need to be upgraded and make the last changes before creating the v1 release :D

### 🚀 Enhancements
- Automatic dependency upgrade and release system
