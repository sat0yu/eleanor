Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createScript, !Types::ScriptType do
    argument :script, !Types::ScriptInputType

    resolve ->(_obj, args, _ctx) {
      Script.create!(title: args[:script][:title], body: args[:script][:body])
    }
  end
end
