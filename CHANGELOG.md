# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this
project adheres to [Semantic Versioning](http://semver.org/).

<a name="unreleased"></a>



<a name="0.14.0"></a>
## [0.14.0] - 2020-12-03
**FEATURES**
- Add variable to insure the validity of incoming ingress objects in case developers use invalid configuration for the ingress objects (K8-180) ([#76](https://github.com/nuuday/terraform-aws-eks-addons/issues/76))


<a name="v0.13.8"></a>
## [v0.13.8] - 2020-11-19

- terraform fmt
- Enable ondemand throughput mode, since autoscaling config wasnt effective


<a name="v0.13.7"></a>
## [v0.13.7] - 2020-11-13

- Really set prometheus persistence size
- Really set prometheus persistence size


<a name="v0.13.6"></a>
## [v0.13.6] - 2020-11-04

- label namespace with role=prometheus ([#73](https://github.com/nuuday/terraform-aws-eks-addons/issues/73))


<a name="v0.13.5"></a>
## [v0.13.5] - 2020-11-03



<a name="v0.13.4"></a>
## [v0.13.4] - 2020-11-03



<a name="v0.13.3"></a>
## [v0.13.3] - 2020-11-03



<a name="v0.13.2"></a>
## [v0.13.2] - 2020-11-03

- bumbed version to test actions


<a name="v0.13.1"></a>
## [v0.13.1] - 2020-11-03

- added secret to publish to s3


<a name="v0.13.0"></a>
## [v0.13.0] - 2020-10-16
**FEATURES**
- Added new build workflow using packages


<a name="v0.12.2"></a>
## [v0.12.2] - 2020-10-16



<a name="v0.12.1"></a>
## [v0.12.1] - 2020-10-16



<a name="v0.12.0"></a>
## [v0.12.0] - 2020-09-23

- Added prometheus operator module


<a name="v0.11.0"></a>
## [v0.11.0] - 2020-09-23

- Added ability customize controller resources
- add namespace labe to filter ingress traffic in network policy ([#68](https://github.com/nuuday/terraform-aws-eks-addons/issues/68))


<a name="v0.10.3"></a>
## [v0.10.3] - 2020-09-10
**ENHANCEMENTS**
- add 'wait' variable to all modules


<a name="v0.10.2"></a>
## [v0.10.2] - 2020-09-10
**ENHANCEMENTS**
- add label to filter ingress traffic in NetworkPolicy ([#66](https://github.com/nuuday/terraform-aws-eks-addons/issues/66))


<a name="v0.10.1"></a>
## [v0.10.1] - 2020-09-09
**ENHANCEMENTS**
- Increase loki namespace deletion timeout


<a name="v0.10.0"></a>
## [v0.10.0] - 2020-08-28
**FEATURES**
- add Calico addon ([#64](https://github.com/nuuday/terraform-aws-eks-addons/issues/64))


<a name="v0.9.14"></a>
## [v0.9.14] - 2020-08-27

- allow route53_zones to be passed without type errors


<a name="v0.9.13"></a>
## [v0.9.13] - 2020-08-26

- apply retention on S3 objects like done on DynamoDB indices


<a name="v0.9.12"></a>
## [v0.9.12] - 2020-08-25

- allow a map of arbitrary type to be passed as value overrides


<a name="v0.9.11"></a>
## [v0.9.11] - 2020-08-25

- output prometheus-server URL
- remove unused resource


<a name="v0.9.10"></a>
## [v0.9.10] - 2020-08-25

- add variable for custom prometheus uri ([#59](https://github.com/nuuday/terraform-aws-eks-addons/issues/59))


<a name="v0.9.9"></a>
## [v0.9.9] - 2020-08-20
**ENHANCEMENTS**
- allow chart values to be overridden for Loki


<a name="v0.9.8"></a>
## [v0.9.8] - 2020-08-14
**ENHANCEMENTS**
- bump s3-bucket module version to support aws v3 provider ([#57](https://github.com/nuuday/terraform-aws-eks-addons/issues/57))


<a name="v0.9.7"></a>
## [v0.9.7] - 2020-08-13
**ENHANCEMENTS**
- conditionally create namespace for prometheus ([#56](https://github.com/nuuday/terraform-aws-eks-addons/issues/56))


<a name="v0.9.6"></a>
## [v0.9.6] - 2020-08-13
**ENHANCEMENTS**
- pin and update terraform-aws-* modules ([#55](https://github.com/nuuday/terraform-aws-eks-addons/issues/55))


<a name="v0.9.5"></a>
## [v0.9.5] - 2020-08-13

- Changed logic around creating the loki namespace.


<a name="v0.9.4"></a>
## [v0.9.4] - 2020-08-13

- Reformatted code
- Fixed terraform modules to a specific version


<a name="v0.9.3"></a>
## [v0.9.3] - 2020-08-13
**BUG FIXES**
- produce valid ClusterIssuer when no dns01 solvers are supplied


<a name="v0.9.2"></a>
## [v0.9.2] - 2020-08-11
**ENHANCEMENTS**
- allow extra_args to be passed to cluster-autoscaler ([#50](https://github.com/nuuday/terraform-aws-eks-addons/issues/50))


<a name="v0.9.1"></a>
## [v0.9.1] - 2020-08-10
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


[Unreleased]: https://github.com/nuuday/terraform-aws-eks-addons/compare/0.14.0...HEAD
[0.14.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.8...0.14.0
[v0.13.8]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.7...v0.13.8
[v0.13.7]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.6...v0.13.7
[v0.13.6]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.5...v0.13.6
[v0.13.5]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.4...v0.13.5
[v0.13.4]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.3...v0.13.4
[v0.13.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.2...v0.13.3
[v0.13.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.1...v0.13.2
[v0.13.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.13.0...v0.13.1
[v0.13.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.12.2...v0.13.0
[v0.12.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.12.1...v0.12.2
[v0.12.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.12.0...v0.12.1
[v0.12.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.11.0...v0.12.0
[v0.11.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.10.3...v0.11.0
[v0.10.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.10.2...v0.10.3
[v0.10.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.10.1...v0.10.2
[v0.10.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.10.0...v0.10.1
[v0.10.0]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.14...v0.10.0
[v0.9.14]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.13...v0.9.14
[v0.9.13]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.12...v0.9.13
[v0.9.12]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.11...v0.9.12
[v0.9.11]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.10...v0.9.11
[v0.9.10]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.9...v0.9.10
[v0.9.9]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.8...v0.9.9
[v0.9.8]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.7...v0.9.8
[v0.9.7]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.6...v0.9.7
[v0.9.6]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.5...v0.9.6
[v0.9.5]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.4...v0.9.5
[v0.9.4]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.3...v0.9.4
[v0.9.3]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.2...v0.9.3
[v0.9.2]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.1...v0.9.2
[v0.9.1]: https://github.com/nuuday/terraform-aws-eks-addons/compare/v0.9.0...v0.9.1
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
