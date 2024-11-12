variable "image" {
  type        = map(map(string))
  description = "image for containers"
  default = {
    red_image = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influx_image = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana_image = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }

}

variable "ext_port" {
  type = map(map(list(number)))
  # default = 1880
  # validation {
  #   condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
  #   error_message = "between 0 and  65535 "
  # }
  # validation {
  #   condition     = max(var.ext_port["prod"]...) <= 1980 && min(var.ext_port["prod"]...) >= 1880
  #   error_message = "between 0 and  65535 "
  # }
}