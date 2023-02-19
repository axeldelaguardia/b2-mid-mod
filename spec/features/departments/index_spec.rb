require 'rails_helper'

RSpec.describe 'departments index page', type: :feature do
	let!(:department_1) { Department.create!(name: 'IT', floor: 3) }
	
	describe 'display departments' do
		it 'displays each all departments name and floor' do
			visit '/departments'
			
			expect(page).to have_content('IT')
			expect(page).to have_content('Floor: 3')
		end
	end
end