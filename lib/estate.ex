defmodule Estate do
  defmacro machine(machines) do
    Enum.flat_map(machines, fn ({column_name, events}) ->
      Enum.flat_map(events, fn ({event_name, transitions}) ->
        Enum.map(transitions, fn ({from, to}) ->
          quote do
            @desc "A before hook"
            def unquote(:"before_#{event_name}")(%Ecto.Changeset{} = record) do
              record
            end

            @desc "An after hook"
            def unquote(:"after_#{event_name}")(%{} = record) do
              record
            end

            @desc "An action to change the state, if the transition matches, but doesn't save"
            def unquote(event_name)(%{unquote(column_name) => unquote(Atom.to_string(from))} = record) do
              record
                |> Ecto.Changeset.change()
                |> unquote(:"before_#{event_name}")()
                |> Ecto.Changeset.cast(%{unquote(column_name) => unquote(to)}, [unquote(column_name)])
                |> Ecto.Changeset.validate_required(unquote(column_name))
                |> unquote(:"after_#{event_name}")()
            end

            @desc "An action to change the state, if the transition matches, but does save"
            def unquote(:"#{event_name}!")(%{:id => id, unquote(column_name) => unquote(Atom.to_string(from))} = record) when not is_nil(id) do
              record
                |> Ecto.Changeset.change()
                |> unquote(:"before_#{event_name}")()
                |> Ecto.Changeset.cast(%{unquote(column_name) => unquote(to)}, [unquote(column_name)])
                |> Ecto.Changeset.validate_required(unquote(column_name))
                |> Poutineer.Repo.update()
                |> unquote(:"after_#{event_name}")()
            end

            # If you can't match, then raise transition failure
          end
        end)
      end)
    end)
  end
end
