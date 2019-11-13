class QueryType < BaseObjectType
  field(:version, String, :null => false)

  def version
    Poutineer::Application::VERSION
  end
end
