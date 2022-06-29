resource "kubernetes_pod_v1" "jenkinspod" {
  metadata {
    name      = "jenkinspod"
    namespace = kubernetes_namespace.tools.id
    labels = {
      app = "jenkins"
    }
  }

  spec {
    container {
      image = "jenkins/jenkins:lts"
      name  = "jenkinspod"

      #   env {
      #     name  = "environment"
      #     value = "test"
      #   }

      port {
        container_port = 8080
      }

      #   liveness_probe {
      #         http_get {
      #           path = "/"
      #           port = 8080


      #         }
    }

  }
}
############
#*********************** NODE_PORT to Access jenkins From Local Browser  **************
###############
resource "kubernetes_service" "jenkinssvc" {
  metadata {
    name      = "jenkinssvc"
    namespace = kubernetes_namespace.tools.id
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.jenkinspod.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port      = 8080
      node_port = 30085
    }
    type = "NodePort"
  }
}