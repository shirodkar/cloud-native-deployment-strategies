#!/usr/bin/env bash

cd /tmp/deployment/cloud-native-deployment-strategies



oc delete project gitops-pre
oc delete project gitops-prod

oc delete -f blue-green-pipeline-environments/applicationset-shop-blue-green.yaml

oc delete -f blue-green-pipeline-environments/applicationset-cluster-config.yaml
oc delete -f gitops/gitops-operator.yaml
oc delete subscription tekton -n openshift-operators
oc delete clusterserviceversion openshift-pipelines-operator-rh.v1.6.4 -n openshift-operators

oc delete subscription openshift-gitops-operator -n openshift-operators
oc delete clusterserviceversion openshift-gitops-operator.v1.5.6 -n openshift-operators


git checkout main
git branch -d release
git push origin --delete release

#manual
#gitops operator