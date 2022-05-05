#Installer logging-operator

kubectl create ns log-collector

kubectl config set-context --current --namespace=log-collector

Installer premierement lopérateur :
  Cloner le repo logging-operator https://github.com/banzaicloud/logging-operator.git

  Aller dans charts/logging-operator
    helm upgrade --install logging-operator .


Puis installer la chart logging-operator-logging :

  Remplacer la valeur  image.repository et image.tag par les valeur perso
  Puis faire l install
  helm upgrade --install logging-operator-logging .

