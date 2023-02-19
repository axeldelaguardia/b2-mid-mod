# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

department_1 = Department.create(name: 'IT', floor: 2)
department_2 = Department.create(name: 'Maintenance', floor: 3)

employee_1 = department_1.employees.create(name: 'John', level: 2)
employee_2 = department_1.employees.create(name: 'Mary', level: 2)
employee_3 = department_2.employees.create(name: 'Dwayne', level: 1)

ticket_1 = Ticket.create(subject: 'Printer is broken', age: 1)
ticket_2 = Ticket.create(subject: 'Phone is not working', age: 3)
ticket_3 = Ticket.create(subject: 'Internet is out', age: 2)
ticket_4 = Ticket.create(subject: 'HELP', age: 5)
ticket_5 = Ticket.create(subject: 'Computer slow', age: 2)
ticket_6 = Ticket.create(subject: 'Directory gone', age: 3)
ticket_7 = Ticket.create(subject: 'Ethernet port broken', age: 2)

EmployeeTicket.create(employee: employee_1, ticket: ticket_1)
EmployeeTicket.create(employee: employee_1, ticket: ticket_2)
EmployeeTicket.create(employee: employee_1, ticket: ticket_3)
EmployeeTicket.create(employee: employee_1, ticket: ticket_4)
EmployeeTicket.create(employee: employee_1, ticket: ticket_7)
EmployeeTicket.create(employee: employee_2, ticket: ticket_5)
EmployeeTicket.create(employee: employee_2, ticket: ticket_6)
EmployeeTicket.create(employee: employee_3, ticket: ticket_7)