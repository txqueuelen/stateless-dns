# Changelog

## Unreleased

### Note

All the previous release contain no changelog as it was no automation.

I am solving this with this PR/release/automation that automates the
generation of change logs and releases.

I am leveraging this 0ver to do a breaking change. I am changing the
URL for this chart from oci://ghcr.io/txqueuelen/charts to
oci://ghcr.io/txqueuelen/pdns-stateless.

It seemed that is awesome to have all charts on the same path and loved
that Github supported it but I found that is hard to follow the origin
of a chart. Users expect to have the chart in a repository called
`charts`.

This breaking change should not affect too much as almost no user is
using this release note is a way of documenting the changes.

Luckily there are only a few 0ver releases from here once we merge all
dependencies that need to be upgraded and make the last changes before
creating the v1 release :D

### Enhancements
- Automatic dependency upgrade and release system
