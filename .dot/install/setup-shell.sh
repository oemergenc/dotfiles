#!/bin/bash

# SDKMan
curl -s "https://get.sdkman.io" | bash

# SpaceVim
curl -sLf https://spacevim.org/install.sh | bash

# brew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
brew install --cask google-cloud-sdk
brew install --cask rancher
brew install --cask keepassxc
brew install --cask Licecap
brew install gpg2
brew install gpg-suite
brew install kubectx
brew install flycut

#gcloud
gcloud auth login
gcloud components update
gcloud auth login
gcloud components install gsutil
gcloud components install kubectl
#gcloud dev
gcloud config configurations create 
gcloud config configurations activate rd-ffp-dev-v002
gcloud config set account oemer.genc@rewe-digital.com
gcloud container clusters get-credentials kubernetes --region europe-west1 --project rd-ffp-dev-v002
gcloud config set compute/zone europe-west1
gcloud config set compute/region europe-west1
#gcloud int
gcloud config configurations create rewedigital-refill-int-v001
gcloud config configurations activate rewedigital-refill-int-v001
gcloud config set project rewedigital-refill-int-v001
gcloud config set account oemer.genc@rewe-digital.com
gcloud container clusters get-credentials kubernetes2 --region europe-west1 --project rewedigital-refill-int-v001
gcloud config set compute/zone europe-west1
gcloud config set compute/region europe-west1
#gcloud prd
gcloud config configurations create rewedigital-refill-prd-v001
gcloud config configurations activate rewedigital-refill-prd-v001
gcloud container clusters get-credentials kubernetes2 --region europe-west1 --project rewedigital-refill-prd-v001
gcloud config set project rewedigital-refill-prd-v001
gcloud config set account oemer.genc@rewe-digital.com
gcloud config set compute/zone europe-west1
gcloud config set compute/region europe-west1

#gcloud ml platform
gcloud config configurations create rd-ffp-ml-prd
gcloud config configurations activate rd-ffp-ml-prd
gcloud config set project rd-ffp-ml-prd-8f79
gcloud config set account oemer.genc@rewe-digital.com
gcloud config set compute/zone europe-west1
gcloud config set compute/region europe-west1
