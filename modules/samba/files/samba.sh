# This is the main Samba configuration file to make it easier 
# to access all Drupal sites folder 
# by the Windows desktop host or any other host
#
# Local modifications will be overwritten by Chef.
#

[global]
   workgroup = WORKGROUP
   server string = %h server (Samba, Ubuntu)
   dns proxy = no

   log file = /var/log/samba/log.%m
   max log size = 1000
   syslog = 0
   panic action = /usr/share/samba/panic-action %d

   encrypt passwords = true
   passdb backend = tdbsam
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes

   map to guest = bad user
   usershare allow guests = yes

[printers]
   comment = All Printers
   browseable = no
   path = /var/spool/samba
   printable = yes
   guest ok = no
   read only = yes
   create mask = 0700

[print$]
   comment = Printer Drivers
   path = /var/lib/samba/printers
   browseable = yes
   read only = yes
   guest ok = no

[drupalsites]
   comment = Drupal sites Vagrant share
   writable = yes
   path = /opt/apache
   public = yes
   guest only = yes
   guest ok = no
   browseable = yes
   read only = no
   create mask = 0777
   directory mask = 0777
   force create mode = 777
   force directory mode = 777
   force security mode = 777
   force directory security mode = 777
   force user = vagrant
   force group = vagrant
   