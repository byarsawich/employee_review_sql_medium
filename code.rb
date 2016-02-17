require './database_configuration.rb'
require './employee_review_migration.rb'

EmployeeReviewsMigration.migrate(:up)
