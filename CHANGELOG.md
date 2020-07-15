# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

<a name="unreleased"></a>



<a name="0.6.1"></a>
## [0.6.1] - 2020-07-15

- prefix version tags with 'v' ([#32](https://github.com/nuuday/terraform-aws-eks-addons/issues/32))


<a name="0.6.0"></a>
## [0.6.0] - 2020-07-15
**FEATURES**
- Added priority class configuration variable to cluster-autoscaler ([#30](https://github.com/nuuday/terraform-aws-eks-addons/issues/30))


<a name="0.5.1"></a>
## [0.5.1] - 2020-07-15
**BUG FIXES**
- fixed missing namespace resources, was deleted by accident


<a name="0.5.0"></a>
## [0.5.0] - 2020-07-10
**FEATURES**
- Added output with simple prometheus alertmanager rules


<a name="0.4.0"></a>
## [0.4.0] - 2020-07-10
**FEATURES**
- Added support for adding custom alert rules to prometheus alertmanager


<a name="0.3.3"></a>
## [0.3.3] - 2020-07-10
**BUG FIXES**
- Added resource request to cert-manager services


<a name="0.3.2"></a>
## [0.3.2] - 2020-07-08
**BUG FIXES**
- use default asg_tags instead of general AWS tags in cluster-autoscaler

**FEATURES**
- Cleanup, renamed variables to match general conventions ([#27](https://github.com/nuuday/terraform-aws-eks-addons/issues/27))


<a name="0.3.1"></a>
## [0.3.1] - 2020-07-06
**BUG FIXES**
- formatting

**FEATURES**
- Added support for route53 and irsa
- added the basic grunt work on external-dns


<a name="0.3.0"></a>
## [0.3.0] - 2020-07-06
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


[Unreleased]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.6.1...HEAD
[0.6.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.6.0...0.6.1
[0.6.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.5.1...0.6.0
[0.5.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.5.0...0.5.1
[0.5.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.4.0...0.5.0
[0.4.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.3.3...0.4.0
[0.3.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.3.2...0.3.3
[0.3.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.3.1...0.3.2
[0.3.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.3.0...0.3.1
[0.3.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.2.3...0.3.0
[0.2.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.2...0.2.3
[v0.2.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.1...v0.2.2
[v0.2.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.1.0...v0.2.0
