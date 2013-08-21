require 'spec_helper'

describe "games/new" do
  before(:each) do
    assign(:game, stub_model(Game,
      :current_player_id => 1,
      :other_player_id => 1
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", games_path, "post" do
      assert_select "input#game_current_player_id[name=?]", "game[current_player_id]"
      assert_select "input#game_other_player_id[name=?]", "game[other_player_id]"
    end
  end
end
