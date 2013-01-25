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

	factory :product do
		description "Lorem ipsum"
		#Factory Girl is: Not only can we assign the user using mass assignment (since factories bypass attr_accessible), we can also set created_at manually, which Active Record won’t allow us to do.
		#FactoryGirl.create(:micropost, user: @user, created at: 1.hour.ago)
		user
	end

end
