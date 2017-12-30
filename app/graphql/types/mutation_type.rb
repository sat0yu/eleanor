Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createScript, Mutations::CreateScriptMutation.field
end
