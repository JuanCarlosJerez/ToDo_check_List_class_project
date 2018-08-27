require "rails_helper"

RSpec.describe "task deletion", type: :system, js: true do
  it "displays a success message" do
    user = User.create(email: "some@guy.com", password: "password")
    user.tasks.create(description: "Learn Rspec", due_date: Date.tomorrow)

    sign_in(user)
    visit tasks_path
    accept_confirm do
      click_link "Destroy"
    end

    expect(page).to have_text("Task was successfully destroyed")
  end
end
