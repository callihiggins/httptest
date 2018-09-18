resource "local_file" "output" {
  content  = "${fastly_service_v1.service.active_version}"
  filename = "/root/output/vcl_version"
}
