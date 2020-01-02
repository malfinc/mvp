defmodule Estate do
  defmacro state_machines(machines) do
    Enum.flat_map(machines, fn ({column_name, events}) ->
      Enum.flat_map(events, fn ({event_name, transitions}) ->
        Enum.map(transitions, fn ({from, to}) ->
          quote do
            # IO.inspect("Defining #{__MODULE__}.#{unquote(:"before_#{event_name}")}(record)")
            @desc "Called before #{unquote(event_name)}, with the changeset"
            def unquote(:"before_#{event_name}_from_#{from}")(
              %Ecto.Changeset{
                data: %{unquote(column_name) => unquote(Atom.to_string(from))}
              } = changeset) do
              changeset
            end

            # IO.inspect("Defining #{__MODULE__}.#{unquote(:"after_#{event_name}")}(record)")
            @desc "Called after #{unquote(event_name)}, with the changset"
            def unquote(:"after_#{event_name}_from_#{from}")(
              %Ecto.Changeset{
                changes: %{unquote(column_name) => unquote(to)},
                data: %{unquote(column_name) => unquote(Atom.to_string(from))}
              } = changeset) do
              changeset
            end

            # IO.inspect("Defining #{__MODULE__}.#{unquote(:"after_#{event_name}")}(record)")
            @desc "Called after #{unquote(event_name)}!, with the saved record"
            def unquote(:"after_#{event_name}_from_#{from}")(
              {
                :ok,
                %{
                  unquote(column_name) => unquote(to)
                } = record
              }) do
              {:ok, record}
            end

            # IO.inspect("Defining #{__MODULE__}.#{unquote(event_name)}(%{#{unquote(column_name)} => #{unquote(Atom.to_string(from))}} = record)")
            @desc "An action to change the state, if the transition matches, but doesn't save"
            def unquote(event_name)(%{unquote(column_name) => unquote(Atom.to_string(from))} = record) do
              record
                |> Ecto.Changeset.change()
                |> unquote(:"before_#{event_name}_from_#{from}")()
                |> Ecto.Changeset.cast(%{unquote(column_name) => unquote(to)}, [unquote(column_name)])
                |> Ecto.Changeset.validate_required(unquote(column_name))
                |> unquote(:"after_#{event_name}_from_#{from}")()
            end

            # IO.inspect("Defining #{__MODULE__}.#{unquote(event_name)}!(%{:id => id, #{unquote(column_name)} => #{unquote(Atom.to_string(from))}} = record) when not is_nil(id)")
            @desc "An action to change the state, if the transition matches, but does save"
            def unquote(:"#{event_name}!")(%{:id => id, unquote(column_name) => unquote(Atom.to_string(from))} = record) when not is_nil(id) do
              record
                |> Ecto.Changeset.change()
                |> unquote(:"before_#{event_name}_from_#{from}")()
                |> Ecto.Changeset.cast(%{unquote(column_name) => unquote(to)}, [unquote(column_name)])
                |> Ecto.Changeset.validate_required(unquote(column_name))
                |> Poutineer.Repo.update()
                |> unquote(:"after_#{event_name}_from_#{from}")()
            end

            # If you can't match, then raise transition failure
          end
        end)
      end)
    end)
  end
end
