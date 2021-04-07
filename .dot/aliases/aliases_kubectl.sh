alias omm-prd='kubectx gke_rd-bigdata-prd-v002_europe-west1-c_bigdata; kubens omm;'
alias omm-int='kubectx gke_rd-bigdata-int-v002_europe-west1-c_bigdata; kubens omm'
alias omm-ops='kubectx gke_rd-bigdata-ops-v002_europe-west1-c_bigdata; kubens omm'
alias ffp-dev='picker dev'
alias ffp-int='picker int'
alias ffp-prd='picker prd'
alias ffp-core-int='picker intcore'
alias ffp-core-prd='picker prdcore'
alias ai-sbx='kubectx gke_rd-team-sparks-sbx_europe-west1-c_cluster-1; kubens default'
alias omm-local='kubectx docker-for-desktop; kubens omm'

alias g='gcloud'
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'
alias klf='kubectl logs --tail=50000 --follow' 
alias kge='kubectl get events' 
alias kns='kubens' 
alias kctx='kubectx' 

function gcloud() {
  if ! type __start_gcloud >/dev/null 2>&1; then
      source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
      source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  fi
  command gcloud "$@"
}

function kubectl() {
  if ! type __start_kubectl >/dev/null 2>&1; then
      source <(command kubectl completion zsh)
  fi
  command kubectl "$@"
}

function microk8sstart(){
     microk8s start
     alias kubectl='microk8s.kubectl'
}

function microk8sstop(){
     microk8s stop
     unalias kubectl
}

function set_kube_context_var() {
  # local theContext = "${grep "current-context" $HOME/.kube/config | sed s/gke_//g | sed s/_europe-west1-c_bigdata//g | sed s/current-context:\w{1}//g | sed s/current-context:\ //g}"
  # local theContext = "rd-bigdata-int"
  iterm2_set_user_var kubeContext "naskxjnask"
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
