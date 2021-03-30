require "application_system_test_case"

class PlayerRunsNotifiersTest < ApplicationSystemTestCase
  setup do
    @player_runs_notifier = player_runs_notifiers(:one)
  end

  test "visiting the index" do
    visit player_runs_notifiers_url
    assert_selector "h1", text: "Player Runs Notifiers"
  end

  test "creating a Player runs notifier" do
    visit player_runs_notifiers_url
    click_on "New Player Runs Notifier"

    fill_in "Runs", with: @player_runs_notifier.runs
    fill_in "Team squad member", with: @player_runs_notifier.team_squad_member_id
    fill_in "User", with: @player_runs_notifier.user_id
    click_on "Create Player runs notifier"

    assert_text "Player runs notifier was successfully created"
    click_on "Back"
  end

  test "updating a Player runs notifier" do
    visit player_runs_notifiers_url
    click_on "Edit", match: :first

    fill_in "Runs", with: @player_runs_notifier.runs
    fill_in "Team squad member", with: @player_runs_notifier.team_squad_member_id
    fill_in "User", with: @player_runs_notifier.user_id
    click_on "Update Player runs notifier"

    assert_text "Player runs notifier was successfully updated"
    click_on "Back"
  end

  test "destroying a Player runs notifier" do
    visit player_runs_notifiers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Player runs notifier was successfully destroyed"
  end
end
