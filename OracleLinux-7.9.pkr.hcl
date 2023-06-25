######################################################################################
# Variáveis                                https://virtualizandoajublog.wordpress.com/
######################################################################################
/// Boot Configuration

// Floppy configuration

// Connection Configuration

variable "vcenter_server" {
  type        = string
  description = "Servidor vCenter 6.7"
}

variable "vcenter_username" {
  type        = string
  description = "Usuário para se autenticar no vCenter."
}

variable "vcenter_password" {
  type        = string
  description = "Senha de autenticação no vCenter."
}

#Se o certificado root do servidor vCenter estiver instalado, pode descartar está variável.
variable "vcenter_insecure_connection" {
  type        = bool
  description = "Não valida o certificado TLS do vCenter Server. O padrão é falso."
  default     = "false"
}

variable "vcenter_datacenter" {
  type        = string
  description = "Obrigatório se houver mais de um datacenter no vCenter."
}

// Hardware Configuration

variable "vm_CPUs" {
  type        = number
  description = "Número de núcleos de CPU."
}

variable "vm_cpu_cores" {
  type        = number
  description = "Número de núcleos de CPU por soquete"
}

variable "vm_cpu_hot_plug" {
  type        = bool
  description = "Configuração de hot plug da CPU para máquina virtual. Padrões para falso"
  default     = "false"
}

variable "vm_ram" {
  type        = number
  description = "Quantidade de RAM em MB."

}

variable "vm_RAM_hot_plug" {
  type        = bool
  description = "Configuração de hot plug de RAM para máquina virtual. O padrão é falso."
  default     = "false"
}

variable "vm_firmware" {
  type        = string
  description = "Defina o Firmware para a máquina virtual. Valores suportados: bios, efi ou efi-secure. Padrões para bios."
  default     = "bios"
}

// Location Configuration

variable "vm_guest_name" {
  type        = string
  description = "O nome da VM que será criada."
}

variable "vcenter_folder" {
  type        = string
  description = "A pasta VM na qual o modelo VM será criado."
}

variable "vcenter_cluster" {
  type        = string
  description = "Obrigatório se houver mais de um cluster no vCenter."
}

variable "vcenter_host" {
  type        = string
  description = "O host ESXi em que a VM de destino é criada."
}

variable "vcenter_datastore" {
  type        = string
  description = "Obrigatório para clusters ou se o host de destino tiver vários armazenamentos de dados."
}

// Run Configuration

#variable "vm_boot_order" {
#  type        = string
#  description = "Prioridade dos dispositivos de inicialização. Padrões para disco, cdrom"
#}

// CDRom Configuration

variable "vm_remove_cdrom" {
  type        = bool
  description = "Remova os dispositivos de CD-ROM do modelo. O padrão é falso."
  default     = "false"
}

#variable "vm_iso_paths" {}

// Create Configuration

variable "vm_vm_version" {
  type        = number
  description = "Defina a versão de hardware da VM. O padrão é a versão de hardware de VM mais recente compatível com a versão do vCenter Server"
}

variable "vm_guest_os_type" {
  type        = string
  description = "Defina o tipo de SO da VM. Padrões para otherGuest."
}

variable "vcenter_network" {
  type        = string
  description = "O segmento de rede ou nome do grupo de portas ao qual o adaptador de rede virtual primário será conectado."
}

variable "vm_network_card" {
  type        = string
  description = "O tipo de placa de rede virtual."
}

variable "vm_notes" {
  type        = string
  description = "Anotações."
}

#variable "vm_disk_controller_type" {
#  type        = string
#  description = "Defina o tipo de controlador de disco da VM. Exemplo lsilogic, lsilogic-sas, pvscsi, nvme ou scsi."
#  default     = ""
#}

// Extra Configuration Parameters

variable "vm_tools_upgrade_policy" {
  type        = bool
  description = "Se definido como true, o vSphere verificará e atualizará automaticamente o VMware Tools após um ciclo de energia do sistema. Se não estiver definido, o padrão é a atualização manual."
}

// Optional SSH fields

variable "linux_ssh_username" {
  type        = string
  description = "O nome de usuário com o qual se conectar ao SSH. Necessário se estiver usando SSH."
  sensitive   = true
}

variable "linux_ssh_password" {
  type        = string
  description = "Uma senha de texto simples a ser usada para autenticar com SSH."
  sensitive   = true
}

# HTTP Endpoint

variable "http_directory" {
  type        = string
  description = "Directory of config files(user-data, meta-data)."
  default     = ""
}

###########################################################################################
# Source - Máquina Virtual                      https://virtualizandoajublog.wordpress.com/
###########################################################################################

source "vsphere-iso" "example" {

  //
  data_source_command = var.common_data_source == "http" ? "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg" : "inst.ks=cdrom:/ks.cfg"

  // Boot Configuration
  boot_command = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    "text ${local.data_source_command}",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait = "2s"

  // HTTP Settings
  http_directory = var.http_directory
  http_port_max  = "10089"
  http_port_min  = "10082"

  #shutdown_command      = "echo 'packer'|sudo -S /sbin/halt -h -p"

  // Floppy configuration
  // floppy_files = ["${path.root}/kickstart.cfg"]

  // Connection Configuration
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  insecure_connection = var.vcenter_insecure_connection
  datacenter          = var.vcenter_datacenter

  // Hardware Configuration
  CPUs      = var.vm_CPUs
  cpu_cores = var.vm_cpu_cores
  #CPU_Reservation      = Personalizado se necessário
  #CPU_limit            = Personalizado se necessário
  CPU_hot_plug = true

  RAM = var.vm_ram
  #RAM_rervation        = Personalizado se necessário
  #RAM_reserve_all      = Personalizado se necessário
  RAM_hot_plug = true

  #video_ram            = https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-789C3913-1053-4850-A0F0-E29C3D32B6DA.html
  #displays             = Padrão é 1
  #vgpu_profile         = https://docs.nvidia.com/grid/latest/grid-vgpu-user-guide/index.html#configure-vmware-vsphere-vm-with-vgpu

  #NestedHV             =
  firmware = var.vm_firmware
  #force_bios_setup     = 
  #vTPM                 =

  // Location Configuration
  vm_name = var.vm_guest_name
  folder  = var.vcenter_folder
  cluster = var.vcenter_cluster
  host    = var.vcenter_host
  #resource_pool        =
  datastore = var.vcenter_datastore
  #set_host_for_datastore_uploads =

  // Run Configuration
  boot_order = "disk,cdrom"

  // Shutdown Configuration
  #shutdown_command     =
  #shutdown_timeout     =
  #disable_shutdown     =

  // Wait Configuration
  #ip_wait_timeout      =
  #ip_settle_timeout    =
  #ip_wait_address      =

  // ISO Configuration
  #iso_checksum         = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  #iso_urls             = [ "OracleLinux-R7-U9-Server-x86_64-dvd.iso", "https://yum.oracle.com/oracle-linux-isos.html/OracleLinux-R7-U9-Server-x86_64-dvd.iso"]
  #iso_target_path      =
  #iso_target_extension =

  // CDRom Configuration
  #cdrom_type           =
  iso_paths    = ["[Datastore_Packer] ISOS/OracleLinux-R7-U9-Server-x86_64-dvd.iso"]
  remove_cdrom = var.vm_remove_cdrom
  #cd_files             =
  #cd_content           =

  // Create Configuration
  vm_version    = var.vm_vm_version
  guest_os_type = var.vm_guest_os_type
  network_adapters {
    network      = var.vcenter_network
    network_card = var.vm_network_card
  }
  #usb_controller
  notes = var.vm_notes

  disk_controller_type = ["pvscsi", "pvscsi"]
  storage {
    disk_size             = 16384
    disk_controller_index = 0
    disk_thin_provisioned = true
  }

  storage {
    disk_size             = 5120
    disk_controller_index = 1
    disk_thin_provisioned = true
  }

  storage {
    disk_size             = 6144
    disk_controller_index = 1
    disk_thin_provisioned = true
  }

  // Extra Configuration Parameters
  #configuration_parameters
  #tools_sync_time
  tools_upgrade_policy = true

  // Optional SSH fields
  ssh_port     = "22"
  ssh_timeout  = "5m"
  ssh_password = var.linux_ssh_password
  ssh_username = var.linux_ssh_username

  // Convert VM to a template
  convert_to_template = true
}

# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.vsphere-iso.example"]

  provisioner "shell" {
    inline = ["echo Acesse meu blog https://virtualizandoaju.com/"]

  }
}

########################################################################################################
# Ajude o site acessando e comentando no meu post. Obrigado. https://virtualizandoajublog.wordpress.com/
########################################################################################################