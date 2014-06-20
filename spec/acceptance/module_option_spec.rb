require 'spec_helper'

describe "module option" do
  context 'on factory' do
    before do
      define_class("SomeEngine")
      define_model("SomeEngine::User", admin: :boolean)

      FactoryGirl.define do
        factory(:user, module: SomeEngine)

        factory(:admin, parent: :user) do
          admin true
        end
      end
    end

    it 'looks up class in given module' do
      expect(FactoryGirl.build(:user)).to be_kind_of(SomeEngine::User)
      expect(FactoryGirl.build(:admin)).to be_kind_of(SomeEngine::User)
    end
  end

  context 'on define' do
    before do
      define_class("SomeEngine")
      define_model("SomeEngine::User", admin: :boolean)

      FactoryGirl.define module: SomeEngine do
        factory :user

        factory(:admin, parent: :user) do
          admin true
        end
      end
    end

    it 'looks up class in given module' do
      expect(FactoryGirl.build(:user)).to be_kind_of(SomeEngine::User)
      expect(FactoryGirl.build(:admin)).to be_kind_of(SomeEngine::User)
    end
  end
end
