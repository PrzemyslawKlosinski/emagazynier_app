# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)
#  password_digest            :string(255)
#  name                       :string(255)
#  about                      :text
#  www                        :string(255)
#  isActive                   :boolean
#  agreementElectronicInvoice :boolean
#  agreementProcessing        :boolean
#  headerPicture              :binary
#  headerText                 :text
#  footerText                 :text
#  location_id                :integer
#  partialInventory           :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'spec_helper'

describe User do
  
  #test domyslny dla modelu
  # pending "add some examples to (or delete) #{__FILE__}"

  #poniewaz inicjujemy name przez defaults test, taki user powinien byc valid
  before { @user = User.new(email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  #test na odpowiedz z modelu
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

  #test na to czy oba hasla sa identyczne: password oraz password_confirmation sa virtualne
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  #testy na walidacje wszystkich - rowniez na to czy hasla sa takie same - zalatwia gem
  it { should be_valid }

  #test jesli oba hasla sa puste, walidacje nie powinna przejsc - zalatwia gem
  describe "when password is not present" do
  	before { @user.password = @user.password_confirmation = " " }
  	it { should_not be_valid }
  end

  #test jesli hasla nie sa takie same, walidacja nie powinna przejsc - zalatwia gem
  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  # #test jesli nil?, walidacja nie powinna przejsc - usunelismy walidacje password :presence
  # describe "when password confirmation is nil" do
  # 	before { @user.password_confirmation = nil }
  # 	it { should_not be_valid }
  # end

  #test na walidacje czy wartosc nie jest pusta .blank?
  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end



  #test czy obiekt User reaguje na metode authenticate, User.authenticate?
  it { should respond_to(:authenticate) }

  #test czy obiekt User zwraca odpowiedz na metode User.admin? (? oznacza zwroc wartosc boolean)
  it { should respond_to(:admin) }

  # toggle! method to flip the admin attribute from false to true.
  # should be_admin implies that the user should have an admin? boolean method. (the RSpec boolean convention) 
  it { should be_valid }
  it { should_not be_admin }
  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }
    it { should be_admin }
  end

  #test na dlugosc hasla, nie moze byc mniejsze niz 6
  describe "with a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  	it { should be_invalid }
  end

  #dwa testy na to gdy haslo pasuje i gdy nie pasuje po wykonaniu metody authenticate
  #pierwszy blok gdy haslo trafione, drugi blok gdy haslo nie zostalo trafione
  describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by_email(@user.email) }
  	
  	describe "with valid password" do
  		it { should == found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  		it { should_not == user_for_invalid_password }
  		specify { user_for_invalid_password.should be_false }
  	end
  end

  #test czy email zostal zapisany malymi literami
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
      it "should be saved as all lower-case" do
        @user.email = mixed_case_email
        @user.save
        @user.reload.email.should == mixed_case_email.downcase
      end
  end



  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  #test dlugosci pole name, ograniczenie nalozone rowniez dla email
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  #test na walidacje maila
  describe "when email format is invalid" do
  	it "should be_invalid" do
  		addresses = %w[user@foo,com user at foo.org example.user@foo. foo@bar baz.com foo@bar+baz.com]
  		
  		addresses.each do |invalid_address|
  			@user.email = invalid_address
  			@user.should_not be_valid
  		end
  	end
  end

  describe "when email format is valid" do
  	it "should be_valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			@user.email = valid_address
  			@user.should be_valid
		end
	end
  end

  #test na unikatowosc - wykorzystujemy zmienna user, wgenerowana przez before { }
  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup					#kopiujemy usera
  		user_with_same_email.email = @user.email.upcase		#zamieniamy litery na duze, ma byc should_not be_valid
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  #test na zapisanie tokena w obiekcie modelu user
  describe "remember token" do
      before { @user.save }
      # it { @user.remember_token.should_not be_blank }
      its(:remember_token) { should_not be_blank }
   end

end
