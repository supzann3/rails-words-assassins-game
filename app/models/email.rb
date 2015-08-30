require 'gmail'
require 'net/imap'
class Email #<<ActiveRecord::Base # not sure if we should create a table for email
# belongs_to :player

  attr_reader :gmail

   def initialize
     @keys = YAML.load_file('keys.yml')
     @gmail = Gmail.connect(@keys['EMAIL'], @keys['PASSWORD'])
     @file = File.read("lib/assets/email-template.html.erb")
   end

   def deliver_gmail(recipient, subject, body)
     @gmail.deliver do
       # binding.pry
       to "#{recipient}"
       subject "#{subject}"
       html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>#{body}</p>" # add html part
      end
       # add_file "/path/to/some_image.jpg" add image
     end
   end

 def initial_email(player_email,word,victim) #comes from Player
     recipient = player_email
     subject = "Your secret mission."
     @body = "You have been assigned to kill #{victim}. \n You can accomplish this by getting your victim to say the word #{word}"
     html=ERB.new(@file).result(binding)
     deliver_gmail(recipient, subject, html)
     puts "Sent e-mail to #{player_email}."
 end

 def reassigning_email(player_email,word,victim) #comes from Player

   recipient = player_email
   subject = "Your new victim"
   @body = "You have a new victim to kill #{victim}. \n You can accomplish this by getting your victim to say the word #{word}"
   html=ERB.new(@file).result(binding)
   deliver_gmail(recipient, subject, html)
   puts "Sent e-mail to #{player_email}."

 end

 def dead_email(player_email,killer_name) #comes from Player
   recipient = player_email
   subject = "You have been killed"
   @body = "You have been killed by #{killer_name}, better luck next time. \n Thank you for playing !"
   html=ERB.new(@file).result(binding)
   deliver_gmail(recipient, subject, html)
   puts "Sent e-mail to #{player_email}."
 end

 def winner_email(player_email,winner_name) #comes from Player
   recipient = player_email
   subject = "The winner has been announced"
   @body = "The winner of the game is #{winner_name}"
   html=ERB.new(@file).result(binding)
   deliver_gmail(recipient, subject, html)
   puts "Sent e-mail to #{player_email}."
 end

 def confirmation_of_death_email(player_email, assassin, word) #comes from Player
   recipient = player_email
   subject = "We are sorry to hear about your passing."
   @body = "#{assassin} claims that he or she killed you by getting you to say the word '#{word.upcase}'.  Our condolences.  Please confirm this by replying to this e-mail.  Make sure you include the word 'dead' in the subject line."
   html=ERB.new(@file).result(binding)
   deliver_gmail(recipient, subject, html)
 end

end
