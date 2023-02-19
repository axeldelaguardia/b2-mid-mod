class EmployeesController < ApplicationController
	def show
		@employee = Employee.find(params[:id])
		@tickets = @employee.tickets_sorted_desc
		@other_tickets = Ticket.tickets_excluding_employee(@employee.id)
	end
end
