resource "kubernetes_service" "example" {
  metadata {
    name = "example-service"
  }
  spec {
    selector = {
      "app" = "example"
    }
    port {
      port        = 8765
      target_port = 9376
    }
    type = "LoadBalancer"
  }
}
