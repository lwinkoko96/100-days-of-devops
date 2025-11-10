# Ansible Inventory Basics

### 🔗 Reference

[Ansible Documentation — Inventory Basics](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#inventory-basics-formats-hosts-and-groups)

---

## Types of Inventory Formats

1. **INI Format**
2. **YAML Format**

---

## Create an Inventory File on Jump Host

```bash
# Create and navigate to playbook directory
mkdir -p /home/thor/playbook
cd /home/thor/playbook

# Create inventory file
touch inventory
vi inventory

# List files to confirm
ls
```

---

## Verify Inventory File

Use the ping module to test connectivity for all hosts:

```bash
ansible all -m ping -i inventory
```

---

## Check Existing Playbook

```bash
cat playbook.yml
```

---

## Run Playbook Using Inventory File

```bash
ansible-playbook -i inventory playbook.yml
```