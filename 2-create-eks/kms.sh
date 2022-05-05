#aws kms create-alias --alias-name alias/$ENV-eksctl --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
echo $ENV
export MASTER_ARN=$(aws kms describe-key --key-id alias/${ENV}-eksctl --query KeyMetadata.Arn --output text)

#echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile
