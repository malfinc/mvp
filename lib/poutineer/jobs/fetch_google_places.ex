defmodule Poutineer.Jobs.FetchGooglePlaces do
  use Oban.Worker, queue: :google_places

  @impl Oban.Worker
  def perform(%{"id" => id}, _job) do
    record = Poutineer.Database.Repo.get(Poutineer.Models.Establishment, id)

    GoogleMaps.place_details(record.google_place_id)
      |> case do
        {:ok, place} -> record |> Ecto.Changeset.change(google_place_data: place) |> Poutineer.Database.Repo.update()
        {:error, exception, reason} -> {:error, {exception, reason}}
      end
  end
end
