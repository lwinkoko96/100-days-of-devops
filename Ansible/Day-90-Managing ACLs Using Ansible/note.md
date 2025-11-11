### Objective

Automate **file creation and ACL configuration** across multiple app servers using **Ansible’s `file`** and **`acl`** modules.

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

---

## 3. Run the Playbook

```bash
ansible-playbook -i inventory playbook.yml
```

---

## 4. Verify ACLs and File Details

### On App Server 1

```bash
[tony@stapp01 ~]$ getfacl /opt/dba/blog.txt
getfacl: Removing leading '/' from absolute path names
# file: opt/dba/blog.txt
# owner: root
# group: root
user::rw-
group::r--
group:tony:r--
mask::r--
other::r--

[tony@stapp01 ~]$ ls -l /opt/dba/blog.txt
-rw-r--r--+ 1 root root 0 Nov  3 12:06 /opt/dba/blog.txt
```

### On App Server 2

```bash
[steve@stapp02 ~]$ getfacl /opt/dba/story.txt
```

### On App Server 3

```bash
[banner@stapp03 ~]$ getfacl /opt/dba/media.txt
```

---

## Key Notes

| Module | Purpose |
| --- | --- |
| `file` | Creates files or directories with specific ownership & permissions |
| `acl` | Manages POSIX ACLs for users and groups |
| `when` | Conditional execution per server |
| `become: true` | Runs tasks with elevated privileges |

---

## Reference

- [Ansible posix.acl Module Docs](https://docs.ansible.com/ansible/latest/collections/ansible/posix/acl_module.html)
- [Ansible file Module Docs](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)