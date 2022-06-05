class Mutations::TaskUpdate < Mutations::BaseMutation
  description 'Update a Task by current User'

  argument :id, ID, required: false
  argument :slug, String, required: false

  argument :name, String, required: false
  argument :state, Types::Enums::TaskStatesEnumType, required: false

  field :task,Types::TaskType, null: true
  field :success, Boolean, null: true
  field :errors, [String], null: true

  def resolve(args)

    unless context[:current_user]
      raise Exception, "Sign in to do this action"
    end

    task = Task.find_by(id: args[:id], user_id: context[:current_user]&.id) || Task.find_by(slug: args[:slug], user_id: context[:current_user]&.id)

    unless task.present?
      raise ActiveRecord::RecordNotFound, "Couldn't find Task"
    end

    args.delete(:id)
    args.delete(:slug)

    if task.update(args)
      {
        task: task,
        success: task.valid?,
        errors: task.errors.full_messages.presence
      }
    else 
      raise ActiveRecord::RecordInvalid, task
    end

    rescue ActiveRecord::RecordNotFound => e
      return { errors: [e], success: false }

    rescue ActiveRecord::RecordInvalid => invalid
      { errors: invalid.record.errors.full_messages, success: false }

    rescue Exception => e
      { errors: e.message.split(","), success: false }
  end

end