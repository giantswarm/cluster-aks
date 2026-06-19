# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- added: Initial implementation of the AKS cluster chart.
- added: Post-install/post-upgrade/post-rollback hook that sets an ownerReference on the ASO credentials Secret and on the `AzureClusterIdentity` CR pointing at the `AzureASOManagedCluster`, so they are garbage-collected when the cluster is deleted.
- changed: `app.giantswarm.io` label group was changed to `application.giantswarm.io`

[Unreleased]: https://github.com/giantswarm/cluster-aks/tree/main
