require 'rails_helper'

RSpec.describe User, type: :model do
  describe  "ActiveRecord associations" do
    let!(:user) { User.new }
    it { expect(user).to have_db_column(:last_name).of_type(:string) }
    it { expect(user).to have_db_column(:first_name).of_type(:string) }
    it { expect(user).to have_db_column(:first_name_kaka).of_type(:string) }
  end
end
