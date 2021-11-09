# CulturAZ
Repositório do CulturAZ

## Estrutura de arquivos
- **compose** - arquivos de configuração e preparação dos ambientes de desenvolvimento e produção, utilizados pelo docker-compose
    - **common** - arquivos comuns dos ambientes de desenvolvimento e produção
    - **local** - arquivos exclusivamente para o ambiente de desenvolvimento
    - **production** - arquivos exclusivamente para o ambiente de produção
- **dev-scripts** - scripts auxiliares para o desenvolvimento
    - **start-dev.sh** - script que inicializa o ambiente de desenvolvimento
    - **bash.sh** - entra no container da aplicação
    - **shell.sh** - entra no shell do mapas culturais
    - **psql.sh** - entra no banco de dados da aplicação
    - **docker-compose.local.yml** - arquivo de definição do docker-compose utilizado pelos scripts acima
- **plugins** - pasta com os plugins desenvolvidos exclusivamente para o projeto
    - **SamplePlugin** - esqueleto de plugin para demostração e para servir de base para o desenvolvimento de outros plugins
- **themes** - pasta com os temas desenvolvidos exclusivaente para o projeto
    - **SampleTheme** - esqueleto de tema filho de Subsite para demostração e para servir de base para o desenvolvimento de outros temas

## Ambiente de desenvolvimento

### Iniciando o ambiente de desenvolvimento
Para subir o ambiente de desenvolvimento basta entrar na pasta `dev-scripts` e rodar o script `start-dev.sh`.

```
meu-mapas/dev-scripts/$ sudo ./start-dev.sh
```

acesse no seu navegador http://localhost/

### psysh
Este ambiente roda com o built-in web server do PHP, o que possibilita que seja utilizado o [PsySH](https://psysh.org/]), um console interativo para debug e desenvolvimento. 

no lugar desejado, adicione a linha `eval(\psy\sh());` e você obterá um console. `Ctrl + D` para continuar a execução do código.

### Parando o ambiente de desenvolvimento
Para parar o ambiente de desenvolvimento usar as teclas `Ctrl + C`

## Ambiente de produção
### Scripts
- **start.sh** - inicializa o ambiente de produção utilizando o docker-compose.prod.yml, que garantirá que o serviço se mantenha em pé enquanto não for deliberadamente desligado utilizando o script `stop.sh`;
- **stop.sh** - desliga o embiente de produção;
- **restart.sh** - reinicia o ambiente de produção. É o mesmo que utilizar o os comandos `stop.sh ` e `start.sh`. É bom observar que o cache da aplicação será apagado;
- **renew-letsencrypt-certficate.sh** - reinicia o container certbot, forçando a tentativa de renovação do certificado;
- **clear-cache.sh** - reinicia o container redis, apagando todo o cache da aplicação;
- **update.sh** - atualiza o ambiente fazendo build da nova imagem docker. Ver a seção [Atualizando o Mapas Culturais](#atualizando-a-versão-do-mapas-culturais) 
- **logs.sh** - exibe o output do docker-compose;
- **bash.sh** - entra no console bash do container da aplicação (mapasculturais);
- **psql.sh** - entra no console do PostgreSQL (psql);
- **dump.sh** - faz um dump do banco de dados;
asdasd

### Atualizando a versão do Mapas Culturais

#### Atualizar dentro da mesma minor
Para atualizar a Versão do Mapas Culturais dentro da mesma *minor version*, por exemplo atualizar da versão `v5.1.26` para a versão `v5.1.27`, basta executar o script `update.sh`.

#### Atualizar para outra *minor* ou *major*
Para atualizar de uma *minor* para outra *minor*, por exemplo da versão `v5.1` para versão `v5.2`, é preciso editar os arquivos abaixo, trocando a referência à versão atual para a nova versão:
- `compose/production/Dockerfile` - na primeira linha do arquivo, onde está `FROM mapasculturais/mapasculturais:v5.1` trocar por `FROM mapasculturais/mapasculturais:v5.2`
- `compose/local/Dockerfile` - na primeira linha do arquivo, onde está `FROM mapasculturais/mapasculturais:v5.1-cli` trocar por `FROM mapasculturais/mapasculturais:v5.2-cli`
- `update.sh` - onde está `docker pull mapasculturais/mapasculturais:v5.1` trocar por `docker pull mapasculturais/mapasculturais:v5.2`.

Após a edição dos aquivos, deve-se commitar as modificações, dar push no repositório e executar o script `update.sh` no servidor.

### Fazendo Backups
Todos os arquivos que precisam ser *backupeados* estão na pasta `docker-data`, a forma mais fácil é fazer backup da pasta inteira, porém dentro desta pasta estão os arquivos do banco de dados e neste caso é preferivel fazer o backup do arquivo .sql gerado pelo script `dump.sh`. Assim sendo, o recomeda-se fazer pelo menos diariamente um backup incremental (pode ser com rsync para outro servidor) das pastas `assets`, `certbot`, `private-files`, `public-files` e `saas-files`, além de um dump do banco de dados. 

### Renovando o certificado letsencrypt
Os certificados do Let's Encrypt têm validade de três meses e por esta razão precisam ser renovados periodicamente. Para renovar o certificado basta executar o script `renew-letsencrypt-certficate.sh`. Uma boa ideia é configurar um cron que execute este script periodicamente.