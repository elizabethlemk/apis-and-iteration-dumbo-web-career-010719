require 'rest-client'
require 'json'
require 'pry'

def char_films(character_name)
  response_string = RestClient.get("http://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string)
  character_films = []
  response_hash["results"].each do |element|
    if element["name"].downcase == character_name.downcase
      character_films = element["films"]
    end
  end
  character_films
end


def get_character_movies_from_api(character_name)
  film_arr = []
  char_films(character_name).each do |url|
    film_url = RestClient.get(url)
    response_film = JSON.parse(film_url)
    film_arr << {response_film["title"] => response_film}
  end
  film_arr
end

def print_movies(films)
  films.each.with_index do |info, index|
    keysArr = info.keys
    puts "#{index + 1}. #{keysArr[0]}"
  end
end


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
