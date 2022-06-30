resource "kubernetes_pod_v1" "nodejsapppod" {
  metadata {
    name      = "nodejsapppod"
    namespace = kubernetes_namespace.dev.id
    labels = {
      app = "nodejs"
    }
  }

  spec {
    container {
      image = "menna97/docker-jenkins-image" #new image is needed
      name  = "nodejsapppod"

      #   env {
      #     name  = "environment"
      #     value = "test"
      #   }

      port {
        container_port = 3000
      }
    }

  }
}
############
#*********************** NODE_PORT to Access jenkins From Local Browser  **************
###############
resource "kubernetes_service" "nodejssvc" {
  metadata {
    name      = "nodejssvc"
    namespace = kubernetes_namespace.dev.id
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.nodejsapppod.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port      = 3000
      node_port = 30086
    }
    type = "NodePort"
  }
}