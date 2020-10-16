
export GHUSER="chienyuan"
fluxctl install \
    --git-user=${GHUSER} \
    --git-email=${GHUSER}@users.noreply.github.com \
    --git-url=git@github.com:${GHUSER}/flux-get-started \
    --git-path=namespaces,workloads \
    --namespace=flux | kubectl apply -f -

