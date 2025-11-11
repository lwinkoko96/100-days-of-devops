### Objective

Use **Jinja2 templates** in Ansible to dynamically generate configuration files based on host-specific variables.

---

## Concept Overview

- Templates in Ansible use the **Jinja2** syntax (*.j2*).
- They allow inserting variables, loops, and conditions inside files.
- Great for creating configuration files that differ between hosts.

---

---

## Step-by-Step Implementation

### Add the task — copy the Jinja2 template

```bash
thor@jumphost ~/ansible$ vi /home/thor/ansible/roles/httpd/tasks/main.yml
```

**main.yml**

```yaml
---
# tasks file for role/test

- name: install the latest version of HTTPD
  yum:
    name: httpd
    state: latest

- name: Start service httpd
  service:
    name: httpd
    state: started

---
- name: Copy index.html template to web directory
  template:
    src: index.html.j2
    dest: /var/www/html/index.html
    owner: "{{ ansible_user }}"
    group: "{{ ansible_user }}"
    mode: '0755'
```

---

### Write the Playbook

```bash
thor@jumphost ~/ansible$ vi playbook.yaml
```

**playbook.yaml**

```yaml
---
- name: Run httpd role on App Server 1
  hosts: stapp01
  become: true
  roles:
    - role/httpd
```

---

### 3️⃣ Create the Template File

```bash
thor@jumphost ~/ansible$ vi /home/thor/ansible/roles/httpd/templates/index.html.j2
```

**index.html.j2**

```
This file was created using Ansible on {{ inventory_hostname }}
```

---

### 4️⃣ Run the Ansible Playbook

```bash
ansible-playbook -i inventory playbook.yaml
```

---

## 🔍 Verification

**On each app server**

```bash
cat /var/www/html/index.html
```

**Expected Output Example**

```
This file was created using Ansible on stapp01
```

---

## Key Notes

| Module | Purpose |
| --- | --- |
| `template` | Copies a Jinja2 template to a remote host |
| `{{ inventory_hostname }}` | Inserts the current host’s name dynamically |

---

## Reference

🔗 [Ansible Template Module Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html)