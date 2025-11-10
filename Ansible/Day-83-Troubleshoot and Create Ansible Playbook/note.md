### Objective

Learn how to troubleshoot Ansible connectivity issues and create a simple Ansible playbook to generate an empty file on remote servers.

---

## Step 1 — Check Connection to Managed Nodes

Use the `ping` module to verify connectivity with all hosts listed in your Ansible inventory.

```bash
ansible all -m ping -i inventory
```

If any host fails, verify the SSH connection or credentials.

---

## Step 2 — Update Inventory File

Modify your inventory file to include the correct list of hosts.

```bash
vi inventory
```

You can confirm that your inventory file is properly formatted using:

```bash
ansible-inventory -i inventory --list
```

---

## Step 3 — Create Ansible Playbook

Create a new playbook to generate an empty text file `/tmp/file.txt` on each target server.

```bash
vi playbook.yml
```

### playbook.yaml:

```yaml
---
- name: Create file on App Server 2
  hosts: all
  become: true
  tasks:
    - name: Create an empty file /tmp/file.txt
      file:
        path: /tmp/file.txt
        state: touch
```

---

## Step 4 — Run the Playbook

Execute the playbook using the inventory file.

```bash
ansible-playbook -i inventory playbook.yml
```

**Expected Output:**

Each host should report `changed=1`, indicating that the file `/tmp/file.txt` was successfully created.

---

## Quick Recap

| Step | Command / Action | Description |
| --- | --- | --- |
| 1 | `ansible all -m ping -i inventory` | Test connectivity |
| 2 | `vi inventory` | Edit inventory file |
| 3 | `vi playbook.yml` | Create playbook |
| 4 | `ansible-playbook -i inventory playbook.yml` | Execute playbook |

---

## Reference

🔗 [Ansible Playbook Documentation](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html)