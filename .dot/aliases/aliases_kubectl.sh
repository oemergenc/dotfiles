alias ffp-dev='kctx gke_rd-ffp-dev-v002_europe-west1_kubernetes'
alias dev-name='echo -n rd-ffp-dev-v002|pbcopy'
alias ffp-int='kctx gke_rewedigital-refill-int-v001_europe-west1_kubernetes2'
alias int-name='echo -n rewedigital-refill-int-v001|pbcopy'
alias ffp-prd='kctx gke_rewedigital-refill-prd-v001_europe-west1_kubernetes2'
alias data-test='kctx gke_rd-analytics-data-eng-dev-348d_europe-west1_data-engineering'
alias prd-name='echo -n rewedigital-refill-prd-v001|pbcopy'
alias ffp-core-int='picker intcore'
alias ffp-core-prd='picker prdcore'

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

function copypod(){
    findpod | tail -1 | awk '{print $1}' | pbcopy
}
