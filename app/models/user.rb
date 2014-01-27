class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true,
              length: { minimum: 2 }
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  has_secure_password validations: false

  def admin?
    self.role == 'admin'
  end

  def moderator?
    self.role.eql?('moderator')
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # random 6 digits
    #self.pin= rand(10 ** 6)
    #save
  end

  def send_pin_to_twilio
    account_sid = 'AC313afdfada94e6f9e456609ff52035bd'
    auth_token = '50d2e567543e2ac1f3e77f05f191b537'

    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new account_sid, auth_token

    msg = "Hi, please input the pin to continue login: #{self.pin}"
    client.account.messages.create({
      :from => '+16178261605',
      :to => '6035020719',
      :body => msg,
    })
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end
end



