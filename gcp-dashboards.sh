#!/bin/bash

POD_NAME="victoria-metrics-grafana-58fcd6f6d9-2n4c8"
DEST_DIR="google-cloud"
FILES=(
  "cloud-storage-monitoring.json"
  "cloudfunctions-monitoring.json"
  "cloudsql-monitoring.json"
  "cloudsql-mysql-monitoring.json"
  "cloudsql-postgre-monitoring.json"
  "cloudtasks-monitoring.json"
  "dataprocessing-monitoring.json"
  "firewall-insight-monitoring.json"
  "gce-network-monitoring.json"
  "gce-vm-instance-monitoring.json"
  "gke-prometheus-pod-node-monitoring.json"
  "https-lb-backend-services-monitoring.json"
  "https-loadbalancer-monitoring.json"
  "micro-service-monitoring.json"
  "network-tcp-loadbalancer-monitoring.json"
)

mkdir -p "$DEST_DIR"

for FILE in "${FILES[@]}"; do
  echo "Copy $FILE..."
  kubectl exec -it "$POD_NAME" -- bash -c "cat /usr/share/grafana/public/app/plugins/datasource/cloud-monitoring/dist/dashboards/$FILE" > "$DEST_DIR/$FILE"
  
  if [ $? -eq 0 ]; then
    echo "$FILE saved to $DEST_DIR/"
  else
    echo "Error on file: $FILE"
  fi
done

echo "Done."
