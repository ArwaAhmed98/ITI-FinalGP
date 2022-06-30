resource "kubernetes_pod_v1" "nexus" {
  metadata {
    name      = "nexusspod"
    namespace = kubernetes_namespace.tools.id
    labels = {
      app = "nexus"
    }
  }

  spec {
    container {
      image = "sonatype/nexus3"
      name  = "nexusspod"

      #   env {
      #     name  = "environment"
      #     value = "test"
      #   }

      port {
        container_port = 8081
      }

    }

  }
}
############
#*********************** NODE_PORT to Access jenkins From Local Browser  **************
###############
resource "kubernetes_service" "nexussvc" {
  metadata {
    name      = "nexussvc"
    namespace = kubernetes_namespace.tools.id
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.nexus.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port      = 8081
      node_port = 30082
    }
    type = "NodePort"
  }
}




resource "kubernetes_service" "nexussvcclusterip" {
  metadata {
    name      = "nexussvcclusterip"
    namespace = kubernetes_namespace.tools.id
  }
  spec {
    selector = {
      app = kubernetes_pod_v1.nexus.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port = 8801
    }
    type = "ClusterIP"
  }
}