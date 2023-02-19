require 'rails_helper'

RSpec.describe 'employees show page', type: :feature do
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
		EmployeeTicket.create!(employee: employee_1, ticket: ticket_7)

		EmployeeTicket.create!(employee: employee_2, ticket: ticket_5)
		EmployeeTicket.create!(employee: employee_2, ticket: ticket_6)

		EmployeeTicket.create!(employee: employee_3, ticket: ticket_7)
	end

	describe 'display employee info' do
		it 'shows employee name, department' do
			visit "/employees/#{employee_1.id}"

			expect(page).to have_content(employee_1.name)
			expect(page).to have_content("Department: #{employee_1.department.name}")			
		end

		it 'shows a list of all their tickets, sorted oldest to youngest' do
			visit "/employees/#{employee_1.id}"

			within "li##{ticket_1.id}" do
				expect(page).to have_content("Subject: #{ticket_1.subject}")
				expect(page).to have_content("Age: #{ticket_1.age}")
			end
			
			within "div#tickets" do
				expect(page).to_not have_content(ticket_4.subject)
				expect(ticket_2.subject).to appear_before(ticket_3.subject)
				expect(ticket_3.subject).to appear_before(ticket_1.subject)
				expect(page).to have_content(ticket_1.subject)
			end
		end

		it 'shows the oldest ticket assigned to employee listed seperately' do
			visit "/employees/#{employee_1.id}"
			
			within "fieldset#oldest_ticket" do
				expect(page).to have_content(ticket_4.subject)
				expect(page).to have_content(ticket_4.age)
				expect(page).to_not have_content(ticket_3.subject)
				expect(page).to_not have_content(ticket_3.age)
				expect(page).to_not have_content(ticket_2.subject)
				expect(page).to_not have_content(ticket_2.age)
				expect(page).to_not have_content(ticket_1.subject)
				expect(page).to_not have_content(ticket_1.age)
			end
		end

		it "does not show tickets not assigned to employee" do
			visit "/employees/#{employee_1.id}"

			expect(page).to_not have_content(ticket_5.subject)
		end
	end

	describe 'form to add ticket' do
		it 'has a form to add a ticket to department/employee' do
			visit "/employees/#{employee_1.id}"

			expect(page).to_not have_content(ticket_6.subject)

			select ticket_6.id, from: :ticket_id
			click_button 'Add Ticket'

			expect(current_path).to eq("/employees/#{employee_1.id}")
			expect(page).to have_content(ticket_6.subject)
		end
	end

	describe 'best friends' do
		it 'unique list of tickets that are shared with other employees' do
			visit "/employees/#{employee_1.id}"
			save_and_open_page
			within 'fieldset#best_friends' do
				expect(page).to_not have_content(employee_2.name)
				expect(page).to have_content(employee_3.name)
			end
		end
	end
end