defmodule Poutineer.Resolvers.Content do
  def list_accounts(_parent, _args, _resolution) do
    # {:ok, Blog.Content.list_posts()}
    {:ok, []}
  end
end
