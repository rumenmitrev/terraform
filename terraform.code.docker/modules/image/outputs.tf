output "image_id" {
  value = docker_image.nodered_image.image_id
  description = "Docker image id"
}