# data "cloudinit_config" "example" {
#   gzip          = false
#   base64_encode = false

#   part {
#     content_type = "text/cloud-config"
#     content = yamlencode({
#       write_files = [
#         {
#           encoding = "b64"
#           content = base64encode(templatefile("${path.module}/scripts/teleport_token.tpl",
#             {
#               teleport_token = var.teleport_token
#           }))
#           path = "/home/opc/.teleport_token"
#           #owner       = "opc:opc"
#           permissions = "0600"
#         }
#       ]
#     })
#   }
#   part {
#     content_type = "text/x-shellscript"
#     filename     = "bastion.sh"
#     content = templatefile("${path.module}/scripts/bastion.sh",{})
#   }
# }

data "cloudinit_config" "example" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = "bastion.sh"
    content = templatefile(
      var.user_data,
      {
        teleport_token = var.teleport_token
        teleport_url   = var.teleport_url
      }
    )
  }
}