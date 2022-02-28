# DNS

* **Project**: https://github.com/kubernetes-sigs/external-dns
* **Project**: https://www.powerdns.com/opensource.html

This helm is an integration of PowerDNS with external-dns to create a DNS
which every record is saved in the `values.yaml` or pusblished dinamically
based on the LoadBalancers and ingresses running in the cluster.

## Known issues

### failed to sync cache: timed out waiting for the condition

There is an RBAC configuration error. The service account has no access to all
the objects it has to source. Here be dragons.

### Pod restarts once then has no zones

The zone fail is incorrect and the database is not populated. The sqlite database
exists so it is not populated again.

### Changing the zones does not restart the DNS

An annotation with the has of the file is missing
