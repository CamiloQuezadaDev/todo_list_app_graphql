module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :me, Types::UserType, null: true

    def me
      context[:current_user]
    end
    
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :tasks, [Types::TaskType], null: true do
      argument :search, String, required: false
    end

    def tasks search:nil
      return context[:current_user]&.tasks(search: search)
    end
  end
end
