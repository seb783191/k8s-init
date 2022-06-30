Creer le namespace:

  kubectl create namespace argocd

Installer une premier fois le helm

  helm upgrade --install argocd -f values.yaml . -nargocd

  Tous les pods devraient démarrer

Récupérer le token du serviceAccount application-controller
Changer la valeur cluster.eks.config dans values.yaml

N.B : Rajouter le secret cluster-eks avec la valeur du token du serviceAccount application-controller permet de pouvoir atteindre tous les namespaces du cluster.
      Car le in-cluster par défaut n'est cablé que sur le namesape "argocd"

Upgrader le helm argocd :

  helm upgrade --install argocd -f values.yaml . -nargocd


Se rendre sur son url : http://argocd.ENV.domainName
Le user argocd de l'ihm est : admin
Le mot de passe se trouve dans le secret argocd-cluster

Aller dans les paramètres et sur "Clusters"
Aller dans cluster-eks. Vérifier qu'il y a "All Namespaces". Sinon modifier

Vous pouvez maintenant rajouter des repositories dans "Repositories" et déployer des applications
