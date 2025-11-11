### Objective

Use **Ansible’s yum module** to install and manage packages (like `wget`) across multiple servers automatically.

---

## 1. Inventory File

**File:** `inventory`

```
[app-server1]
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password='Ir0nM@n' ansible_connection=ssh

[app-server2]
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password='Am3ric@' ansible_connection=ssh

[app-server3]
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password='BigGr33n' ansible_connection=ssh
```

---

## 2. Playbook

**File:** `playbook.yml`

```yaml
---
- name: Install wget with yum
  hosts: all
  become: true

  tasks:
    - name: Ensure wget is installed
      yum:
        name: wget
        state: present
        update_cache: true
```

---

## 3. Run Playbook

```bash
ansible-playbook -i inventory playbook.yml
```

---

## Key Notes

| Directive | Description |
| --- | --- |
| `become: true` | Runs tasks as root (sudo) |
| `yum` | Installs or removes packages on RHEL/CentOS systems |
| `state: present` | Ensures the package is installed |
| `update_cache: true` | Updates the yum cache before installation |

---

## Reference

- [Ansible yum Module Docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/yum_module.html)