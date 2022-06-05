module Types
  class MutationType < Types::BaseObject
    field :task_update, mutation: Mutations::TaskUpdate
    field :task_create, mutation: Mutations::TaskCreate
    field :user_sign_in, mutation: Mutations::UserSignIn
    field :user_sign_up, mutation: Mutations::UserSignUp
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
