variable "env" {
  type = "string"
}

variable "app" {
  type = "string"
  default = "www"
}

variable "service_name" {
  type = "string"
}

variable "sumo_logger_name" {
  type = "map"
  default = {
  dev = "fastly-www/stg"
  stg = "fastly-www/stg"
  prd = "fastly-www/prd"
  }
}

variable "sumo_logger_purge_name" {
  type = "map"
  default = {
  dev = "fastly-www-purge/stg"
  stg = "fastly-www-purge/stg"
  prd = "fastly-www-purge/prd"
  }
}

variable "sumologic_endpoint" {
  type = "map"

  default = {
    dev = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV090sPFU_YnnEP_F61BBPpciroz627Cc5zoPONnZQtGWWIiqPAs6g3LsPXOc3JfFUPl44yl-tlLnkH-Pn7xp1X9QarWeCQeQjSPeA0wqbLn-A=="
    stg = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV090sPFU_YnnEP_F61BBPpciroz627Cc5zoPONnZQtGWWIiqPAs6g3LsPXOc3JfFUPl44yl-tlLnkH-Pn7xp1X9QarWeCQeQjSPeA0wqbLn-A=="
    prd = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV3DIdcy2GqnQ5DMhk6CZkjlLK9C5V5fjRSlaVm4RJg3dU1REHf-_owjetrn1mzlLqDx1KlNQ6qwtrgHf1KwvOaVcZBHpQSdqG-tFYf0OFYEUQ=="
  }
}

variable "sumologic_endpoint_json" {
  type = "map"
  default = {
    dev = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV2LlpGb4VDoidBmH_To3weFMf_Eo8ujQDiiACqhhpxfn4-GTfWTFdSah4oLID8jTZ2mCP_0cqCbVU7qePWuBJoxDdIIwDgm2SFZL2g30zal5Q=="
    stg = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV2LlpGb4VDoidBmH_To3weFMf_Eo8ujQDiiACqhhpxfn4-GTfWTFdSah4oLID8jTZ2mCP_0cqCbVU7qePWuBJoxDdIIwDgm2SFZL2g30zal5Q=="
    prd = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV0fRib17FqHM8YTjuKyp-s-Cb1QEdsTH3fvZnEGVg2187Ed7SbAvyBFOwz2-GEtrp_5Oldnmt2toYlq4jVtgfHEnXsLdiOh-O3r2H4XaqtEXw=="
  }
}

variable "sumologic_endpoint_json_purge" {
  type = "map"
  default = {
    dev = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV3aoOagRY1lC1_0sLTOf4kUmmZqDG8-_LpC-NClIJuUIhmKG53Br15wr98FMxLVgngSWYYfHQ9Kgk11NC0Rifbs4YzVcmieCVJWAfe70QDaWg=="
    stg = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV3aoOagRY1lC1_0sLTOf4kUmmZqDG8-_LpC-NClIJuUIhmKG53Br15wr98FMxLVgngSWYYfHQ9Kgk11NC0Rifbs4YzVcmieCVJWAfe70QDaWg=="
    prd = "https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV0r3dv-d_4v7eNrmiNwR4fcta42vACUJhNOfIoh0VnBxlYPDdCRl9z5AVpibjA2x_-Uaft02mSZKfG40gLcuQOt_0Sewu6FbMWWVIYnxh9fCw=="
  }
}

variable "bigquery_secret_key" {
  type = "string"
}

variable "datadog_api_key" {
  type = "string"
}
