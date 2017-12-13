require "pry"
require "csv"
require_relative "../lib/joke"

class User
  attr_reader :name,
              :jokes

  def initialize(name)
    @name = name
    @jokes = []
  end

  def learn(joke)
    @jokes << joke
  end

  def tell(user, joke)
    @jokes << joke
    user.learn(joke)
  end

  def perform_routine_for(user, joke = @jokes)
    joke.map do |joke|
      user.learn(joke)
    end
  end

  def learn_routine(file_path)
    jokes = CSV.open file_path, headers: true
    jokes.each do |joke|
      learn(joke)
    end
  end

end
