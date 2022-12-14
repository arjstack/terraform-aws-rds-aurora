output "global_cluster_arn" {
    description = "RDS Global Cluster Amazon Resource Name (ARN)"
    value = var.create_global_cluster ? aws_rds_global_cluster.this[0].arn : ""
}

output "cluster_arn" {
    description = "RDS Cluster Amazon Resource Name (ARN)"
    value = var.create_cluster ? aws_rds_cluster.this[0].arn : ""
}

output "port" {
    description = "Database port"
    value = var.create_cluster ? aws_rds_cluster.this[0].port : ""
}

output "db_subnet_group" {
    description = "Database Subnet Group Details"
    value = var.create_cluster && var.create_db_subnet_group ? {
                                            id = aws_db_subnet_group.this[0].id
                                            arn = aws_db_subnet_group.this[0].arn
                                          } : {}
}

output "instances" {
    description = "RDS Aurora Cluster Instances"
    value = { for key, value in aws_rds_cluster_instance.this: 
                    key => {
                            id = value.id
                            arn = value.arn
                            endpoint = value.endpoint
                            writer = value.writer
                        }}
}

output "cluster_endpoint" {
    description = "RDS Aurora Cluster Endpint"
    value = var.create_cluster ? aws_rds_cluster.this[0].endpoint : ""
}

output "cluster_reader_endpoint" {
    description = "RDS Aurora Cluster Read only Endpint; automatically load-balanced across replicas"
    value = var.create_cluster ? aws_rds_cluster.this[0].reader_endpoint : ""
}

output "custom_endpoints" {
    description = "RDS Aurora Cluster Custom Endpints"
    value = { for key, value in aws_rds_cluster_endpoint.this: 
                    key => {
                            id = value.id
                            arn = value.arn
                            endpoint = value.endpoint
                        }}
}

output "rds_monitoring_role" {
    description = "IAM role created for RDS enhanced monitoring"
    value = (var.enable_enhanced_monitoring 
                && var.create_monitoring_role) ? module.rds_monitoring_role[0].service_linked_roles[var.monitoring_role_name] : null
}

output "ssm_paramter_cluster_host" {
    description = "The SSM Parameter ARN for cluster Host"
    value = (var.create_cluster 
                    && var.primary_cluster 
                    && var.ssm_cluster_host) ? aws_ssm_parameter.cluster_host[0].arn : ""
}

output "ssm_paramter_database_name" {
    description = "The SSM Parameter ARN for Database name"
    value = (var.create_cluster 
                    && var.primary_cluster 
                    && var.ssm_database_name) ? aws_ssm_parameter.database_name[0].arn : ""
}


output "ssm_paramter_master_username" {
    description = "The SSM Parameter ARN for Master User Name"
    value = (var.create_cluster 
                    && var.primary_cluster 
                    && var.ssm_master_username) ? aws_ssm_parameter.master_username[0].arn : ""
}

output "ssm_paramter_master_password" {
    description = "The SSM Parameter ARN for Master password"
    value = (var.create_cluster 
                    && var.primary_cluster 
                    && var.ssm_master_password) ? aws_ssm_parameter.master_password[0].arn : ""
}

output "sg_id" {
    description = "The Security Group ID associated to RDS"
    value = var.create_sg ? module.rds_security_group[0].security_group_id : ""
}