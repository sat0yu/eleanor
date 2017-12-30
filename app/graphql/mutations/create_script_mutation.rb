Mutations::CreateScriptMutation = GraphQL::Relay::Mutation.define do
  name "CreateScript"

  input_field :scriptInput, !Types::ScriptInputType

  return_field :script, !Types::ScriptType

  resolve ->(_obj, inputs, _ctx) {
    script = Script.create!(
      title: inputs.scriptInput.title,
      body:  inputs.scriptInput.body
    )

    { script: script }
  }
end
