# Como utilizar o GH Container Registry (packages)

## 1 - Criar token de acesso pessoal (classic)
- Usuário (canto superior direito) / Settings / Developer Settings
- Personal access tokens / Tokens (classic) (barra lateral esquerda)
- Generate new token (classic)
    - pode dar um nome como 'Acesso ao GH Registry'
    - colocar sem data de expiracao
    - selecionar permissão para: repo, workflow, write:packages, read:packages, delete:packages, project
    - clicar em generate token
- Copiar o texto (token) gerado, vamos precisar dele no próximo passo (é a senha de acesso)

## 2 - Criar secret com o token gerado no passo 1
- Entra no repositório do projeto / settings
- Security / Secrets and Variables / Actions
- New repository secret
- Name: CR_PAT e Secret: token gerado no passo anterior

## 3 - Criar um IP Elástico
- Criar IP elástico, assim este IP sempre será o mesmo (quando trocamos as instâncias)
- Associar a instância atual ao IP elástico criado (fixo)

## 4 - Configurar Route 53
- Criar zona hospedada e colocar o dominio já registrado
- Criar registro *, www e o vazio, todos linkando com o ip elastico criado anteriormente
- Linkar o DNS original do domínio para o DNS gerado pelo route 53

## 5 - SSL

### Opção 1) Usar gerenciador de certificado da AWS
- Nesta opção, tem que ter um Load Balancer ou Cloud Front na frente da instância (que será o nginx interno que irá colocar o https e nada precisa ser feito nas instâncias)
- Certificate manager
- seleciona a regiao correta onde estão os recursos
- solicitar novo certificado
- adicionar dominio, www.dominio e *.dominio

### Opção 2) Cria um NGINX diretamente na instância com o certificado
- Configurar as variáveis com nome do domínio (group_vars) e email
- Rodar o ansible para instalar certificado (nginxenable)
