import { Injectable } from '@angular/core';
import { HttpHeaders, HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/internal/operators/catchError';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AppService {


  constructor(private httpClient: HttpClient) {
    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json',
        'charset':'utf-8',
        'X-Goog-Api-Key':'AIzaSyAi8fZkXubo3n_tAVMhU5Wi7I4OclUl0IQ'
      })
    };
  }

  createCluster(){
    const baseUrl='https://dataproc.googleapis.com'
    const postData={
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
    console.log(this.httpClient.post(baseUrl+'/v1/projects/hadoop-assignment-101/regions/us-central1/clusters/',postData))
    return this.httpClient.post(baseUrl+'/v1/projects/hadoop-assignment-101/regions/us-central1/clusters/',postData);
  }

  // private ReturnResponseData(response: any) {
  //   return response;
  // }
  // private handleError(error: any) {
  //   return throwError(error);
  // }
}
