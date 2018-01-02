Types::ScriptType = GraphQL::ObjectType.define do
  name "ScriptType"

  field :id,          !types.Int
  field :title,       !types.String
  field :description, types.String
  field :body,        !types.String
  field :length,      !types.Int
  field :speech_url, types.String do
    resolve ->(obj, _args, _ctx) { obj.speech&.url }
  end
  field :speech_size, types.Int do
    resolve ->(obj, _args, _ctx) { obj.speech&.size }
  end
  field :created_at, !types.Int do
    resolve ->(obj, _args, _ctx) { obj.created_at.to_i }
  end
  field :updated_at, !types.Int do
    resolve ->(obj, _args, _ctx) { obj.created_at.to_i }
  end
end
