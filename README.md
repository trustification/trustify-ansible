# Red Hat Trusted Profile Analyzer Ansible collection

The purpose of this Ansible collection is to automate the deployment of Red Hat's Trusted Profile Analyzer (RHTPA) version 2 for Red Hat Enterprise Linux (RHEL).

**IMPORTANT:** 
Deploying RHTPA by using Ansible is a Technology Preview feature only.
Technology Preview features are not supported with Red Hat production service level agreements (SLAs), might not be functionally complete, and Red Hat does not recommend to use them for production.
These features give early access to upcoming product features, enabling customers to test functionality and give feedback during the development process.
See the support scope for [Red Hat Technology Preview](https://access.redhat.com/support/offerings/techpreview/) features for more details.

## Description

The RHTPA service is the downstream redistribution of the [Trustify](https://github.com/trustification/trustify) project.
The automation contained within this Git repository installs and configures the components of RHTPA to run on a single RHEL server by using a standalone containerized deployment. A Kubernetes-based manifest creates containers that uses [`podman kube play`](https://docs.podman.io/en/latest/markdown/podman-kube-play.1.html).

The RHTPA Ansible collection deploys the following RHTPA components:

- [Trustify](https://github.com/trustification/trustify)

## Minimum hardware requirements

* 24 vCPU
* 48 GB RAM
* 100 GB of free disk space

## Requirements

* Ansible 2.16.0 or greater.
* Python 3.10.0 or greater.
* Red Hat Enterprise Linux 9.3 or greater for the x86_64 architecture.
* Installation and configuration of Ansible on a control node to perform the automation.
* External services:
    * An OpenID Connect (OIDC) provider.
    * A new PostgreSQL database.

## External services

### OIDC providers

* [Red Hat Single Sign-On](https://access.redhat.com/products/red-hat-single-sign-on/)
* [Setup RHSSO](https://github.com/trustification/trustify/blob/main/docs/book/modules/admin/pages/infrastructure.adoc#keycloak)
* [Setup AWS Cognito](https://github.com/trustification/trustify/blob/main/docs/book/modules/admin/pages/infrastructure.adoc)

### PostgreSQL database

Create a PostgreSQL database and configure your database credentials in the environment variables.
You can use other database configurations in the `roles/tpa_single_node/vars/main.yml` file.

The following steps guide you on how to configure, and provision RHTPA to run on Red Hat Enterprise Linux.

## Installation

### Configuring the controller node

On the controller node, export the following environment variables replacing the placeholders with your relevant information:

```
export TPA_SINGLE_NODE_REGISTRY_USERNAME=<Your Red Hat image registry username>
export TPA_SINGLE_NODE_REGISTRY_PASSWORD=<Your Red Hat image registry password>
export TPA_PG_HOST=<POSTGRES HOST IP>
export TPA_PG_ADMIN=<DB ADMIN>
export TPA_PG_ADMIN_PASSWORD=<DB ADMIN PASSWORD>
export TPA_PG_USER=<DB USER>
export TPA_PG_USER_PASSWORD=<DB PASSWORD>
export TPA_OIDC_ISSUER_URL=<AWS Cognito or Keycloak Issuer URL. Incase of Keycloak endpoint auth/realms/chicken is needed>
export TPA_OIDC_FRONTEND_ID=<OIDC Frontend Id>
export TPA_OIDC_PROVIDER_CLIENT_ID=<OIDC Walker Id>
export TPA_OIDC_PROVIDER_CLIENT_SECRET=<OIDC Walker Secret>
```

Choose between Keycloak or AWS Cognito, and update the `roles/tpa_single_node/defaults/main.yml` file accordingly.

If you select AWS Cognito as your OIDC provider, then create an environment variable pointing to the AWS Cognito domain:

```
export TPA_OIDC_COGNITO_DOMAIN=<AWS Cognito Domain>
```

By default, a single importer instance with four concurrent jobs will run.
You can have four importer instances with a single job for each instance by setting `multiple` for the `tpa_single_node_importer` option.

```
tpa_single_node_importer: multiple
```

### Updating the inventory and the playbook

To deploy RHTPA on a Red Hat Enterprise Linux version 9.3 or later do the following:

Update the content of the `inventory.ini` file in the project:

```
[trustification]
<IP_TARGET_MACHINE>

[trustification:vars]
ansible_user=<username>
ansible_ssh_pass=<ssh_password>
ansible_private_key_file=<path to private key>
```

Configure if needed the `ansible.cfg` file in the project:

```
[defaults]
inventory = ./inventory.ini
host_key_checking =
```

Copy your certificate files into the certs/ directory with the following names:

```
server-cert.pem
server-key.pem
rootCA-cert.pem
```

Optionally, you can update the variable `tpa_single_node_certificates_dir` in the `roles/tpa_single_node/vars/main.yml` file with the `certs/` directory.
You can also give the specific certificate names for the associated variables:

```
tpa_single_node_tls_trust_anchor
tpa_single_node_tls_server_cert
tpa_single_node_tls_server_key
```

Refer `roles/tpa_single_node/vars/main_example_aws.yml` and `roles/tpa_single_node/vars/main_example_nonaws.yml` for more details.

Run the Ansible Playbook:

```
export ANSIBLE_ROLES_PATH="roles/" ;
ansible-playbook -i inventory.ini play.yml -vv
```

## Contributing

## Support

Support tickets for RedHat Trusted Profile Analyzer can be opened at https://access.redhat.com/support/cases/#/case/new?product=Red%20Hat%20Trusted%20Profile%20Analyzer.

## Release notes and Roadmap

You can read the latest release notes [here](https://docs.redhat.com/en/documentation/red_hat_trusted_profile_analyzer/2.0/html/release_notes/index).

## Related Information

You can find more information about Red Hat Trusted Profile Analyzer [here](https://access.redhat.com/products/red-hat-trusted-profile-analyzer).

## Feedback

Any and all feedback is welcome.
Submit an [Issue](https://github.com/trustification/trustify-ansible/issues) or [Pull Request](https://github.com/trustification/trustify-ansible/pulls) as needed.

## License Information

You can find license information within the [LICENSE](https://github.com/trustification/trustification-ansible/blob/main/LICENSE) file.
