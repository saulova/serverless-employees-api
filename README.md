# Serverless Employees Api

This is a simple serverless employees list API using Terraform, Node.js, AWS Lambda and DynamoDB.

## Getting started

This is an example of how you can get a local copy and run the API. Follow these steps.

### Prerequisites

-AWS Account
-NPM or Yarn
-Terraform CLI

### Installation

<ol><li>

Clone repository

```sh
git clone https://github.com/saulova/serverless-employees-api.git
```

</li><li>

If you would like to use ESLint, run

With NPM

```sh
npm install
```

With Yarn

```sh
yarn install
```

</li><li>

Edit <b>terraform/valiables.tf</b> with your AWS credentials.

</li><li>

Inside <b>terraform</b> folder, run

```sh
terraform validate
```

After

```sh
terraform plan
```

Check the plan and

```sh
terraform apply -auto-approve
```

</li></ol>

## Routes

### GET

```
All:
https://<your-api-url>/v1/employees

Find specific:
https://<your-api-url>/v1/employees/<employeeId>
```

### POST (Create)

```
https://<your-api-url>/v1/employees

Request body (replace <values>):
{
  "employeeId": <employeeId-as-number>,
  "age": <age-as-number>,
  "name": "<name-as-string>"
  "occupation": "<occupation-as-string>"
}
```

### PUT (Update)

```
https://<your-api-url>/v1/employees

Request body (replace <values>):
{
  "employeeId": <id-as-number>,
  "<field-to-update>": <new-value>,
}
```

### DELETE

```
https://<your-api-url>/v1/employees/<employeeId>
```

## Destroy

To destroy (remove all services from aws), run:

```sh
terraform destroy -auto-approve
```

## Reference

- https://github.com/chgasparoto/youtube-cleber-gasparoto
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs
