#This defines a task db:populate that creates an example user with name and email
#address replicating our previous one, and then makes 99 more.
#tworzy 99 userow
namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do

		admin = User.create!(name: "Z.P.U.H. Drewnotex", email: "drewnotex@gmail.com", password: "foobar", password_confirmation: "foobar")
		#ustawiamy zmienna admin na true /zamiana z false przy pomocy admin,toggle!(:admin) bo nie mamy ustawionego attr_accessible
		admin.toggle!(:admin)

		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@gmail.com"
			password = "password"
			User.create!(name: name, email: email, password: password, password_confirmation: password)
		end
	end
end
