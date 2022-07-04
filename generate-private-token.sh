#!/bin/bash

kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: skupper-requested-secret
  labels:
     skupper.io/type: connection-token-request
EOF

sleep 1

kubectl get secrets skupper-requested-secret -o yaml | yq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid,.metadata.annotations.kubectl*) | .metadata.creationTimestamp=null' > ./private-cloud/10-exported-skupper-secret.yaml
