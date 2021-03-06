require 'date'

class Employee < ActiveRecord::Base
  belongs_to :department
  has_many :reviews

  def name
    self.middle_name != nil ? "#{self.first_name} #{self.middle_name} #{self.last_name}" : "#{self.first_name} #{self.last_name}"
  end

  def add_employee_review(review)
    self.reviews << review
    positive_matches = 0
    negative_matches = 0

    positive = [/positive/i, /initiative/i, /great/i, /good/i, /helpful/i,
               /puntual/i, /positive/i, /encourage/i, /beneficial/i, /meets/i,
               /good/i, /(team player)/i, /(hard working)/i, /helps/i, /impressed/i, /impressive/i, /fast/i, /asset/i, /leadership/i, /leader/i, /efficient/i, /(willing to help)/i, /successfully/i,
               /pleasure/i]

    negative = [/negative/i, /lazy/i, /bad/i, /stubborn/i, /(misses deadlines)/i,
               /late/i, /concerns/i, /difficulty/i, /struggles/i, /limitations/i,
               /inconsistent/i, /inefficient/i, /(not done well)/i, /poorly/i,
               /badly/i, /rude/i, /(off topic)/i, /lack/i, /inadequate/i, /limitation/i, /(room for improvement)/i, ]
    positive.each do |r|
      matches = latest_review.review.scan(r).count
      positive_matches += matches
    end
    negative.each do |r|
      matches = latest_review.review.scan(r).count
      negative_matches += matches
    end
    self.performance = (positive_matches > negative_matches)
  end

  def set_employee_performance(boolean)
    self.performance = boolean
  end

  def raise_by_percent(raise_percentage)
    self.salary += (self.salary * raise_percentage)
  end

  def raise_by_amount(raise_amount)
    self.salary += raise_amount
  end

  def latest_review
    temp = self.reviews.sort_by {|r| r.reviewed_on}
    temp.first
  end
end
