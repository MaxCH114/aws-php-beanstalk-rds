# --------------------------------------
# ELASTIC BEANSTALK CONFIGURATION FOR PHP
# --------------------------------------
# This Terraform configuration sets up an AWS Elastic Beanstalk environment
# for a PHP application. It includes the creation of a VPC, subnets, security groups,
resource "aws_elastic_beanstalk_environment" "env" {
  name                = "my-php-env"
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2 v3.9.0 running PHP 8.1"

  # Link the environment to the custom VPC
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.main.id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = aws_subnet.public.id
  }

  # Attach IAM instance profile
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.beanstalk_instance_profile.name
  }

  # Pass RDS connection info as environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = aws_db_instance.default.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_NAME"
    value     = "mydb"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = "admin"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = "YourSecurePassword123!"
  }
}