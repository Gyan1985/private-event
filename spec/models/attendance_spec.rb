# spec/models/attendance_spec.rb
require 'rails_helper'

RSpec.describe Attendance, type: :model do
  describe "Associations" do
    it { should belong_to(:attendee).class_name('User') }
    it { should belong_to(:event) }
  end
end
