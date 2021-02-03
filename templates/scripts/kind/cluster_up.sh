#!/bin/bash -eu
{% set i = inventory.parameters %}
{% set target_name = i.target_name %}
# set_network:

export KIND_EXPERIMENTAL_DOCKER_NETWORK=scratch

# cluster_up:
kind create cluster --config=compiled/{{ target_name }}/jsonnet/kind.yaml

# replace_loopback:
sed -i "s/127.0.0.1.*/$(docker inspect {{ target_name }}-control-plane | jq -r '.[].NetworkSettings.Networks.scratch.IPAddress' ):6443/" ~/.kube/config 

# get_context:
sleep 2; kubectl cluster-info --context kind-{{ target_name }}