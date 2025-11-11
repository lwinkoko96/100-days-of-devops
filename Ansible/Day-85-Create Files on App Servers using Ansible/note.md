- Generated
    
    ###  Objective
    
    Use the **Ansible file module** to create configuration files and manage file permissions on multiple app servers.
    
    ---
    
    ## 1. Create Inventory File
    
    ```
    [app-server1]
    stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password='Ir0nM@n' ansible_connection=ssh
    
    [app-server2]
    stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password='Am3ric@' ansible_connection=ssh
    
    [app-server3]
    stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password='BigGr33n' ansible_connection=ssh
    
    ```
    
    ---
    
    ## 2. Verify Inventory
    
    ```bash
    ansible -i inventory all -m ping
    
    ```
    
    ---
    
    ## 3. Create Playbook
    
    **File:** `playbook.yml`
    
    ```yaml
    ---
    - name: Manage file creation and permissions
      hosts: app-server1
      become: yes
      tasks:
        - name: Create a configuration file
          ansible.builtin.file:
            path: /tmp/code.txt
            state: touch
            owner: tony
            group: tony
            mode: '0655'
    
    - name: Manage file creation and permissions
      hosts: app-server2
      become: yes
      tasks:
        - name: Create a configuration file
          ansible.builtin.file:
            path: /tmp/code.txt
            state: touch
            owner: steve
            group: steve
            mode: '0655'
    
    - name: Manage file creation and permissions
      hosts: app-server3
      become: yes
      tasks:
        - name: Create a configuration file
          ansible.builtin.file:
            path: /tmp/code.txt
            state: touch
            owner: banner
            group: banner
            mode: '0655'
    
    ```
    
    ---
    
    ## 4. Run the Playbook
    
    ```bash
    ansible-playbook -i inventory playbook.yml
    
    ```
    
    ---
    
    ##  Key Concepts
    
    | Module | Description |
    | --- | --- |
    | `ansible.builtin.file` | Used to create, delete, or modify file attributes |
    | `state: touch` | Creates an empty file if it doesn’t exist |
    | `owner`, `group`, `mode` | Defines ownership and permission settings |
    
    ---
    
    ##  Reference
    
    - [Ansible File Module Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/file_module.html)