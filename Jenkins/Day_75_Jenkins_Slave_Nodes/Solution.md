## SSH Key Generation and Public Key Distribution (Jenkins → App Servers)

```jsx
jenkins@jenkins:~$ ssh-keygen -t ed25519 -N "" -f ~jenkins/.ssh/id_ed25519
Generating public/private ed25519 key pair.
Created directory '/var/lib/jenkins/.ssh'.
Your identification has been saved in /var/lib/jenkins/.ssh/id_ed25519
Your public key has been saved in /var/lib/jenkins/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:qJOKj9TjUBL8PJA7XRJCrWky/D22UgJzZvo0MLtx+8g jenkins@jenkins.stratos.xfusioncorp.com
The key's randomart image is:
+--[ED25519 256]--+
|.o..             |
|. o..            |
|.=o. .           |
|oXB+o  .         |
|o=%*. . S        |
| +=*.B           |
| o*oX o          |
|.++=oo           |
|o.oEo.           |
+----[SHA256]-----+

jenkins@jenkins:~$ cat /var/lib/jenkins/.ssh/id_ed25519
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCZ6upKOshi+oTesLpmYLEXR1PVjM0IXwsQUH19NiqXWQAAALAEcUV7BHFF
ewAAAAtzc2gtZWQyNTUxOQAAACCZ6upKOshi+oTesLpmYLEXR1PVjM0IXwsQUH19NiqXWQ
AAAEAjCCFvmC5nE2XavVx6da2SrZGs18AxtAFJIfQz+sOW4Jnq6ko6yGL6hN6wumZgsRdH
U9WMzQhfCxBQfX02KpdZAAAAJ2plbmtpbnNAamVua2lucy5zdHJhdG9zLnhmdXNpb25jb3
JwLmNvbQECAwQFBg==
-----END OPENSSH PRIVATE KEY-----

jenkins@jenkins:~$ ssh-copy-id tony@stapp01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/var/lib/jenkins/.ssh/id_ed25519.pub"
The authenticity of host 'stapp01 (172.16.238.10)' can't be established.
ED25519 key fingerprint is SHA256:7TU+mV4Xfd4+/tqpr11sCmCUqyoHOR8Ib0aCqHV1hkA.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
tony@stapp01's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'tony@stapp01'"
and check to make sure that only the key(s) you wanted were added.

jenkins@jenkins:~$ ssh-copy-id steve@stapp02
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/var/lib/jenkins/.ssh/id_ed25519.pub"
The authenticity of host 'stapp02 (172.16.238.11)' can't be established.
ED25519 key fingerprint is SHA256:riOYgkmZUCVp9RCFehH6ml7m7PJAjuUdPed3AxL05UA.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
steve@stapp02's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'steve@stapp02'"
and check to make sure that only the key(s) you wanted were added.

jenkins@jenkins:~$ ssh-copy-id banner@stapp03
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/var/lib/jenkins/.ssh/id_ed25519.pub"
The authenticity of host 'stapp03 (172.16.238.12)' can't be established.
ED25519 key fingerprint is SHA256:bh52zy0o+M39wrGyj3oYv2EucIY1KOu3pblldryrpCo.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
banner@stapp03's password:  

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'banner@stapp03'"
and check to make sure that only the key(s) you wanted were added.

jenkins@jenkins:~$ ssh tony@stapp01
[tony@stapp01 ~]$ 

jenkins@jenkins:~$ ssh steve@stapp02
[steve@stapp02 ~]$

jenkins@jenkins:~$ ssh banner@stapp03
[banner@stapp03 ~]$
```

## Configure Jenkins Agent Nodes (Setup Java, SSH Keys, and Global Credentials)

### App Server 1

```jsx
sudo mkdir -p /home/tony/jenkins
sudo chown -R tony:tony /home/tony/jenkins
sudo yum install -y java-17-openjdk

```

### App Server 2

```jsx
sudo mkdir -p /home/steve/jenkins
sudo chown -R steve:steve /home/steve/jenkins
sudo yum install -y java-17-openjdk
```

### App Server 3

```jsx
sudo mkdir -p /home/banner/jenkins
sudo chown -R banner:banner /home/banner/jenkins
sudo yum install -y java-17-openjdk
```

### Add Global Credentials
![Add Global Credentials](https://raw.githubusercontent.com/lwinkoko96/100-days-of-devops/main/Jenkins/Day_75_Jenkins_Slave_Node/images/image-1.png)

### Install SSH Build Agents Plugin
![Install SSH Build Agents Plugin](https://raw.githubusercontent.com/lwinkoko96/100-days-of-devops/main/Jenkins/Day_75_Jenkins_Slave_Node/images/image-2.png)

## Verify Jenkins Agent Node Connectivity via Test Job

1. Create project
    1. Choose Label Expression (stapp01 or stapp02 or stapp03)
    2. Add Build Steps
        
        ```jsx
        echo "Running on $(hostname)"
        whoami
        ```
        
2. Build Now
3. Console Output

### Verify    
![Verify](https://raw.githubusercontent.com/lwinkoko96/100-days-of-devops/main/Jenkins/Day_75_Jenkins_Slave_Node/images/image-3.png)
