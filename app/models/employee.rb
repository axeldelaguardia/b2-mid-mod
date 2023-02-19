class Employee < ApplicationRecord
  belongs_to :department
	has_many :employee_tickets
	has_many :tickets, through: :employee_tickets

	def tickets_sorted_desc
		tickets.order(age: :desc)
	end

	def oldest_ticket
		tickets.order(age: :desc).first
	end

	def ticket_ids
		tickets.pluck(:id)
	end
end