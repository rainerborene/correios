# Correios

Thorfile de importação do banco de dados de endereçamento fornecido pelo [Correios](http://shopping.correios.com.br/wbm/store/script/wbm2400901p01.aspx?cd_company=ErZW8Dm9i54=&cd_product=CNVMIV7NKig=&cd_department=SsNp3FlaUpM=).

O e-DNE Básico é um banco de dados com arquivos em formato texto (.txt) que contém mais de 900 mil CEPs de todo o Brasil, com elementos de endereçamento até nível de seção de logradouro e Códigos de Endereçamento Postal (CEP).

### Importação

1. Compre a base de dados e-DNE Básico ou equivalente na loja virtual dos Correios.

2. Clone esse repositório em qualquer diretório da sua máquina.

3. Baixe as dependências usando o `bundler`.

4. Descompacte o arquivo adquirido pelo Correios `eDNE_Basico_*.zip` dentro do diretório clonado.

5. Renomeie a pasta `eDNE_Basico_*` para `eDNE`.

6. Abra o terminal dentro do diretório clonado e execute os comandos:

       $ thor correios:load
       $ thor correios:prepare
       $ thor correios:seed

7. Dependendo da configuração da sua máquina a importação pode demorar. Então, aguarde alguns minutos.

8. Mande tudo para o Redis. A conexão é estabelecida no endereço da variável de ambiente `REDIS_URL` (o default é localhost).

       $ thor correios:cache

### Licença

WTFPL – Public License.
