require 'spec_helper'

describe 'ActiveRecord enums' do
  include FactoryGirl::Syntax::Methods

  it 'works' do
    if defined?(ActiveRecord::Enum)
      define_model 'Dossier' do
        has_many :items
      end

      define_model 'Item', item_type: :integer, dossier_id: :integer do
        enum item_type: %w(file link)
        belongs_to :dossier
      end

      FactoryGirl.define do
        factory :item do
          item_type { Item.item_types.keys.sample }
        end

        factory :dossier
      end

      dossier = create(:dossier)
      dossier.items << create(:item)
      expect(%w(file link)).to include dossier.items.last.item_type
    else
      pending 'ActiveRecord::Enum is not defined'
    end
  end
end
