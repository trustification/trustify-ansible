<!--- to update this file, update files in the role's meta/ directory (and/or its README.j2 template) and run "make role-readme" -->
# Ansible Role: redhat.trusted_profile_analyzer.tpa_single_node
Version: 2.0.0

Deploy the [RHTPA](https://docs.redhat.com/en/documentation/red_hat_trusted_profile_analyzer/) service on a single managed node by using the `tpa_single_node` role.
 Requires RHEL 9.3 or later.

## Role Arguments
### Required
|Option|Description|Type|Default|
|---|---|---|---|
| tpa_single_node_pg_admin | DB admin user. | str |  |
| tpa_single_node_pg_admin_passwd | DB admin password. | str |  |
| tpa_single_node_pg_user | DB user. | str |  |
| tpa_single_node_pg_user_passwd | DB user password. | str |  |
| tpa_single_node_tls_trust_anchor_cert | rootCA path on the controller machine | str |  |
| tpa_single_node_tls_server_cert | pem path on the controller machine | str |  |
| tpa_single_node_tls_server_key | key path on the controller machine | str |  |

### Optional
|Option|Description|Type|Default|
|---|---|---|---|
| tpa_single_node_trustification_image | Trustification image. | str |  `registry.redhat.io/rhtpa/rhtpa-trustification-service-rhel9:0bef82c8139cc89ef4840e36ad519ca24bb54f70`  |
| tpa_single_node_base_hostname | The user name logging in to the registry to pull images. | str |  `trustification`  |
| tpa_single_node_rhel_host | Ip of the instance. | str |  |
| tpa_single_node_certificates_dir | Folder where to place the certificates to deploy on the instance. | str |  `certs`  |
| tpa_single_node_config_dir | Configuration directory on the instance. | str |  `/etc/rhtpa`  |
| tpa_single_node_kube_manifest_dir | Configuration directory on the instance containing the manifests. | str |  `/etc/rhtpa/manifests`  |
| tpa_single_node_namespace | Podman network namespace. | str |  `trustification`  |
| tpa_single_node_podman_network | Podman network name. | str |  `tcnet`  |
| tpa_single_node_systemd_directory | Folder where to store the systemd configurations files. | str |  `/etc/systemd/system`  |
| tpa_single_node_default_empty | Default empty value. | str |  |
| tpa_single_node_pg_host | Host ip of the postgresql db instance. Readed from the TPA_PG_HOST env | str |  |
| tpa_single_node_pg_port | Port of the postgresql db instance. | str |  `5432`  |
| tpa_single_node_pg_db | DB name. | str |  `trustify`  |
| tpa_single_node_pg_ssl_mode | DB SSL mode require/allow. | str |  `require`  |
| tpa_single_node_oidc_issuer_url | Readed from TPA_OIDC_ISSUER_URL env var | str |  |
| tpa_single_node_oidc_frontend_id | Readed from TPA_OIDC_FRONTEND_ID env var | str |  |
| tpa_single_node_oidc_client_id | Readed from TPA_OIDC_CLIENT_ID env var | str |  |
| tpa_single_node_oidc_client_secret | Readed from TPA_OIDC_CLIENT_SECRET env var | str |  |
| tpa_single_node_oidc_tls_insecure | Readed from TPA_OIDC_TLS_INSECURE env var | str |  |
| tpa_single_node_aws_cognito_domain | Readed from TPA_OIDC_COGNITO_DOMAIN env var | str |  |
| tpa_single_node_storage_access_key | Read from 'TPA_STORAGE_ACCESS_KEY' env var | str |  |
| tpa_single_node_storage_secret_key | Read from 'TPA_STORAGE_SECRET_KEY' env var | str |  |
| tpa_single_node_storage_bucket | Read from 'TPA_STORAGE_S3_BUCKET' env var | str |  |
| tpa_single_node_storage_region | Read from 'TPA_STORAGE_REGION' env var | str |  |
| tpa_single_node_storage_minio_endpoint | Read from 'TPA_STORAGE_MINIO_ENDPOINT' env var | str |  |
| tpa_single_node_storage_secret | storage-secret.yaml path on the target machine | str |  `/etc/rhtpa/manifests/storage-secret.yaml`  |
| tpa_single_node_oidc_secret | oidc-secret.yaml path on the target machine | str |  `/etc/rhtpa/manifests/oidc-secret.yaml`  |
| tpa_single_node_probe_initial_delay_seconds | Initial prob delay in seconds | int |  `30`  |
| tpa_single_node_cpu | CPU for deployment | int |  `1`  |
| tpa_single_node_memory | Memory for deployment | str |  `8Gi`  |
| tpa_single_node_server_pvc_claim | Server PVC Claim | str |  `32Gi`  |
| tpa_single_node_log_filter | Rust Log filter | str |  `info`  |
| tpa_single_node_server_req_limit | HTTP Server Request limit | str |  |
| tpa_single_node_server_json_limit | HTTP Server JSON limit | str |  |
| tpa_single_node_upload_limit | Upload limit for Files | str |  |
| tpa_single_node_storage_compression | Compression logic for storage | str |  |

## Example Playbook

```
- hosts: rhtpa
  vars:
    tpa_single_node_pg_admin: # TODO: required, type: str
    tpa_single_node_pg_admin_passwd: # TODO: required, type: str
    tpa_single_node_pg_user: # TODO: required, type: str
    tpa_single_node_pg_user_passwd: # TODO: required, type: str
    tpa_single_node_tls_trust_anchor_cert: # TODO: required, type: str
    tpa_single_node_tls_server_cert: # TODO: required, type: str
    tpa_single_node_tls_server_key: # TODO: required, type: str
    
  tasks:
    - name: Include TPA single node role
      ansible.builtin.include_role:
        name: redhat.trusted_profile_analyzer.tpa_single_node
      vars:
        ansible_become: true
```

## License

Apache-2.0

## Author and Project Information

Red Hat
