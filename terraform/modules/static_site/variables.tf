variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  nullable    = false
}

variable "mime_types" {
  type = map(string)
  default = {
    "html" = "text/html; charset=utf-8"
    "css"  = "text/css; charset=utf-8"
    "js"   = "application/javascript; charset=utf-8"
    "svg"  = "image/svg+xml"
  }
}

