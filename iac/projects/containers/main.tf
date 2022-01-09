module "ecrs" {
    source = "../../resources/ecr"
    # name = each.key
    # for_each = toset(var.list_lambdas)
    name = "gh-flow"
    image_tag_mutability = "IMMUTABLE"
    scan_on_push = true
}