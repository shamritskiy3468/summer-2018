require File.expand_path(File.dirname(__FILE__) + '/neo')

# This is class
class AboutModules < Neo::Koan
  # This is module
  module Nameable
    # rubocop:disable Naming/AccessorMethodName
    def set_name(new_name)
      @name = new_name
    end
    # rubocop:enable Naming/AccessorMethodName

    def here
      :in_module
    end
  end

  def test_cant_instantiate_modules
    assert_raise(NoMethodError) do
      Nameable.new
    end
  end

  # ------------------------------------------------------------------
  # This is class
  class Dog
    include Nameable

    attr_reader :name

    def initialize
      @name = 'Fido'
    end

    def bark
      'WOOF'
    end

    def here
      :in_object
    end
  end

  def test_normal_methods_are_available_in_the_object
    fido = Dog.new
    assert_equal 'WOOF', fido.bark
  end

  def test_module_methods_are_also_available_in_the_object
    fido = Dog.new
    assert_nothing_raised do
      fido.set_name('Rover')
    end
  end

  # This method smells of :reek:FeatureEnvy
  def test_module_methods_can_affect_instance_variables_in_the_object
    fido = Dog.new
    assert_equal 'Fido', fido.name
    fido.set_name('Rover')
    assert_equal 'Rover', fido.name
  end

  def test_classes_can_override_module_methods
    fido = Dog.new
    assert_equal :in_object, fido.here
  end
end
