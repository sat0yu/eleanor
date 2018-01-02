Types::ScriptInputType = GraphQL::InputObjectType.define do
  name "ScriptInputType"

  argument :title, !types.String do
    description 'non-null and lass than 1KB'
  end

  argument :description, types.String do
    description 'lass than 128KB'
  end

  argument :body,  !types.String do
    description 'non-null and lass than 4KB'
  end
end
