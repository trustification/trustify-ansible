# External Services locally With Docker compose

### compose

Requires `podman-compose` to run dependent services.

For Linux systems only:

```shell
export SELINUX_VOLUME_OPTIONS=':Z'
```

#### to use http for the local development:

```shell
cd vm-testing/compose
podman-compose -f compose-http.yaml up
```

```shell
cd vm-testing/compose
podman-compose -f compose-http.yaml down
```
