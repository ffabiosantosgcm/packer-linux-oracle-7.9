##################################################################################
# VARIABLES                            https://virtualizandoajublog.wordpress.com/
##################################################################################

# Credenciais VMware vCenter

#Your vCenter Username - typically this is administrator@vsphere.local
vcenter_username = "administrator@vsphere.local"

#Your vCenter Password
vcenter_password = "!Q@W1q2w"

#The SSH username and password will be used to connect to the finished image.
#The password is hashed using "mkpasswd --method=SHA-512 --rounds=4096" and stored in the http/user-data file

linux_ssh_username = "virtualizandoaju"
linux_ssh_password = "P@ssw0rd"