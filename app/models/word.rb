class Word
  def self.word_list
    f = File.read('lib/assets/words.yml')
    YAML.load(f)
  end
end
