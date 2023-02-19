require 'rails_helper'

RSpec.describe Employee, type: :model do
	let!(:department) { Department.create!(name: 'IT', floor: 2) }

	let!(:employee_1) { department.employees.create!(name: 'John', level: 2) }
	let!(:employee_2) { department.employees.create!(name: 'Mary', level: 2) }
	let!(:employee_3) { department.employees.create!(name: 'Sigrit', level: 2) }

	let!(:ticket_1) { Ticket.create!(subject: 'Printer is broken', age: 1) }
	let!(:ticket_2) { Ticket.create!(subject: 'Phone is not working', age: 3) }
	let!(:ticket_3) { Ticket.create!(subject: 'Internet is out', age: 2) }
	let!(:ticket_4) { Ticket.create!(subject: 'HELP', age: 5) }

	let!(:ticket_5) { Ticket.create!(subject: 'Ethernet Broken', age: 1) }
	
	let!(:ticket_6) { Ticket.create!(subject: 'Screen off', age: 1) }

	before do
		EmployeeTicket.create!(employee: employee_1, ticket: ticket_1)
		EmployeeTicket.create!(employee: employee_1, ticket: ticket_2)
		EmployeeTicket.create!(employee: employee_1, ticket: ticket_3)
		EmployeeTicket.create!(employee: employee_1, ticket: ticket_4)
		EmployeeTicket.create!(employee: employee_1, ticket: ticket_5)

		EmployeeTicket.create!(employee: employee_2, ticket: ticket_5)
		
		EmployeeTicket.create!(employee: employee_3, ticket: ticket_6)
	end

  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many(:employee_tickets) }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

	describe 'instance methods' do
		it '#oldest_ticket' do
			expect(employee_1.oldest_ticket).to eq(ticket_4)
		end

		it '#tickets_sorted_desc' do
			expect(employee_1.tickets_sorted_desc).to eq([ticket_4, ticket_2, ticket_3, ticket_1, ticket_5])
		end

		it '#ticket_ids' do
			expect(employee_1.ticket_ids).to eq([ticket_1.id, ticket_2.id, ticket_3.id, ticket_4.id, ticket_5.id])
		end

	end

	describe 'class methods' do
		it '::best_friends' do
			expect(Employee.best_friends(employee_1)).to eq([employee_2])
		end
	end
end