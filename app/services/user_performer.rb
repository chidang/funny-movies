class UserPerformer
  attr_accessor :logged_in_data, :messages

  def initialize(params)
    @params = params
    @logged_in_data = {}
    @messages = {}
  end

  def perform
    user = User.find_by(email: @params[:email])
    if user.present?
      login(user)
    else
      create_and_login
    end
    [logged_in_data, messages]
  end

  private

  def login(user)
    if user.try(:authenticate, @params[:password])
      set_logged_in_data(user)
    else
      messages[:danger] = 'Wrong password. Please try again.'
    end
  end

  def create_and_login
    user = User.new(@params)
    if user.save
      set_logged_in_data(user)
    else
      messages[:danger] = user.errors.to_a.join(', ')
    end
  end

  def set_logged_in_data(user)
    logged_in_data[:user_email] = user.email
    logged_in_data[:user_id] = user.id
  end
end
