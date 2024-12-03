# Change Log
## v1.0.0 ~ v1.0.6
> Original Helm Chart is from [airbyte](https://github.com/airbytehq/airbyte-platform) v0.43.0
### Added
1. questions.yaml: A yaml file for Rancher Apps.
2. check-lbchecker-job.yaml: A job for checking loadbalancer ip in available loadbalancer ip range.

### Modified
1. Add backup label to every file in templates folder (eonkube: {{ .Values.backupLabels.eonkube }}).
2. values.yaml: Add some parameter for the questions.yaml, backup labels and service.yaml. Also, modified some default values. 
3. service.yaml: Add additional annotations for the service.
4. README.md: Modify content.
5. Chart.yaml: Modify version and other settings.
6. deployment.yaml: modify the resources tempalte. 
7. Modified ingress parameters.
8. add initContainers in server and controller deployment to await postgresql ready.
