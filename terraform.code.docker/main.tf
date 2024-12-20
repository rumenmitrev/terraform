module "image" {
  source   = "./modules/image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  # depends_on        = [terraform_data.dockervol]
  source   = "./modules/container"
  for_each = local.deployment

  count_in    = each.value.container_count
  name_in     = each.key
  image_in    = module.image[each.key].image_id
  internal_in = each.value.int
  external_in = each.value.ext
  volumes_in  = each.value.volumes
}