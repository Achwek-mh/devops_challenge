
resource "aws_appsync_api" "appsyncapi" {
  name                = "admin"
  authentication_type = "API_KEY"

  schema = <<EOF
    type List {
      id: ID!
      text: String!
    }

    type Query {
      getList: [List!]!
    }

    type Mutation {
      createList(text: String!): List!
    }
  EOF
}

resource "aws_appsync_datasource" "rds" {
  api_id           = aws_appsync_api.appsyncapi.id
  name             = "rds"
  service_role_arn = aws_iam_role.appsync_role.arn
  type             = "RELATIONAL_DATABASE"

  relational_database_config {
    relational_database_source {
      region                = "us-east-1"
      db_cluster_identifier = aws_db_instance.postgres.id
      database_name         = aws_db_instance.postgres.name
    }
  }
}

resource "aws_iam_role" "appsync_role" {

  inline_policy {
    name = "appsync_permissions"

    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect   = "Allow",
          Action   = ["appsync:GraphQL", "appsync:CreateGraphqlApi"],
          Resource = "*",
        },
      ],
    })
  }
}




output "appsync_api_id" {
  appsync_api_id = aws_appsync_api.appsync_api.id
  appsync_api_url = aws_appsync_api.appsync_api.graphql_endpoint
}