resource "aws_route53_zone" "innovation_toplevel" {
  name = "innovation.gov"

  tags = {
    Project = "dns"
  }
}

# Redirect apex domain to permitting.innovation.gov
resource "aws_route53_record" "innovation_gov_apex" {
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
  name    = "innovation.gov."
  type    = "CNAME"
  ttl     = 300
  records = ["permitting.innovation.gov."]
}

# Redirect www subdomain to permitting.innovation.gov
resource "aws_route53_record" "innovation_gov_www" {
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
  name    = "www.innovation.gov."
  type    = "CNAME"
  ttl     = 300
  records = ["permitting.innovation.gov."]
}

resource "aws_route53_record" "acme_challenge_permitting_innovation_gov_cname" {
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
  name    = "_acme-challenge.permitting.innovation.gov."
  type    = "CNAME"
  ttl     = 300
  records = ["_acme-challenge.permitting.innovation.gov.external-domains-production.cloud.gov."]
}

resource "aws_route53_record" "permitting_innovation_gov_cname" {
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
  name    = "permitting.innovation.gov."
  type    = "CNAME"
  ttl     = 300
  records = ["permitting.innovation.gov.external-domains-production.cloud.gov."]
}

resource "aws_route53_record" "acme_challenge_ce_permitting_innovation_gov_cname" {
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
  name    = "_acme-challenge.ce.permitting.innovation.gov."
  type    = "CNAME"
  ttl     = 300
  records = ["_acme-challenge.ce.permitting.innovation.gov.external-domains-production.cloud.gov."]
}

resource "aws_route53_record" "ce_permitting_innovation_gov_cname" {
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
  name    = "ce.permitting.innovation.gov."
  type    = "CNAME"
  ttl     = 300
  records = ["ce.permitting.innovation.gov.external-domains-production.cloud.gov."]
}

module "innovation_gov__email_security" {
  source  = "./email_security"
  zone_id = aws_route53_zone.innovation_toplevel.zone_id
}

output "innovation_ns" {
  value = aws_route53_zone.innovation_toplevel.name_servers
}
