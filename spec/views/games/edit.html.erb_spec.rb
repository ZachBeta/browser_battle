require 'spec_helper'

describe "games/edit" do
  before(:each) do
    @game = assign(:game, stub_model(Game,
      :current_player_id => 1,
      :other_player_id => 1
    ))
  end

  it "renders the edit game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", game_path(@game), "post" do
      assert_select "input#game_current_player_id[name=?]", "game[current_player_id]"
      assert_select "input#game_other_player_id[name=?]", "game[other_player_id]"
    end
  end
end
