#!/usr/bin/env bash
set -e
wget https://github.com/asobti/kube-monkey/archive/master.zip -O kube-monkey-master.zip
unzip kube-monkey-master.zip 'kube-monkey-master/helm/kubemonkey/*' -d kube-monkey-master
mv kube-monkey-master/kube-monkey-master/helm/kubemonkey files/helm/kube-monkey-chart
rm -r kube-monkey-master.zip kube-monkey-master