resource "kubernetes_service" "simpletimeservice" {
  metadata {
    name      = "simpletimeservice-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = kubernetes_deployment.simpletimeservice.metadata[0].labels.app
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 5000
    }
  }
}

resource "kubernetes_deployment" "simpletimeservice" {
  metadata {
    name      = "simpletimeservice"
    namespace = "default"
    labels = {
      app = "simpletimeservice"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "simpletimeservice"
      }
    }

    template {
      metadata {
        labels = {
          app = "simpletimeservice"
        }
      }

      spec {
        container {
          image = "nikhilnamaji/simpletimeservice:latest"
          name  = "simpletimeservice"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}