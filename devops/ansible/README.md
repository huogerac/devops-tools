# Deploy com Ansible

## 1) Deploy Raiz

    - Faz update no ubuntu e instala pacotes básico (python, lib para postgres etc..)
    - Instala NGINX
    - Faz clone do código, instala dependencias Python, migrate, collect static, cria systemD para rodar GUnicorn
    - Configura NGINX para apontar para GUNICORN
    - REQUISITOS:
    - Ter um servidor Ubuntu (Testado no 22.04)
    - Ter uma chave (arquivo .pem) para acessar servidor via ssh

```shell
    # Passo 1 - Django, NGINX (django+static) e Systemd para Rodar Gunicorn
    👉 Atualizar hots/dev com dados do servidor
    ❯ cp group/vars/dev_1_raiz group/vars/dev
    ❯ ansible-playbook playbook_1_raiz.yml -i hosts/dev --tags ubuntu
    ❯ ansible-playbook playbook_1_raiz.yml -i hosts/dev --tags nginx
    ❯ ansible-playbook playbook_1_raiz.yml -i hosts/dev --tags back_django
    ❯ ansible-playbook playbook_1_raiz.yml -i hosts/dev --tags back_django_nginx
    # Passo 2 - Usar um banco de verdade
    ❯ ansible-playbook playbook_1_raiz.yml -i hosts/dev --tags postgres
    👉 Atualiza ENVIRONMENT group/vars/dev (DATABASE_URL)
    ❯ ansible-playbook playbook_1_raiz.yml -i hosts/dev --tags back_django
    # Passo 3 - Configurar SSL
    👉 Ver nginxenable

```
    Links:
    - https://docs.ansible.com/ansible/latest/collections/ansible/builtin/git_module.html
    - https://www.digitalocean.com/community/tutorials/how-to-set-up-django-with-postgres-nginx-and-gunicorn-on-ubuntu
    - https://medium.com/@neeraj779/how-to-set-up-django-nginx-and-gunicorn-on-ubuntu-22-04-52c3c2d375b4
