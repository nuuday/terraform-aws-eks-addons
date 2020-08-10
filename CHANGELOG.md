# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

<a name="unreleased"></a>



<a name="0.9.1"></a>
## [0.9.1] - 2020-08-10
**BUG FIXES**
- conditionally create namespace for prometheus ([#49](https://github.com/nuuday/terraform-aws-eks-addons/issues/49))


<a name="v0.9.0"></a>
## [v0.9.0] - 2020-08-07
**FEATURES**
- add AWS EFS CSI driver add-on module ([#48](https://github.com/nuuday/terraform-aws-eks-addons/issues/48))


<a name="v0.8.5"></a>
## [v0.8.5] - 2020-08-06
**ENHANCEMENTS**
- re-apply ClusterIssuers if email, zones, ingress class changes ([#46](https://github.com/nuuday/terraform-aws-eks-addons/issues/46))


<a name="v0.8.4"></a>
## [v0.8.4] - 2020-08-06
**BUG FIXES**
- ignore EKS CA when running kubectl for Cert Manager ([#45](https://github.com/nuuday/terraform-aws-eks-addons/issues/45))


<a name="v0.8.3"></a>
## [v0.8.3] - 2020-08-03
**BUG FIXES**
- create Loki namespace if it doesn't exist ([#44](https://github.com/nuuday/terraform-aws-eks-addons/issues/44))


<a name="v0.8.2"></a>
## [v0.8.2] - 2020-07-30
**ENHANCEMENTS**
- optionally have Cert Manager recreate ClusterIssuers ([#43](https://github.com/nuuday/terraform-aws-eks-addons/issues/43))


<a name="v0.8.1"></a>
## [v0.8.1] - 2020-07-30
**ENHANCEMENTS**
- allow nginx ingress controller kind to be configured ([#42](https://github.com/nuuday/terraform-aws-eks-addons/issues/42))


<a name="v0.8.0"></a>
## [v0.8.0] - 2020-07-30
**FEATURES**
- allow node selectors and tolerations to be configured for nginx ingress controller ([#41](https://github.com/nuuday/terraform-aws-eks-addons/issues/41))


<a name="v0.7.6"></a>
## [v0.7.6] - 2020-07-27
**ENHANCEMENTS**
- auth against EKS using kubectl --server --token parameters


<a name="v0.7.5"></a>
## [v0.7.5] - 2020-07-24
**ENHANCEMENTS**
- optionally require 'email' for cert-manager ClusterIssuers ([#39](https://github.com/nuuday/terraform-aws-eks-addons/issues/39))


<a name="v0.7.4"></a>
## [v0.7.4] - 2020-07-24
**ENHANCEMENTS**
- output ingress class from nginx-ingress-controller ([#38](https://github.com/nuuday/terraform-aws-eks-addons/issues/38))


<a name="v0.7.3"></a>
## [v0.7.3] - 2020-07-24
**ENHANCEMENTS**
- optionally install ClusterIssuer objects for cert-manager ([#37](https://github.com/nuuday/terraform-aws-eks-addons/issues/37))


<a name="v0.7.2"></a>
## [v0.7.2] - 2020-07-24

- optionally prefer CNAME records over ALIAS ([#35](https://github.com/nuuday/terraform-aws-eks-addons/issues/35))


<a name="v0.7.1"></a>
## [v0.7.1] - 2020-07-24
**ENHANCEMENTS**
- allow nginx-ingress to be deployed in arbitrary namespace ([#36](https://github.com/nuuday/terraform-aws-eks-addons/issues/36))


<a name="v0.7.0"></a>
## [v0.7.0] - 2020-07-24
**FEATURES**
- accept Route53 zone IDs instead of names for External DNS domain filters ([#34](https://github.com/nuuday/terraform-aws-eks-addons/issues/34))


<a name="v0.6.2"></a>
## [v0.6.2] - 2020-07-16
**ENHANCEMENTS**
- Move namespace creation to seperate resource ([#33](https://github.com/nuuday/terraform-aws-eks-addons/issues/33))


<a name="v0.6.1"></a>
## [v0.6.1] - 2020-07-15

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


[Unreleased]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.9.1...HEAD
[0.9.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.0...0.9.1
[v0.9.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.8.5...v0.9.0
[v0.8.5]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.8.4...v0.8.5
[v0.8.4]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.8.3...v0.8.4
[v0.8.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.8.2...v0.8.3
[v0.8.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.8.1...v0.8.2
[v0.8.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.8.0...v0.8.1
[v0.8.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.6...v0.8.0
[v0.7.6]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.5...v0.7.6
[v0.7.5]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.4...v0.7.5
[v0.7.4]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.3...v0.7.4
[v0.7.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.2...v0.7.3
[v0.7.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.1...v0.7.2
[v0.7.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.7.0...v0.7.1
[v0.7.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.6.2...v0.7.0
[v0.6.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.6.1...v0.6.2
[v0.6.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.6.0...v0.6.1
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
