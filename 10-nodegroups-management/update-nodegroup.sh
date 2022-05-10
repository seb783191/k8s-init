#!/bin/bash
if [ $# -lt 1 ]; then
	  echo "Argument manquant: <Environnement:[cdn1|cdn2|...]>"
	    exit 1
fi

ENV=$1
eksctl upgrade nodegroup \
	  --name=nodegroup1 \
	    --cluster=$ENV-eksctl \
	      --kubernetes-version=1.21
