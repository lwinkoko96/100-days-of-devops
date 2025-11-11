### Objective

Verify SSH connectivity and authentication between the **control node (jump host)** and **managed nodes (app servers)** using the **Ansible ping module**.

---

## 1. Create Inventory File

**File:** `inventory`

```
stapp01 ansible_user=tony ansible_host=172.16.238.10
stapp02 ansible_user=steve ansible_host=172.16.238.11
stapp03 ansible_user=banner ansible_host=172.16.238.12
```

---

## 2. Generate and Distribute SSH Keys

Generate SSH key pair on the jump host:

```bash
ssh-keygen -t rsa -b 2048
```

Then copy the public key to each app server:

```bash
ssh-copy-id tony@stapp01
ssh-copy-id steve@stapp02
ssh-copy-id banner@stapp03
```

---

## 3. Verify Connection Using Ping Module

Run the **ping module** to confirm Ansible connectivity:

```bash
ansible all -i inventory -m ping
```

If successful, each node should respond with `"ping": "pong"` indicating proper SSH and Python setup.

---

## Key Notes

| Step | Description |
| --- | --- |
| `inventory` | Defines managed nodes and their connection info |
| `ssh-keygen` | Generates key pair for passwordless SSH |
| `ssh-copy-id` | Copies public key to each remote host |
| `ansible -m ping` | Verifies Ansible connectivity and SSH setup |

---

## Reference

- [Ansible Ping Module](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/ping_module.html)
- [Ansible Inventory Basics](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)