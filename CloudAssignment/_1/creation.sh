#creation of dataproc with two worker nodes

gcloud dataproc clusters create cluster-9c40 
--enable-component-gateway 
--region us-central1 
--zone us-central1-f 
--master-machine-type n1-standard-2 
--master-boot-disk-size 100 
--num-workers 2 
--worker-machine-type n1-standard-2 
--worker-boot-disk-size 50 
--image-version 2.0-debian10 
--scopes 'https://www.googleapis.com/auth/cloud-platform' 
--project hadoop-assignment-101

POST /v1/projects/hadoop-assignment-101/regions/us-central1/clusters/
{
  "projectId": "hadoop-assignment-101",
  "clusterName": "cluster-9c40",
  "config": {
    "configBucket": "",
    "gceClusterConfig": {
      "serviceAccountScopes": [
        "https://www.googleapis.com/auth/cloud-platform"
      ],
      "networkUri": "default",
      "subnetworkUri": "",
      "internalIpOnly": false,
      "zoneUri": "us-central1-f",
      "metadata": {},
      "tags": [],
      "shieldedInstanceConfig": {
        "enableSecureBoot": false,
        "enableVtpm": false,
        "enableIntegrityMonitoring": false
      }
    },
    "masterConfig": {
      "numInstances": 1,
      "machineTypeUri": "n1-standard-2",
      "diskConfig": {
        "bootDiskType": "pd-standard",
        "bootDiskSizeGb": "100",
        "numLocalSsds": 0,
        "localSsdInterface": "SCSI"
      },
      "minCpuPlatform": "",
      "imageUri": ""
    },
    "softwareConfig": {
      "imageVersion": "2.0-debian10",
      "properties": {},
      "optionalComponents": []
    },
    "lifecycleConfig": {},
    "initializationActions": [],
    "encryptionConfig": {
      "gcePdKmsKeyName": ""
    },
    "autoscalingConfig": {
      "policyUri": ""
    },
    "endpointConfig": {
      "enableHttpPortAccess": true
    },
    "securityConfig": {
      "kerberosConfig": {}
    },
    "workerConfig": {
      "numInstances": 2,
      "machineTypeUri": "n1-standard-2",
      "diskConfig": {
        "bootDiskType": "pd-standard",
        "bootDiskSizeGb": "50",
        "numLocalSsds": 0,
        "localSsdInterface": "SCSI"
      },
      "minCpuPlatform": "",
      "imageUri": ""
    },
    "secondaryWorkerConfig": {
      "numInstances": 0
    }
  },
  "labels": {},
  "status": {},
  "statusHistory": [
    {}
  ],
  "metrics": {}
}