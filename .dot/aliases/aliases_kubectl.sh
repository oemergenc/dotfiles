alias omm-prd='kubectl config use-context gke_rd-bigdata-prd-v002_europe-west1-c_bigdata --namespace=omm'
alias omm-int='kubectl config use-context gke_rd-bigdata-int-v002_europe-west1-c_bigdata --namespace=omm'
alias omm-ops='kubectl config use-context gke_rd-bigdata-ops-v002_europe-west1-c_bigdata --namespace=omm'
alias omm-local='kubectl config use-context docker-for-desktop --namespace=omm'

alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'
alias klf='kubectl logs --tail=50000 --follow' 

function omm-jenkins-restart(){
  omm-ops
  echo -n  "Press enter to continue or CTRL-C to abort"
  read var_name
  kubectl --namespace omm delete pod sparks-jenkins-0
}

function omm-jenkins-log(){
  omm-ops
  kubectl --namespace omm logs -f sparks-jenkins-0
}
