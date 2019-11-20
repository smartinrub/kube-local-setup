
#! /bin/bash

TOKEN="<kubernetes_token>"
CLUSTER_URL="<kubernetes_cluster_url>"
NAMESPACE="<namespace>"

echo "Seting up local environment to use the remote Kubernetes cluster from your local machine"

echo "This will create new entries in ~/.kube/config"
read -r -p "Are you sure you want to continue? [y/N] " response
if [[ "$response" =~ ^([nN][oO]|[nN])+$ ]]
then
    echo "Setup aborted"
    exit 1
fi

echo `kubectl config set-credentials aws-user --token=${TOKEN}`
echo `kubectl config set-cluster aws --server=${CLUSTER_URL} --insecure-skip-tls-verify=true`
echo `kubectl config set-context aws-context --user=aws-user --namespace=${NAMESPACE} --cluster=aws`
echo `kubectl config use-context aws-context`

echo "Done!"
echo "  ___ ___                               __        ___.                  __  .__   
 /   |   \_____  ______ ______ ___.__. |  | ____ _\_ |__   ____   _____/  |_|  |  
/    ~    \__  \ \____ \\____ <   |  | |  |/ /  |  \ __ \_/ __ \_/ ___\   __\  |  
\    Y    // __ \|  |_> >  |_> >___  | |    <|  |  / \_\ \  ___/\  \___|  | |  |__
 \___|_  /(____  /   __/|   __// ____| |__|_ \____/|___  /\___  >\___  >__| |____/
       \/      \/|__|   |__|   \/           \/         \/     \/     \/           "
echo "To view your new kube configuration run: kubctl config view"