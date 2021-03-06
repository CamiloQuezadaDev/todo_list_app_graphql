module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :full_name, String, null: true
    field :username, String, null: true
    field :email, String, null: true
    field :tasks, [Types::TaskType], null: true
  end
end
