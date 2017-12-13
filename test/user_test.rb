require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/user'
require "pry"

class UserTest < Minitest::Test
  def test_it_exists
    sal = User.new("Sal")

    assert_instance_of User, sal
  end

  def test_it_has_a_name
    sal = User.new("Sal")

    assert_equal "Sal", sal.name
  end

  def test_it_can_have_another_name
    ali = User.new("Ali")

    assert_equal "Ali", ali.name
  end

  def test_jokes_returns_an_empty_array
    sal = User.new("Sal")

    assert_instance_of Array, sal.jokes
    assert_equal [], sal.jokes
  end

  def test_sal_can_be_funny
    sal = User.new("Sal")
    joke = Joke.new({id: 1, question: "Why did the strawberry cross the road?", answer: "Because his mother was in a jam."})

    sal.learn(joke)
    assert_instance_of Array, sal.jokes
    assert_instance_of Joke, sal.jokes.first
  end

  def test_sal_can_be_funny_around_other_people
    ali = User.new("Ali")
    sal = User.new("Sal")
    joke = Joke.new({id: 1, question: "Why did the strawberry cross the road?", answer: "Because his mother was in a jam."})

    sal.tell(ali, joke)
    assert_instance_of Array, ali.jokes
    assert_instance_of Joke, ali.jokes.first
    assert_equal 1, ali.jokes.count
  end

  def test_ilana_can_do_standup_for_josh
    joke_1 = Joke.new({id: 1, question: "Why did the strawberry cross the road?", answer: "Because his mother was in a jam."})
    joke_2 = Joke.new({id: 2, question: "How do you keep a lion from charging?", answer: "Take away its credit cards."})
    ilana = User.new("Ilana")
    josh = User.new("Josh")

    ilana.learn(joke_1)
    ilana.learn(joke_2)
    ilana.perform_routine_for(josh)

    assert_instance_of Array, josh.jokes
    assert_instance_of Joke, josh.jokes.first
    assert_equal 2, josh.jokes.count
  end

  def test_casey_can_be_the_funniest_motherfucker
    casey = User.new("Casey")

    casey.learn_routine("./jokes.csv")
    assert_equal 100, casey.jokes.count
  end
end
