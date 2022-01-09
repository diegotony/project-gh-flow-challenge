module "ecrs" {
    source = "../../resources/ecr"
    for_each = toset(var.list_lambdas)
    name = each.key
    image_tag_mutability = "IMMUTABLE"
    scan_on_push = true
}