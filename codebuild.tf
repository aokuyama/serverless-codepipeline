resource "aws_codebuild_project" "app" {
  name         = var.project_name
  service_role = aws_iam_role.codebuild.arn
  source {
    git_clone_depth     = 1
    insecure_ssl        = false
    location            = var.uri_repository
    report_build_status = true
    type                = "GITHUB"
    git_submodules_config {
      fetch_submodules = false
    }
    buildspec = data.template_file.buildspec.rendered
  }
  source_version = var.branch-name_deploy
  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:3.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    type                        = "LINUX_CONTAINER"
  }
  artifacts {
    location               = aws_s3_bucket.codepipeline.bucket
    namespace_type         = "NONE"
    type                   = "S3"
    packaging              = "ZIP"
    encryption_disabled    = false
    override_artifact_name = false
  }
  cache {
    location = "${aws_s3_bucket.codepipeline.bucket}/cache"
    type     = "S3"
  }
  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild"
      stream_name = var.project_name
    }
    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }
}
resource "aws_iam_role" "codebuild" {
  path = "/service-role/"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "codebuild.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  managed_policy_arns = [
    # Serverless Framework用。TODO:必要な権限に絞る
    "arn:aws:iam::aws:policy/AdministratorAccess",
    aws_iam_policy.codebuild-log.arn,
    aws_iam_policy.operate-s3.arn,
  ]
}
resource "aws_iam_policy" "codebuild-log" {
  path = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:log-group:/aws/codebuild/${var.project_name}",
            "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:log-group:/aws/codebuild/${var.project_name}:*",
            "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:log-group:/aws/codebuild:log-stream:*",
          ]
        },
        {
          Action = [
            "codebuild:CreateReportGroup",
            "codebuild:CreateReport",
            "codebuild:UpdateReport",
            "codebuild:BatchPutTestCases",
            "codebuild:BatchPutCodeCoverages",
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:codebuild:${var.region}:${data.aws_caller_identity.self.account_id}:report-group/${var.project_name}-*",
          ]
        },
      ]
      Version = "2012-10-17"
    }
  )
}
resource "aws_iam_policy" "operate-s3" {
  path = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          Action = [
            "s3:PutObject",
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:GetBucketAcl",
            "s3:GetBucketLocation",
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:s3:::codepipeline-${var.region}-*",
            "${aws_s3_bucket.codepipeline.arn}/*",
          ]
        },
      ]
      Version = "2012-10-17"
    }
  )
}
