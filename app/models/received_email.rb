class ReceivedEmail < ActiveRecord::Base
  belongs_to :player

  @@keys = YAML.load_file('keys.yml')
  @@gmail = Gmail.connect(@@keys['EMAIL'], @@keys['PASSWORD'])

  def self.check_email
    @@gmail.inbox.all.each do |email|
      # binding.pry
      re = ReceivedEmail.new
      sender = (Player.find_by email: email.message.from)

      if !!sender
        re.update_attribute(:subject, email.subject)
        re.update_attribute(:player_id, sender.id)
        sender.dies if re.contains_dead_words?
        sender.victim.confirm_death if re.contains_victory_words?
      end
      email.delete!
    end
  end

  def contains_dead_words?
    !!(subject.downcase.include?("dead") || subject.downcase.include?("killed") || subject.downcase.include?("quit"))
  end

  def contains_victory_words?
    !!(subject.downcase.include?("victorious") || subject.downcase.include?("win") || subject.downcase.include?("vanquish") || subject.downcase.include?("won"))
  end
end
