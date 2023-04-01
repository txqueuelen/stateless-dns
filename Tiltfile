# Safe checks
allow_k8s_contexts('minikube')


# PowerDNS image
docker_build('ci.local/txqueuelen/stateless-dns/powerdns', '.', dockerfile='Dockerfile')


# PowerDNS deployment
k8s_yaml(
    helm(
        'charts/stateless-dns',
        name='stateless-dns',
        namespace='stateless-dns',
        values=['charts/stateless-dns/ci/e2e-values.yaml'],
    )
)


# PowerDNS deployment
k8s_yaml(
    helm(
        'testing/chart',
        name='test-chart',
        namespace='stateless-dns',
    )
)
