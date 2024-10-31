output "image_id" {
  value = docker_image.container_image.image_id
  description = "Docker image id"
}