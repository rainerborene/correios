# Correios

Thorfile de importação do banco de dados de endereçamento fornecido pelo [Correios](http://shopping.correios.com.br/wbm/store/script/wbm2400901p01.aspx?cd_company=ErZW8Dm9i54=&cd_product=CNVMIV7NKig=&cd_department=SsNp3FlaUpM=).

O e-DNE Básico é um banco de dados com arquivos em formato texto (.txt) que contém mais de 900 mil CEPs de todo o Brasil, com elementos de endereçamento até nível de seção de logradouro e Códigos de Endereçamento Postal (CEP).

### Importação

1. Compre a base de dados e-DNE Básico ou equivalente na loja virtual do Correios.

2. Clone esse repositório em qualquer diretório da sua máquina.

3. Rode o `bundler` para baixar as dependências.

4. Descompacte o arquivo adquirido pelo Correios `eDNE_Basico_VERSAO.zip` dentro do diretório clonado.

5. Renomeie a pasta `eDNE_Basico_VERSAO` para `eDNE`.

6. Abra o terminal dentro do diretório clonado e execute os comandos:

        $ thor correios:load
        $ thor correios:prepare
        $ thor correios:seed

7. A importação pode demorar dependendo da configuração da sua máquina. Espere alguns minutos.

8. Configure a variável de ambiente `REDIS_URL` e importe a base de CEPs no Redis.

        $ thor correios:cache

### Licença

WTFPL – Public License.
