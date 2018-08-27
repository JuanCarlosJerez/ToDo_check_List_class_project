require "rails_helper"

RSpec.describe "task display", type: :system, js: true do
  let(:user) do
    User.create(email: "some@guy.com", password: "password")
  end
  context "when the task is due yesterday" do
    it "displays red" do
      user.tasks.create(description: "yesterday", due_date: Date.yesterday)

      sign_in(user)
      visit tasks_path

      color = find('.due_date').native.css_value('background-color')
      expect(color).to eq('rgba(220, 53, 69, 1)')
    end
  end
  context "when the task is due today" do
    it "displays yellow" do
      user.tasks.create(description: "today", due_date: Date.today)

      sign_in(user)
      visit tasks_path

      color = find('.due_date').native.css_value('background-color')
      expect(color).to eq('rgba(255, 193, 7, 1)')
    end
  end
  context "when the task is due yesterday" do
    it "displays green" do
      user.tasks.create(description: "four days from now", due_date: 4.days.from_now.to_date)

      sign_in(user)
      visit tasks_path

      color = find('.due_date').native.css_value('background-color')
      expect(color).to eq('rgba(40, 167, 69, 1)')
    end
  end
end
