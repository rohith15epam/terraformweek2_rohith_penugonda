variable "network-id" {
  type = string
}
variable "subnet_id" {
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