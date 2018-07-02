class AlterTypeCharacterVaryingOwnerToSelf < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      execute(%(ALTER TYPE varchar OWNER TO CURRENT_USER))
    end
  end
end
