class Ticket < ApplicationRecord
	has_many :employee_tickets
	has_many :employees, through: :employee_tickets

	def self.tickets_excluding_employee(employee_id)
		joins(:employees).where.not(employees: {id: employee_id})
	end
end
