# ansible-role-cvsync

Configures `cvsync(1)` to mirror remote `CVS` repository.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `cvsync_user` | owner of `base-prefix` directory | `{{ __cvsync_user }}` |
| `cvsync_group` | group of `base-prefix` directory | `{{ __cvsync_group }}` |
| `cvsync_conf_dir` | path to directory where `cvsync.conf` is kept | `{{ __cvsync_conf_dir }}` |
| `cvsync_conf_file` | path to `cvsync.conf` | `{{ cvsync_conf_dir }}/cvsync.conf` |
| `cvsync_config` | list of configurations (see below) | `[]` |

## `cvsync_config`

This variable is a list of configurations. Each element is a dict whose keys and values are explained below.

| Key | Value | Mandatory? |
|-----|-------|------------|
| `base-prefix` | path to the base directory of the collection | yes |
| `collection` | list of configuration string of each collection | yes |
| any other options described in `cvsync(1)` | value of the option, or empty string | no |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__cvsync_user` | `_cvsyncd` |
| `__cvsync_group` | `_cvsyncd` |
| `__cvsync_conf_dir` | `/etc` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-cvsync
  vars:
    cvsync_config:
      - hostname: cvsync.allbsd.org
        base-prefix: /home/vagrant/cvs
        collection:
          - name tendra-www release rcs
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
