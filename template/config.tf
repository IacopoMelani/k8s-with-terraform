
resource "kubernetes_config_map_v1" "app-config" {

  depends_on = [
    kubernetes_namespace_v1.namespace
  ]

  metadata {
    name      = "app-config"
    namespace = var.namespace
    labels = {
      "name" = "app-config"
      "kind" = "config-map"
    }
  }

  data = {
    "index.html" = <<EOF
<!DOCTYPE html>
<html>
  <head>
    <title>Welcome to nginx of ${var.app_name}!</title>
    <style>
    html { color-scheme: light dark; }
    body { width: 35em; margin: 0 auto;
    font-family: Tahoma, Verdana, Arial, sans-serif; }
    </style>
  </head>
  <body>
    <h1>Welcome to nginx of ${var.app_name}!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>

    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>

    <p><em>Thank you for using nginx.</em></p>
  </body>
</html>
EOF
  }
}
