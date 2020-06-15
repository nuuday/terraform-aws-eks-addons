# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

<a name="unreleased"></a>
## [Unreleased]



<a name="v0.2.1"></a>
## [v0.2.1] - 2020-06-08
**BUG FIXES**
- remove scheme from OIDC issuer URL to fix cluster-autoscaler IRSA

**ENHANCEMENTS**
- output ASG tags from cluster-autoscaler


<a name="v0.2.0"></a>
## [v0.2.0] - 2020-06-08
**BUG FIXES**
- change all 'enabled' variables to 'enable'
- rename variable oidc_provider_issuer to oidc_provider_url
- remove kubernetes provider config from cluster-autoscaler

**FEATURES**
- add cilium, kube-monkey, loki and prometheus
- add metrics-server
- add aws-node-termination-handler module

**DOCS**
- Add README with usage and release instructions


<a name="v0.1.0"></a>
## v0.1.0 - 2020-06-01
**REFACTORS**
- define cluster-autoscaler IAM role using terraform-aws-iam module

**FEATURES**
- add cluster-autoscaler


[Unreleased]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.1...HEAD
[v0.2.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.1.0...v0.2.0
