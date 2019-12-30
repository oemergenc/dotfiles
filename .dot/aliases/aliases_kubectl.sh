alias omm-prd='kubectx gke_rd-bigdata-prd-v002_europe-west1-c_bigdata; kubens omm'
alias omm-int='kubectx gke_rd-bigdata-int-v002_europe-west1-c_bigdata; kubens omm'
alias omm-ops='kubectx gke_rd-bigdata-ops-v002_europe-west1-c_bigdata; kubens omm'
alias omm-local='kubectx docker-for-desktop; kubens omm'

alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'
alias klf='kubectl logs --tail=50000 --follow' 
alias kge='kubectl get events' 
alias kns='kubens' 
alias kctx='kubectx' 

function kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
      source <(command kubectl completion zsh)
  fi
  command kubectl "$@"
}

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

function copypod(){
    findpod | tail -1 | awk '{print $1}' | pbcopy
}
