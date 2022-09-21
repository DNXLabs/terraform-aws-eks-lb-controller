resource "kubectl_manifest" "cluster_role" {
  for_each = { for role in try(var.roles, []) : role.name => role }
  yaml_body = templatefile("${path.module}/role.tpl.yaml", {
    name          = "${each.value.name}"
    namespace     = "${each.value.namespace}"
    resourcenames = "${each.value.secrets}"
  })
}

resource "kubectl_manifest" "cluster_role_binding" {
  for_each = { for role in try(var.roles, []) : role.name => role }
  yaml_body = templatefile("${path.module}/role_binding.tpl.yaml", {
    name          = "${each.value.name}"
    namespace     = "${each.value.namespace}"
    resourcenames = "${each.value.secrets}"
  })
  depends_on = [
    kubectl_manifest.cluster_role
  ]
}
