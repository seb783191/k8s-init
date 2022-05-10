ENV=$1
HostedZoneName="$2"
Name="*.$ENV.$HostedZoneName"
AlbName=$3
HostedZoneId=$4
aws cloudformation deploy --template-file route53.yaml  --stack-name eksctl-cdn1-eksctl-route53 --capabilities CAPABILITY_NAMED_IAM --parameter-overrides HostedZoneName=$HostedZoneName"." Name=$Name AlbName=$AlbName HostedZoneId=$HostedZoneId
