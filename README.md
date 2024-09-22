# S3 CloudFront Website

This Terraform module

- Sets up an AWS S3 bucket for hosting a static website
- Configures a CloudFront distribution to serve the website
- Creates Route 53 DNS records for the website's domain
- Manages an ACM certificate for HTTPS

## Usage

To use this module, include the following in your Terraform configuration:

```hcl
module "s3_cloudfront_website" {
  source = "github.com/ewurabenarenee/s3-cloudfront-website"

  root_domain = "YOUR_ROOT_DOMAIN_HERE"
  subdomain   = "YOUR_SUBDOMAIN_HERE" # If not provided, the website will be hosted at the root domain

  providers = {
    aws.ue1 = aws.ue1
  }
}
```

### Important Notes

#### Provider Configuration

- CloudFront distributions and ACM certificates must be created in the `us-east-1` region so the `aws.ue1` provider configuration must be passed to the module

#### Route 53 Zone

- The DNS zone for `root_domain` must already exist in Route 53 - this module only adds the necessary records within an existing zone

#### Domain Name

- The fully qualified domain name (FQDN) is based on the `root_domain` and `subdomain` variables
- Example:
  - `root_domain` = `example.com`, `subdomain` = `blog` results in `blog.example.com`
  - If no subdomain is specified, the FQDN will be `example.com`

#### Deploying the Website

- **Uploading Content:** After deploying the infrastructure, upload your website files to the S3 bucket
  - Use the FQDN as the S3 bucket name
  - Example:
    ```bash
    aws s3 sync ./YOUR_WEBSITE_DIRECTORY s3://YOUR_FQDN
    ```
- **CloudFront Cache Invalidation:** If you update the content in the S3 bucket, invalidate the CloudFront cache to reflect changes
  - Replace `YOUR_DISTRIBUTION_ID` with the actual CloudFront distribution ID
  - Example:
    ```bash
    aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"
    ```
