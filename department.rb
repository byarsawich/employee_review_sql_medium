class Department < ActiveRecord::Base
  has_many :employees

  def total_employees
    self.employees.length
  end

  def add_employee(new_employee)
    self.employees << new_employee
  end

  def department_salary
    self.employees.reduce(0.0) {|sum, e| sum + e.salary}
  end

  def department_raise(alloted_amount)
    raise_eligible = self.employees.select {|e| yield(e)}
    amount = alloted_amount / raise_eligible.length
    raise_eligible.each {|e| e.raise_by_amount(amount)}
  end
end
