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

</li><li>

To destroy (remove all services from aws), run:

```sh
terraform destroy -auto-approve
```

</li></ol>

## Reference

- https://github.com/chgasparoto/youtube-cleber-gasparoto
