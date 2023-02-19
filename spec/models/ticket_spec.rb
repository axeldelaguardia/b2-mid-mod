require 'rails_helper'

RSpec.describe Ticket, type: :model do
	it { should have_many(:employee_tickets) }
	it { should have_many(:employees).through(:employee_tickets) }

	describe 'class methods' do
		let!(:department_1) { Department.create!(name: 'IT', floor: 2) }
		let!(:department_2) { Department.create!(name: 'Maintenance', floor: 3) }
	
		let!(:employee_1) { department_1.employees.create!(name: 'John', level: 2) }
		let!(:employee_2) { department_1.employees.create!(name: 'Mary', level: 2) }
		let!(:employee_3) { department_2.employees.create!(name: 'Dwayne', level: 1) }
	
		let!(:ticket_1) { Ticket.create!(subject: 'Printer is broken', age: 1) }
		let!(:ticket_2) { Ticket.create!(subject: 'Phone is not working', age: 3) }
		let!(:ticket_3) { Ticket.create!(subject: 'Internet is out', age: 2) }
		let!(:ticket_4) { Ticket.create!(subject: 'HELP', age: 5) }
	
		let!(:ticket_5) { Ticket.create!(subject: 'Computer slow', age: 2) }
		let!(:ticket_6) { Ticket.create!(subject: 'Directory gone', age: 3) }
	
		let!(:ticket_7) { Ticket.create!(subject: 'Ethernet port broken', age: 2) }
		
		before do
			EmployeeTicket.create!(employee: employee_1, ticket: ticket_1)
			EmployeeTicket.create!(employee: employee_1, ticket: ticket_2)
			EmployeeTicket.create!(employee: employee_1, ticket: ticket_3)
			EmployeeTicket.create!(employee: employee_1, ticket: ticket_4)
	
			EmployeeTicket.create!(employee: employee_2, ticket: ticket_5)
			EmployeeTicket.create!(employee: employee_2, ticket: ticket_6)
	
			EmployeeTicket.create!(employee: employee_3, ticket: ticket_7)
		end

		it '::tickets_excluding_employee' do
			expect(Ticket.tickets_excluding_employee(employee_1.id)).to eq([ticket_5, ticket_6, ticket_7])
		end
	end
end
