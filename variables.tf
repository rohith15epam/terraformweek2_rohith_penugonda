variable "backendtype" {
  type = string
}
variable "bucketnamestate" {
  type = string
}
variable "stateprefix" {
  type = string
}
variable "jsonfile" {
  type = string
}
variable "projectidgoogle" {
  type = string
}
variable "projectregiongoogle" {
  type = string
}
variable "projectzonegoogle" {
  type = string
}
variable "vpc-name" {
  type = string
}
variable "vpc-auto" {
  type= bool
}
variable "subnet-name" {
  type = string
}
variable "subnet-ip" {
  type = string
}
variable "subnet-region" {
    type = string
}
variable "router-name" {
   type = string
}
variable "router-asn" {
  type = number
}
variable "nat-name" {
  type = string
}
variable "nat-ip" {
  type = string
}
variable "natsource" {
  type = string
}
variable "privateipname" {
  type = string
}
variable "privateippurpose" {
  type = string
}
variable "privateipaddress" {
  type = string
}
variable "privateprefix" {
  type = number
}
variable "connectionservice" {
  type = string
}
variable "sqlname" {
  type = string
}
variable "sqlregion" {
    type = string
}
variable "sqlversion" {
  type = string
}
variable "sqltier" {
  type = string
}
variable "sqlip" {
  type = bool
}
variable "sqluser" {
  type = string
}
variable "sqlpass" {
  type = string
}
variable "sqldb" {
    type = string  
}
variable "bucketname" {
  type = string  
}
variable "bucketloc" {
    type =string
}
variable "bucketforce" {
   type = bool
}
variable "bucketrole" {
  type = string
}
variable "bucketentity" {
  type = string
}
variable "serviceid" {
  type = string
}
variable "servicename" {
  type = string
}
variable "iamrole" {
    type = string  
}
variable "templatename" {
  type = string
}
variable "tagname" {
  type = string
}
variable "templatetype" {
  type = string
}
variable "scopename" {
    type = list(string)
}
variable "disktype" {
    type = string
}
variable "autodelete" {
  type = bool
}
variable "boot" {
  type =bool
}
variable "healthcheckname" {
  type = string
}
variable "tagforhealthcheck" {
  type = string
}
variable "requestpath" {
  type = string
}
variable "groupname" {
  type = string
}
variable "instancebasename" {
  type = string
}
variable "groupzone" {
  type = string
}
variable "groupnamedportname" {
  type = string
}
variable "groupnamedportport" {
  type = number
}
variable "groupinitaldelay" {
  type = number
}
variable "autoscalename" {
  type = string
}
variable "autoscalezone" {
  type = string
}
variable "maxreplica" {
  type = number
}
variable "minreplica" {
  type = number
}
variable "cooldownperiod" {
  type = number
}
variable "rulerange" {
  type    = list(string)
}
variable "rulename" {
  type = string
}
variable "ruleprotocol" {
  type = string
}
variable "ruleport" {
  type = list(string)
}
variable "ruletarget" {
  type = list(string)
}
variable "rulerange1" {
  type = list(string)
}
variable "rulename1" {
  type = string
}
variable "ruleprotocol1" {
  type = string
}
variable "ruleport1" {
   type = list(string)
}
variable "firewallrulename" {
  type = string
}
variable "firewallport" {
  type =string
}
variable "firewallschema" {
  type = string
}
variable "proxynamefirewall" {
  type = string
}
variable "loadbalancername" {
  type = string
}
variable "backendname" {
  type = string
}
variable "backendprotocol" {
  type = string
}
variable "backendtimeout" {
  type = number
}
variable "backendschema" {
  type = string
}
variable "backendportname" {
  type = string
}