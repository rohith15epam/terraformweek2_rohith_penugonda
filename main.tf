terraform {
  required_providers {
    google = {
      source  ="hashicorp/google"
      version = "3.20.0"
    }
  }

}
data "terraform_remote_state" "terraformstate" {
 backend   = var.backendtype
  config = {
    bucket = var.bucketnamestate
    prefix = var.stateprefix
    credentials = file(var.jsonfile)
  }
}
provider "google" {
  project     = var.projectidgoogle
  credentials = file(var.jsonfile)
  region      = var.projectregiongoogle
  zone        = var.projectzonegoogle
}

module "network_resources" {
  source = "./network_resources"
  vpc-name = var.vpc-name
  vpc-auto = var.vpc-auto
  subnet-name = var.subnet-name
  subnet-ip = var.subnet-ip
  subnet-region = var.subnet-region
  router-name = var.router-name
  router-asn = var.router-asn
  nat-name =var.nat-name
  nat-ip = var.nat-ip
  natsource = var.natsource
}
module "storage_resources" {
  source     = "./storage_resources"
  network-id = module.network_resources.vpc-id
  privateipname = var.privateipname
  privateippurpose = var.privateippurpose
  privateipaddress = var.privateipaddress
  privateprefix = var.privateprefix
  connectionservice = var.connectionservice
  sqlname = var.sqlname
  sqlregion = var.sqlregion
  sqlversion = var.sqlversion
  sqltier = var.sqltier
  sqlip = var.sqlip
  sqluser = var.sqluser
  sqlpass = var.sqlpass
  sqldb = var.sqldb
  bucketname = var.bucketname
  bucketloc=var.bucketloc
  bucketforce = var.bucketforce
  bucketrole = var.bucketrole
  bucketentity = var.bucketentity
}
module "instance_resources" {
  source     = "./instance_resources"
  network-id = module.network_resources.vpc-id
  subnet_id  = module.network_resources.subnetid
  serviceid = var.serviceid
  servicename = var.servicename
  iamrole = var.iamrole
  templatename = var.templatename
  tagname = var.tagname
  templatetype = var.templatetype
  scopename = var.scopename
  disktype = var.disktype
  autodelete = var.autodelete
  boot = var.boot
  healthcheckname = var.healthcheckname
  tagforhealthcheck = var.tagforhealthcheck
  requestpath = var.requestpath
  groupname = var.groupname
  instancebasename = var.instancebasename
  groupzone = var.groupzone
  groupnamedportname = var.groupnamedportname
  groupnamedportport= var.groupnamedportport
  groupinitaldelay = var.groupinitaldelay
  autoscalename = var.autoscalename
  autoscalezone = var.autoscalezone
  maxreplica=var.maxreplica
  minreplica=var.minreplica
  cooldownperiod= var.cooldownperiod
  rulerange= var.rulerange
  rulename = var.rulename
  ruleprotocol = var.ruleprotocol
  ruleport = var.ruleport
  ruletarget = var.ruletarget
  rulerange1 = var.rulerange1
  rulename1 = var.rulename1
  ruleprotocol1= var.ruleprotocol1
  ruleport1 =var.ruleport1
  firewallrulename =var.firewallrulename
  firewallport =var.firewallport
  firewallschema =var.firewallschema
  proxynamefirewall=var.proxynamefirewall
  loadbalancername = var.loadbalancername
  backendname=var.backendname
  backendprotocol = var.backendprotocol
  backendtimeout= var.backendtimeout
  backendschema = var.backendschema
  backendportname = var.backendportname
}
