Mutations::CreateScriptMutation = GraphQL::Relay::Mutation.define do
  name "CreateScript"

  input_field :scriptInput, !Types::ScriptInputType

  return_field :script, !Types::ScriptType

  resolve ->(_obj, inputs, _ctx) {
    script = Script.create!(
      title:       inputs.scriptInput.title,
      description: inputs.scriptInput.description,
      body:        inputs.scriptInput.body
    )
    CreateSpeechWorker.perform_async(script.reload.id)

    { script: script }
  }
end
