# Send Read Message Lambda
Generic set of lambda that sends a message to sqs and subsequently gets read by another lambda.

## Usage
You can clone this repository or fork (if you're looking to enhance it).

### Running
Create a `terraform.auto.tfvars` file with the following values:
```terraform
account_id   = "<your-account-id>"
region       = "<your-region>"
default_tags = <map-of-default-tags>
```

Once done, you can run:
```
terraform plan
terraform apply
```

> If not using the default profile, specify `AWS_PROFILE` environment variable
> Terraform configuration doesn't specific state store. If not specified, it will create the state locally.

### Triggering lambda
You can trigger the send-message-lambda via the following:

```sh
aws lambda invoke --function-name send-message-lambda /dev/stdout
```

This will just trigger the send-message-lambda and publish a message to sqs, which is subsequently read by the read-message-lambda
