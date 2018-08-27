require 'rails_helper'

RSpec.describe "task archiving", type: :system, js: true do
  let(:user) do
    User.create(email: "some@guy.com", password: "password")
  end
  before do
    sign_in(user)
  end
  describe "task detail creation" do
    it "shows a success message" do
      task = user.tasks.create!(description: "Learn Rspec")
      visit task_task_details_path(task)

      fill_in "task_detail_description", with: "I'm a detail!"
      click_button "Create"

      expect(page). to have_text("Task detail successfully created")
    end
  end
end
