class AddCharacterVaryingToUuidCast < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      execute(%(CREATE CAST (character varying AS uuid) WITH INOUT AS IMPLICIT))
    end
  end
end
