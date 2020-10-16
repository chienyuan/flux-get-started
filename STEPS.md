# Get start flux

- create flux namespace
kubectl create ns flux


- install flux
fluxinstall.sh
```
export GHUSER="chienyuan"
fluxctl install \
    --git-user=${GHUSER} \
    --git-email=${GHUSER}@users.noreply.github.com \
    --git-url=git@github.com:${GHUSER}/flux-get-started \
    --git-path=namespaces,workloads \
    --namespace=flux | kubectl apply -f -
```

Warning: rbac.authorization.k8s.io/v1beta1 ClusterRole is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 ClusterRole
clusterrole.rbac.authorization.k8s.io/flux created
Warning: rbac.authorization.k8s.io/v1beta1 ClusterRoleBinding is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 ClusterRoleBinding
clusterrolebinding.rbac.authorization.k8s.io/flux created

kubectl -n flux rollout status deployment/flux

- found ssh public key
fluxctl identity --k8s-fwd-ns flux

- add ssh pulbic key into github Setting > Deploy Keys

- check
kubectl -n demo port-forward deployment/podinfo 9898:9898
curl 127.0.0.1:9898

Handling connection for 9898
{
  "hostname": "podinfo-6fb4c8894d-fppcj",
  "version": "3.1.0",
  "revision": "7b6f11780ab1ce8c7399da32ec6966215b8e43aa",
  "color": "#34577c",
  "logo": "https://raw.githubusercontent.com/stefanprodan/podinfo/gh-pages/cuddle_clap.gif",
  "message": "greetings from podinfo v3.1.0",
  "goos": "linux",
  "goarch": "amd64",
  "runtime": "go1.13.1",
  "num_goroutine": "10",
  "num_cpu": "8"
}

- Replace YOURUSER in https://github.com/YOURUSER/flux-get-started/blob/master/workloads/podinfo-dep.yaml with your GitHub ID), open the URL in your browser, edit the file, add --ui-message='Welcome to Flux' to the container command and commit the file.


git commit -m "update podinfo"
git push

- wait 5 min to sync or sync now
fluxctl sync --k8s-fwd-ns flux

- check again
curl 127.0.0.1:9898
{
  "hostname": "podinfo-6496f8785c-2ckr4",
  "version": "3.1.5",
  "revision": "948de81ed319b4cae86ef9758866165acd4426a2",
  "color": "#34577c",
  "logo": "https://raw.githubusercontent.com/stefanprodan/podinfo/gh-pages/cuddle_clap.gif",
  "message": "'Welcome to Flux'",
  "goos": "linux",
  "goarch": "amd64",
  "runtime": "go1.13.6",
  "num_goroutine": "10",
  "num_cpu": "8"
}

 



