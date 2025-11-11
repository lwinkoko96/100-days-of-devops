### Objective

Use **Ansible’s `package` and `service` modules** to install and manage the lifecycle of services across multiple servers — in this example, the **vsftpd FTP server**.

---

## 1. Inventory File

**File:** `inventory`

```
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner
```

---

## 2. Playbook File

**File:** `playbook.yml`

```yaml
---
- name: Install FTP server packages
  hosts: all
  become: yes
  tasks:
    - name: Ensure vsftpd is installed
      package:
        name: vsftpd
        state: present

    - name: Ensure vsftpd service is started and enabled
      service:
        name: vsftpd
        state: started
        enabled: yes
```

---

## 3. Run the Playbook

```bash
ansible-playbook -i inventory playbook.yml
```

---

## 4. Verify the Service on Each App Server

```bash
systemctl status vsftpd
```

If everything is configured properly, the **vsftpd service** should show as **active (running)**.

---

##  Key Notes

| Module | Purpose |
| --- | --- |
| `package` | Installs, upgrades, or removes system packages |
| `service` | Manages service state (start, stop, enable, disable) |

---

##  Reference

- [Ansible package Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/package_module.html)
- [Ansible service Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_module.html)