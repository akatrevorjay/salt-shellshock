======================
shellshock bash update
======================

This recipe tries to upgrade bash from OS pkg, and falls back to 
compile bash on systems with no update available.

Works for us on old ubuntu/debian.

Usage
=====

Can be used as an gitfs salt formula:

```yaml
fileserver_backend:
    - roots
    - git
 
gitfs_remotes:
    - git://github.com/APSL/salt-shellshock.git
```

Runit:

```sh
    $ sudo salt "oldubuntu" state.sls shellshock
```

---

bonus: Test shellshock from salt:

https://twitter.com/johan_moreau/status/515226448270213121

```sh
$ sudo salt -G 'kernel:Linux' cmd.run "env x='() { :;}; echo vulnerable' bash -c ':' 2>&1 | grep vulnerable"
```
or
```sh
$ sudo salt -G 'kernel:Linux' cmd.retcode "env x='() { :;}; echo vulnerable' bash -c ':' 2>&1 | grep vulnerable"
```
