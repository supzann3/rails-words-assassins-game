class Game < ActiveRecord::Base
  has_many :game_players
  has_many :players, through: :game_players

  def start(params)
    names=params["player"]["name"]
    emails=params["player"]["email"]
    names.zip(emails).each do |player|
      x = Player.create({name: player[0], email: player[1]})
      GamePlayer.create({player_id: x.id, game_id: self.id})
      x.starting_conditions
    end
    initial_victim_id_assignment
  end

  def initial_victim_id_assignment
    scramble = players.shuffle
    players_offset = scramble.unshift(players[-1])[0..-2]
    Hash[scramble.zip(players_offset)].each do |assassin, victim|
      assassin.update_attribute(:victim_id, victim.id)
    end
  end

  def winner?
    !!(players.where(alive?: true).size == 1)
  end

  def announce_winner
    winner = players.find_by(alive?: true).name
    players.each {|player| Email.new.winner_email(player.email, winner)}
  end

  def first_email
    players.each do |player|
      Email.new.initial_email(player.email, player.victim.word, player.victim.name)
    end
  end

  def assign_words
    players.each { |player| player.assign_word }
  end
end
