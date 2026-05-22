# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- added: Initial implementation of the AKS cluster chart. Templates the
  CAPZ-specific resources (`AzureClusterIdentity`, `AzureManagedCluster`,
  `AzureManagedControlPlane`, `AzureManagedMachinePool`) and depends on the
  upstream `giantswarm/cluster` chart for the provider-agnostic CAPI
  resources (`Cluster`, `MachinePool`).
- changed: `app.giantswarm.io` label group was changed to `application.giantswarm.io`

[Unreleased]: https://github.com/giantswarm/cluster-aks/tree/main
