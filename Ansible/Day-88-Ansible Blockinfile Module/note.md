### Objective

Use **Ansible’s `blockinfile` module** to create and manage multiline content inside a file — in this case, a sample web page for Apache on all app servers.

---

## 1. Inventory File

**File:** `inventory`

```
[all]
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner
```

---

## 2. Playbook File

**File:** `playbook.yml`

```yaml
---
- name: Install and configure Apache web server on all app servers
  hosts: all
  become: yes
  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: latest

    - name: Ensure httpd service is running and enabled
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Create sample index.html file using blockinfile
      blockinfile:
        path: /var/www/html/index.html
        create: yes
        block: |
          Welcome to XfusionCorp!

          This is Nautilus sample file, created using Ansible!

          Please do not modify this file manually!

    - name: Set ownership of index.html to apache
      file:
        path: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0644'
```

---

## 3. Run the Playbook

```bash
ansible-playbook -i inventory playbook.yml
```

---

## 4. Verify the Results

```bash
ssh tony@stapp01
cat /var/www/html/index.html
ls -l /var/www/html/index.html
```

Repeat the verification on each app server (stapp01, stapp02, stapp03).

---

## Key Notes

| Module | Purpose |
| --- | --- |
| `yum` | Installs or updates Apache (`httpd`) package |
| `service` | Ensures the Apache service is started and enabled |
| `blockinfile` | Inserts or updates a block of text in a file |
| `file` | Sets file ownership and permissions |

---

## Reference

- [Ansible blockinfile Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/blockinfile_module.html)
- [Ansible File Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)