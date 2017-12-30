Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :allScript, !types[Types::ScriptType] do
    resolve -> (_obj, _args, _ctx) { Script.all }
  end

  field :script, !Types::ScriptType do
    argument :id, !types.Int
    resolve -> (_obj, args, _ctx) {
      Script.find(args[:id])
    }
  end
end
