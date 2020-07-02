# terraform-aws-eks-addons

This repository contains Terraform modules for adding add-ons to EKS clusters.

See [modules/](modules/) for the currently supported K8s modules.

## Usage

All add-ons are **disabled** by default.

```terraform
module "addons" {
  # add '?ref=v0.1.0' to pin versions
  source = "github.com/nuuday/terraform-aws-eks-addons"

  cluster_autoscaler = {
    enable = true
    # ...
  }
}
```

You may want to reference individual add-ons directly.
This is done by sourcing the sub-modules inside [modules/](modules/).

**NOTE** When referencing an add-on through its sub-module, the add-on is **enabled** by default.

```terraform
module "addon-cluster-autoscaler" {
  # add '?ref=v0.1.0' to pin versions
  source = "github.com/nuuday/terraform-aws-eks-addons//modules/cluster-autoscaler"
}
```

## Releasing

This module adheres to [semantic versioning](https://semver.org/), and versions are made visible through Git tags.

At any point in time, the maintainers of this repository will decide to create a new release.
It is important to know which contributions have been made to `master` since the last release,
in order to decide whether the version bump will be a *patch*, *minor*, or *major*.

Steps for creating a new **minor** release are as follows

```sh
# Typically, releases are made on the master branch.
# This will checkout master and pull latest changes if any.
git checkout master && git pull

# Figure out what the next version number will be.
# NOTE: This is for a *minor* version. Change to patch or major if it applies.
make scope=minor show-next-version # outputs e.g. v0.2.0

# Update CHANGELOG.md based on the unreleased changes.
# NOTE: Remember to change the version to the version from previous step.
make changelog && git add CHANGELOG.md && git commit -m "chore: update changelog for vx.y.z"

# Tag HEAD with the version tag, and push master and newly created tag.
make scope=minor release
```

## Contributing

See [CONTRIBUTING](.github/CONTRIBUTING) for contribution guidelines. *(pending)*

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a complete changelog.

