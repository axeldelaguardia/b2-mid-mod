require 'rails_helper'

RSpec.describe 'departments index page', type: :feature do
	let!(:department_1) { Department.create!(name: 'IT', floor: 3) }
	let!(:department_2) { Department.create!(name: 'Accounting', floor: 2) }
	let!(:employee_1) { department_1.employees.create!(name: 'John', level: 1) }
	let!(:employee_2) { department_1.employees.create!(name: 'Mary', level: 2) }
	let!(:employee_3) { department_2.employees.create!(name: 'Arnold', level: 3) }
	let!(:employee_4) { department_2.employees.create!(name: 'Sigrit', level: 1) }


	
	describe 'display departments' do
		it 'displays each all departments name and floor' do
			visit '/departments'

			within "div##{department_1.id}" do
				expect(page).to have_content('IT')
				expect(page).to have_content('Floor: 3')
			end
		end

		it 'displays employees under departments' do
			visit '/departments'

			within "div##{department_1.id}" do
				expect(page).to have_content("#{employee_1.name}")
				expect(page).to have_content("Level: #{employee_1.level}")
				expect(page).to have_content("#{employee_2.name}")
				expect(page).to have_content("Level: #{employee_2.level}")
			end
			
			within "div##{department_2.id}" do
				expect(page).to have_content("#{employee_3.name}")
				expect(page).to have_content("Level: #{employee_3.level}")
				expect(page).to have_content("#{employee_4.name}")
				expect(page).to have_content("Level: #{employee_4.level}")
			end
		end
	end
end