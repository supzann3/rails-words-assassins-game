class Player < ActiveRecord::Base
  has_many :game_players
  has_one :game, through: :game_players
  has_many :received_emails

  def dies
    victim.assign_word
    Email.new.reassigning_email(assassin.email, victim.word, victim.name)
    Email.new.dead_email(self.email, assassin.name)
    self.update_attribute(:alive?, false)
    assassin.increase_kills
    reassign_victim_upon_successful_assassination
    self.game.announce_winner if winner?
  end

  def increase_kills
    assassin.update_attribute(:kills, assassin.kills + 1)
  end

  def victim
    Player.find_by id: victim_id
  end

  def assassin
    Player.find_by victim_id: id
  end

  def assign_word
   update_attribute(:word, Word.word_list.sample)
  end

  def reassign_victim_upon_successful_assassination
    assassin.update_attribute(:victim_id, self.victim_id)
    self.update_attribute(:victim_id, nil)
  end

  def starting_conditions
    self.update_attribute(:alive?, true)
    self.update_attribute(:kills, 0)
    self.assign_word
  end

  def confirm_death
    Email.new.confirmation_of_death_email(email, assassin.name, word)
  end

end
