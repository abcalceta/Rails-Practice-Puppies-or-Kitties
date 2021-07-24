class ApplicationController < ActionController::Base

  helper_method :get_inspiring_message, :generate_flavor_text

  def get_inspiring_message
    url = 'https://www.affirmations.dev'
    response = HTTParty.get(url).parsed_response
    affirmation = response["affirmation"]
    return affirmation
  end

  def generate_flavor_text(animal)
    kitten_phrases = ["I'm a cat person!", "Meow, mow, mow", "Purrfect"]
    puppy_phrases = ["I'm a dog person!", "Arf, arf, woof", "Awoooo"]
    text = ""
    if animal == "kitten"
      text = kitten_phrases.sample
    else
      text = puppy_phrases.sample
    end
    return text
  end


end
