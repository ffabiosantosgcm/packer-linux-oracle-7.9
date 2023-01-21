## packer-linux-oracle-7.9 Update

Criando um Template VMware Oracle Linux com Packer Usando HCL2

## Running packer build with hcl template

packer build -debug -on-error=ask -var-file .\vsphere_segredo.pkrvars.hcl -var-file .\vsphere.pkrvars.hcl .\OracleLinux-7.9.pkr.hcl

