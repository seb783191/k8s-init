Creer le namespace:
  kubectl create namespace aws-rds-controller

Cloner le repo aws ack rds-controller :
  Cloner le repo https://github.com/aws-controllers-k8s/rds-controller.git

Changer la valeur de la region :
  cd rds-controller/helm
  Changer dans values.yaml :  region: "" en region: "us-east-1"


Changer les annotations du serviceAccount:

  Récupérer la valeur de ACCOUNT_ID du compte de POC
  Noter sa valeur de ENV

  Changer dans values.yaml : 
    serviceAccount:
      ...
      annotations: {}
  en 
    serviceAccount:
      ...
      annotations:
        eks.amazonaws.com/role-arn: arn:aws:iam::ACCOUNT_ID:role/ENV-eksctl-ack-rds-controller


Installer le helm :
  helm upgrade --install rds-controller -naws-rds-controller -f values.yaml .


Proceder ensuite à iam-binding.sh depuis cloud9
