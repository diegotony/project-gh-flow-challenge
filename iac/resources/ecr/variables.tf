variable "name" {
    type = string
    description = "ECR Name"
}

variable "image_tag_mutability" {
    type = string
    description = "ECR image tag mutability MUTABLE or INMUTABLE"
}

variable "scan_on_push" {
    type = bool
    description = "ECR image  security scan on push"
}