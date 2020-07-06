# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

<a name="unreleased"></a>



<a name="0.3.0"></a>
## [0.3.0] - 2020-07-04
**FEATURES**
- Added cert-manager implementation


<a name="0.2.3"></a>
## [0.2.3] - 2020-07-06
**DOCS**
- moved unreleased headline inside condition

**FEATURES**
- added auto tagging feature
- made listening ports configurable
- Cleanup, renamed variable to match general conventions and fixed formatting
- Add namespace creation to nginx-ingress-controller ([#24](https://github.com/nuuday/terraform-aws-eks-addons/issues/24))
- Add wrapper module and nginx-ingress-controller ([#23](https://github.com/nuuday/terraform-aws-eks-addons/issues/23))
- added s3 and dynamodb configuration to Loki ([#19](https://github.com/nuuday/terraform-aws-eks-addons/issues/19))

**BUG FIXES**
- Added missing chart values


<a name="v0.2.2"></a>
## [v0.2.2] - 2020-06-16
**FEATURES**
- clean up Prometheus configuration and added default sane kubernetes alerts

**DOCS**
- add MIT license


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


[Unreleased]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.3.0...HEAD
[0.3.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.2.3...0.3.0
[0.2.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.2...0.2.3
[v0.2.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.1...v0.2.2
[v0.2.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.1.0...v0.2.0
