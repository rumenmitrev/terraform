locals {
  deployment = {
    red = {
      container_count = length(var.ext_port["red"][terraform.workspace])
      image           = var.image["red_image"][terraform.workspace]
      ext             = var.ext_port["red"][terraform.workspace]
      int             = 1880
      volumes = [
        { container_path_each = "/data" }
      ]
    }
    influx = {
      container_count = length(var.ext_port["influx"][terraform.workspace])
      image           = var.image["influx_image"][terraform.workspace]
      ext             = var.ext_port["influx"][terraform.workspace]
      int             = 8086
      container_path  = "/var/lib/influxdb"
      volumes = [
        { container_path_each = "/var/lib/influxdb" }
      ]
    }
    grafana = {
      container_count = length(var.ext_port["grafana"][terraform.workspace])
      image           = var.image["grafana_image"][terraform.workspace]
      ext             = var.ext_port["grafana"][terraform.workspace]
      int             = 3000
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}