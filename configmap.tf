resource "kubernetes_config_map_v1" "example" {
  metadata {
    name = "dbcredentials"
  }

  data = {
    # api_host             = "myhost:443"
    db_host              = "mysqlsvc:3306"
    "my_config_file.yml" = "${file("${path.module}/configmap.yml")}"
  }

}