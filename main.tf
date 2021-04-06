#TODO:
#backup

data "huaweicloud_dcs_az" "this" {
  name = "${var.region_ch}1" # use region code in the next release: https://github.com/huaweicloud/terraform-provider-huaweicloud/pull/1016
}

data "huaweicloud_dcs_az" "this2" {
  name = "${var.region_ch}2" # use region code in the next release: https://github.com/huaweicloud/terraform-provider-huaweicloud/pull/1016
}

resource "huaweicloud_dcs_instance" "this" {
  name            = var.name
  engine          = "Redis"
  engine_version  = "5.0"
  password        = var.password
  capacity        = 2 # to improve: capacity and product_id are dependant
  vpc_id          = var.vpc_id
  subnet_id       = var.subnet_id
  available_zones = [data.huaweicloud_dcs_az.this.id, data.huaweicloud_dcs_az.this2.id]
  product_id      = var.flavor
  save_days       = 1
  backup_type     = "manual"
  begin_at        = "00:00-01:00"
  period_type     = "weekly"
  backup_at       = [1]
}
