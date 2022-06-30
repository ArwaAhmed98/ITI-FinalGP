resource "kubernetes_namespace" "tools" {

  metadata {

    name = "tools"
    labels = {
      name = "toolsns"
    }

  }



}



resource "kubernetes_namespace" "dev" {

  metadata {

    name = "dev"
    labels = {
      name = "devns"
    }


  }

}