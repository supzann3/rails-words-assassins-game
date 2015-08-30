class Game < ActiveRecord::Base
  belongs_to :game_player
  has_many :games, through: :game_players

  def start(params)
    names=params["player"]["name"]
    emails=params["player"]["email"]
    names.zip(emails).each do |player|
      x = Player.create({name: player[0], email: player[1]})
      GamePlayer.create({player_id: x.id, game_id: self.id})
    end
    initial_victim_id_assignment
  end

  def initial_victim_id_assignment
    players_offset = self.players.unshift(players[-1])[0..-2]
    Hash[self.players.zip(players_offset)].each do |assassin, victim|
      assassin.update_attribute(victim_id: victim.id)
    end
  end

  def winner?
    !!(players.where(alive?: true).size == 1)
  end

  def announce_winner
    winner = players.find_by(alive?: true).name
    players.all.each do |player|
      Email.new.winner_email(player.email, winner)
    end
  end

  def self.first_email
    players.each do |player|
      Email.new.initial_email(player.email, player.victim.word, player.victim.name)
    end
  end

  def assign_words
    player.each do |player|
      assign_word
    end
  end

end
