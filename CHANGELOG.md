# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Always render `autoUpgradeProfile.upgradeChannel: none` on the ManagedCluster, so AKS never upgrades the Kubernetes version on its own; it is controlled only by the Giant Swarm `Release`.
- Disallow additional properties in `global.controlPlane`, `global.providerSpecific` and their nested objects, so mistyped or removed values fail schema validation instead of being silently ignored.

### Added

- Add `global.providerSpecific.nodeOSUpgrade.channel` to choose the AKS node OS auto-upgrade channel (`NodeImage`, `SecurityPatch`, `Unmanaged` or `None`) independently of the Kubernetes version. It defaults to `NodeImage`, which is what AKS already applies to clusters that don't set it, so existing clusters keep their weekly node image upgrades.
- Add `global.providerSpecific.nodeOSUpgrade.maintenanceWindow` to restrict when node OS upgrades may start. When set, the chart adds an `aksManagedNodeOSUpgradeSchedule` `MaintenanceConfiguration` to the `AzureASOManagedControlPlane` resources. Exactly one of the `daily`, `weekly`, `absoluteMonthly` or `relativeMonthly` schedules must be set, which the values schema validates.

## [0.8.0] - 2026-10-05

### Changed

- Publish the chart to `cluster-catalog` / `cluster-test-catalog` instead of `giantswarm-catalog` / `giantswarm-test-catalog`.

### Added

- Add a pull request template and a release PR body that trigger the `cluster-test-suites` E2E tests.
- Add the `giantswarm.io/prevent-deletion` label to `AzureASOManagedCluster` and `AzureASOManagedControlPlane` when `global.metadata.preventDeletion` is enabled.
- Enable Workload Identity.
- Project `{{$clusterName}}-cluster-aso-exports` ConfigMap with OIDC issuer profile and principal ID.

### Fixed

- Add `helm.sh/resource-policy: keep` to `AzureASOManagedMachinePool` resources so they are deleted by CAPI with the cluster rather than by Helm.

## [0.7.0] - 2026-09-23

### Added

- Add `global.controlPlane.disableLocalAccounts` to turn off AKS local accounts, so the static cluster-admin credential can no longer be issued and all API server authentication goes through Entra ID. When set, the chart also points the ManagedCluster at `<cluster>-user-kubeconfig` via `operatorSpec.secrets.userCredentials`, because ASO cannot list admin credentials on such a cluster and CAPZ needs to own `<cluster>-kubeconfig` itself. Requires `global.controlPlane.aadProfile.managed: true`, which is validated at render time.

### Fixed

- Turn the node-exporter systemd collector off on AKS. The collector opens a D-Bus connection to the host, which is refused on AKS Ubuntu nodes because the container runs under the default containerd AppArmor profile. It failed on every scrape, logging an error per node per minute and exporting no `node_systemd_*` metrics. Needs node-exporter-app with `disableSystemdCollector`.

## [0.6.0] - 2026-09-10

### Changed

- Chart: Update `cluster` to v8.2.0.

### Fixed

- Sanitize the `app.kubernetes.io/version` label value so it is always a valid Kubernetes label. New dev builds are longer and might trigger a validation failure in some cases.
- Configure `observability-bundle` and `security-bundle` HelmReleases dependencies to not include `cilium`, since it's not installed on AKS.

## [0.5.0] - 2026-08-04

### Added

- Validate `global.connectivity.network.vnet.subnetArmId` against an Azure subnet ARM ID pattern, so a malformed BYO VNet reference fails at `helm template`/schema-validation time instead of at ASO reconcile time.
- Fail rendering if `global.connectivity.network.vnet.subnetArmId` (BYO VNet) is set together with `global.connectivity.network.vnet.name`, since the latter is silently ignored in that case.

### Changed

- Raise the fallback default for `osDiskSizeGB` from 30 to 50 GB when overriding node pools via `global.nodePools`, matching the `cluster-azure` provider's default OS disk size and giving more headroom before image-pull-driven disk pressure on system node pools.
- Raise the default node pool's `maxSize` from 2 to 3, matching other providers, since 2 nodes cannot fit all pods
- Document the `Network Contributor` role prerequisite for the ASO identity when bringing your own VNet via `subnetArmId`.
- Add `cert-manager` configuration to enable Workload Identity, and default to `dns01` solver.

### Fixed

- Point the cert-exporter daemonset at `/etc/kubernetes/certs`, where AKS nodes keep their certificates, so certificate expiry metrics (`cert_exporter_not_after`) are emitted and the `ClusterCertificateExpirationMetricsMissing` alert no longer fires permanently on AKS clusters.

## [0.4.0] - 2026-07-23

### Changed

- Update node pool defaults to only include the system pool and use `Standard_D2as_v5` VM family.
- Fix node pool validation to take into account the defaults.
- Update HelmRelease `apiVersion` from `helm.toolkit.fluxcd.io/v2beta1` to `helm.toolkit.fluxcd.io/v2`.

## [0.3.0] - 2026-07-15

### Changed

- Configure external-dns to use workload identity for Azure authentication.

## [0.2.0] - 2026-07-10

### Changed

- Do not create ASO credentials Secret from the chart. Must already exist in the namespace.

## [0.1.0] - 2026-06-19

- added: Initial implementation of the AKS cluster chart.
- added: Post-install/post-upgrade/post-rollback hook that sets an ownerReference on the ASO credentials Secret and on the `AzureClusterIdentity` CR pointing at the `AzureASOManagedCluster`, so they are garbage-collected when the cluster is deleted.
- changed: `app.giantswarm.io` label group was changed to `application.giantswarm.io`

[Unreleased]: https://github.com/giantswarm/cluster-aks/compare/v0.8.0...HEAD
[0.8.0]: https://github.com/giantswarm/cluster-aks/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/giantswarm/cluster-aks/compare/v0.6.0...v0.7.0
[0.6.0]: https://github.com/giantswarm/cluster-aks/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/giantswarm/cluster-aks/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/giantswarm/cluster-aks/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/giantswarm/cluster-aks/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/giantswarm/cluster-aks/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/giantswarm/cluster-aks/releases/tag/v0.1.0
