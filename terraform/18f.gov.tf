// Keep only the zone definition that tock.18f.gov depends on
resource "aws_route53_zone" "d_18f_gov_zone" {
  name = "18f.gov."

  tags = {
    Project = "dns"
  }
}

// All other records have been removed
