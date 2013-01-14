FactoryGirl.define do
	factory :user do
		# name "EMAGAZYNIER1"
		# email "mag@mga.pl"
		# password "foobar"
		# password_confirmation "foobar"
		sequence(:name) { |n| "Person #{n}" }
		sequence(:email) { |n| "person_#{n}@example.com"}
		password "foobar"
		password_confirmation "foobar"
		#dzieki czemu bedziemy mogli tworzyc adminow za pomoca parametru
		factory :admin do
			admin true
		end

	end
end
