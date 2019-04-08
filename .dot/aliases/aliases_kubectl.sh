
alias omm-prd='kubectl config use-context gke_rd-bigdata-prd-v002_europe-west1-c_bigdata --namespace=omm'
alias omm-int='kubectl config use-context gke_rd-bigdata-int-v002_europe-west1-c_bigdata --namespace=omm'
alias omm-ops='kubectl config use-context gke_rd-bigdata-ops-v002_europe-west1-c_bigdata --namespace=omm'

alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'
alias klf='kubectl logs --tail=50000 --follow' 
