require 'test_helper'

class PlayerRunsNotifiersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_runs_notifier = player_runs_notifiers(:one)
  end

  test "should get index" do
    get player_runs_notifiers_url
    assert_response :success
  end

  test "should get new" do
    get new_player_runs_notifier_url
    assert_response :success
  end

  test "should create player_runs_notifier" do
    assert_difference('PlayerRunsNotifier.count') do
      post player_runs_notifiers_url, params: { player_runs_notifier: { runs: @player_runs_notifier.runs, team_squad_member_id: @player_runs_notifier.team_squad_member_id, user_id: @player_runs_notifier.user_id } }
    end

    assert_redirected_to player_runs_notifier_url(PlayerRunsNotifier.last)
  end

  test "should show player_runs_notifier" do
    get player_runs_notifier_url(@player_runs_notifier)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_runs_notifier_url(@player_runs_notifier)
    assert_response :success
  end

  test "should update player_runs_notifier" do
    patch player_runs_notifier_url(@player_runs_notifier), params: { player_runs_notifier: { runs: @player_runs_notifier.runs, team_squad_member_id: @player_runs_notifier.team_squad_member_id, user_id: @player_runs_notifier.user_id } }
    assert_redirected_to player_runs_notifier_url(@player_runs_notifier)
  end

  test "should destroy player_runs_notifier" do
    assert_difference('PlayerRunsNotifier.count', -1) do
      delete player_runs_notifier_url(@player_runs_notifier)
    end

    assert_redirected_to player_runs_notifiers_url
  end
end
