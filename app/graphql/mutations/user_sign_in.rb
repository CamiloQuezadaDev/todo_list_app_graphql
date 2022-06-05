class Mutations::UserSignIn < Mutations::BaseMutation
  argument :email, String, required: false
  argument :password, String, required: false

  field :user, Types::UserType, null: true
  field :success, Boolean, null: true
  field :errors, [String], null: true
  field :token, String, null: true

  def resolve(args)

    user = User.find_by(email: args[:email])

    unless user.present?
      raise Exception, "The submitted form contains errors please verify."
    end

    if args[:password].nil?
      raise Exception, "The Password can't be blank."
    end

    unless user.valid_password?(args[:password])
      raise Exception, "The submitted form contains errors please verify."
    end

    return {
      token: user.authentication_token,
      user: user,
      errors: user.errors.full_messages.presence,
      success: true
    }

    rescue Exception => e
      { errors: e.message.split(",") ,success: false}
  end
end