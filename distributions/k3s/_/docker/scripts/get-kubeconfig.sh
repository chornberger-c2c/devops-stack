#!/bin/sh -xe

API_IP_ADDRESS=$(jq -r '.values.root_module.resources[]|select(.type=="docker_container" and .name=="k3s_server").values.ip_address' "$ARTIFACTS_DIR/terraform.tfstate.json")
docker cp "k3s-server-$CLUSTER_NAME:/etc/rancher/k3s/k3s.yaml" "$ARTIFACTS_DIR/kubeconfig.yaml"
sed -i -e "s/127.0.0.1/$API_IP_ADDRESS/" "$ARTIFACTS_DIR/kubeconfig.yaml"