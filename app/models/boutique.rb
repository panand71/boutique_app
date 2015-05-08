require 'csv'
class Boutique < ActiveRecord::Base
  belongs_to :owner
  validates :owner_id, presence: true

    def self.import(file)
    CSV.foreach(file.path, headers: true, :encoding => 'ISO-8859-1') do |row|
      boutique_hash = row.to_hash
      boutique = Boutique.where(id: boutique_hash["id"])
      if boutique.count == 1
        boutique.first.update_attributes(boutique_hash)
      else
        Boutique.create! (boutique_hash)
      end
    end
  end
end
