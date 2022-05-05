ENV=$1
eksctl create nodegroup \
	  --cluster $ENV-eksctl \
	    --region us-east-1 \
	      --name nodegroup1 \
	        --node-type t3.large \
		  --nodes 3 \
		    --nodes-min 2 \
		      --nodes-max 4 \
		        --enable-ssm
