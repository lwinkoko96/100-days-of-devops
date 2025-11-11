### Objective

Verify Ansible connectivity, create an inventory file, and copy files from the control node to managed nodes using the **Ansible copy module**.

---

## 1. Create the inventory file on the jump host

```bash
mkdir -p ~/ansible
cd ~/ansible
vi inventory

```

Example `inventory` (INI format):

```
[all]
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner
```

---

## 2. Verify connectivity with `ping` module

```bash
ansible all -m ping -i inventory
```

---

## 3. Create the playbook

```bash
vi playbook.yml
```

Example `playbook.yml`:

```yaml
---
- name: Copy file to remote host and set permissions
  hosts: all
  become: true # Use 'become: yes' or 'become: true' to elevate privileges if needed

  tasks:
    - name: Copy configuration file
      ansible.builtin.copy:
        src: /usr/src/security/index.html
        dest: /opt/security
```

> Adjust src, dest, owner, group, and mode as required.
> 

---

## 4. Run the playbook

```bash
ansible-playbook -i inventory playbook.yml
```

---

## Reference

- Ansible inventory basics: https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html
- Ansible copy module: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/copy_module.html