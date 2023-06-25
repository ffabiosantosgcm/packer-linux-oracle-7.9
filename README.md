<img src="https://github.com/ffabiosantosgcm/packer-linux-oracle-7.9/blob/master/packer-icon.svg" style="width:150px;height:150px;">

## Packer

## Versão vSphere testada

vCenter/vSphere 6.x

## Available Builds

* Oracle Linux 7.9

## Files

- `variables.pkr.hcl` - Arquivo de declaração de variável
- `'OS-Name'.pkr.hcl` - Construir arquivo em cada configuração específica do sistema operacional
- `build.pkr.hcl` - Arquivo de compilação combinado em nova configuração
- `'OS-Name'.pkrvar.hcl` - Arquivo de variáveis ​​definidas pelo usuário
- `'OS-Name'.segredo.pkrvars.hcl` - Arquivo que contém usuários e senhas

## Running packer build with hcl template

packer build -var-file .\vsphere_segredo.pkrvars.hcl -var-file .\vsphere.pkrvars.hcl .\OracleLinux-7.9.pkr.hcl

## Change Log

### 24/06/2023

* Adicionado arquivos de váriável para esconder informações de login e senha.