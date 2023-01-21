######################################################################################################################################
# VARIÁVEIS - Connection Configuration,Optional SSH fields, Network Adapter Configuration, Create Configuration,Location Configuration
######################################################################################################################################

#Dá à máquina virtual algum tempo para realmente carregar.
#vm_boot_wait

#Não valide o certificado TLS do vCenter Server. Padrões para falso.
vcenter_insecure_connection = true

#FQDN do servidor vCenter Server
vcenter_server = "vcenter67.virtualizandoaju.com.br"

#O nome do seu Datacenter que tem o host ESXi que irá receber a imagem.
vcenter_datacenter = "Datacenter67"

#Número de núcleos de CPU.
vm_CPUs = "1"

#Número de núcleos de CPU por soquete.
vm_cpu_cores = "1"

#Quantidade de RAM em MB.
vm_ram = "512"

#Firmware para máquina virtual.
vm_firmware = "bios"

#Nome da VM\Template
vm_guest_name = "Template_Packer_DHCP"

#A pasta para armazenar o template quando completado.
vcenter_folder = "Templates_virtualizandoaju"

#O cluster que tem o host ESXi que receberá a conexão do packer.
vcenter_cluster = "Cluster_Virtualizandoaju67"

#FQDN do servidor ESXi/vSphere que o packer será executado.
vcenter_host = "esxi67-ft2.virtualizandoaju.com.br"

#O datastore para armazenar o template quando completado.
vcenter_datastore = "VMWARE_01"

#Prioridade dos dispositivos de inicialização. Padrões para disco, cdrom
#vm_boot_order

#Lista de caminhos de armazenamento de dados ou biblioteca de conteúdo para arquivos ISO que serão montados na VM.
#vm_iso_paths                    =

#Remova os dispositivos de CD-ROM do modelo. O padrão é falso.
vm_remove_cdrom = "true"

#Defina a versão de hardware da VM. O padrão é a versão de hardware de VM mais recente compatível com a versão do vCenter Server.
vm_vm_version = "13"

#Tipo do sistema operacional -> https://developer.vmware.com/apis/358/vsphere/doc/vim.vm.GuestOsDescriptor.GuestOsIdentifier.html.
vm_guest_os_type = "oracleLinuxGuest"

#A rede que a VM Packer utilizará.
vcenter_network = "DPortGroup-VMs"

#VM network card.
vm_network_card = "vmxnet3"

#Anotações na VM após criada.
vm_notes = "Acesse o blog virtualizandoaju.com :)"

#Defina o tipo de controlador de disco da VM. Exemplo lsilogic, lsilogic-sas, pvscsi, nvme ou scsi.
#disk_controller_type.            = 

#Se definido como true, o vSphere verificará e atualizará automaticamente o VMware Tools após um ciclo de energia do sistema. Se não estiver definido, o padrão é a atualização manual.
vm_tools_upgrade_policy = "true"