class Department < ActiveRecord::Base
  has_many :employees

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

  def department_raise_by_percent(percent)
    raise_eligible = self.employees.select {|e| yield(e)}
    raise_eligible.each {|e| e.raise_by_percent(percent)}
  end

  def total_employees
    self.employees.length
  end

  def lowest_paid
    temp = employees.sort_by {|e| e.salary}
    temp.first
  end

  def list_employees_by_name
    self.employees.sort_by {|e| e.first_name}
  end

  def paid_above_average
    average = department_salary / self.employees.length
    self.employees.select {|e| e.salary > average}
  end

  def employee_palindromes
    self.employees.select {|e| e.name.gsub(" ", "").upcase == e.name.gsub(" ", "").reverse.upcase}
  end

  def largest_department
    max = Department.first.total_employees
    temp_dept = Department.first
    Department.order(:id).each do |d|
      if d.total_employees > max
        max = d.total_employees
        temp_dept = d
      end
    end
    temp_dept
  end

  def move_to(department)
    self.employees.each {|e| department.employees << e}
  end

end
