class Mutations::TaskCreate < Mutations::BaseMutation
  description 'Create a Task by current User'

  argument :name, String, required: false

  field :task,Types::TaskType, null: true
  field :success, Boolean, null: true
  field :errors, [String], null: true

  def resolve(args)
    unless context[:current_user]
      raise Exception, "Sign in to do this action"
    end

    args.merge!({user: context[:current_user]})

    task = Task.new(args)

    if task.save!
      {
        task: task,
        success: task.valid?,
        errors: task.errors.full_messages.presence
      }
    else 
      raise ActiveRecord::RecordInvalid, task
    end

    rescue ActiveRecord::RecordInvalid => invalid
      { errors: invalid.record.errors.full_messages, success: false }

    rescue Exception => e
      { errors: e.message.split(","), success: false }
  end

end