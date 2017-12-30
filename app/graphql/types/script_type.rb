Types::ScriptType = GraphQL::ObjectType.define do
  name "ScriptType"

  field :id,    !types.Int
  field :title, !types.String
  field :body,  !types.String
  field :created_at, !types.Int do
    resolve ->(obj, _args, _ctx) { obj.created_at.to_i }
  end
  field :updated_at, !types.Int do
    resolve ->(obj, _args, _ctx) { obj.created_at.to_i }
  end
end
