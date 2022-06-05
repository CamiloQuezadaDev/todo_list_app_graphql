module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :state, String, null: true
    field :slug, String, null: true
    field :user, Types::UserType, null: true
  end
end
