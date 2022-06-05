class Mutations::UserSignUp < Mutations::BaseMutation
  description 'Create a new User to Task App'

  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :email, String, required: false
  argument :username, String, required: false
  argument :password, String, required: false

  field :user, Types::UserType, null: true
  field :success, Boolean, null: true
  field :errors, [String], null: true

  def resolve(args)
    user = User.new(args)

    if user.save!
      return {
        user: user,
        success: user.valid?,
        errors: user.errors.full_messages.presence
      }
    else
      raise ActiveRecord::RecordInvalid => invalid
    end
      

    rescue ActiveRecord::RecordInvalid => invalid
      { errors: invalid.record.errors.full_messages, success: false }
    end
  end
