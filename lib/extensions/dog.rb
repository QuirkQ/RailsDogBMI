require './breedAPI'

class Dog
    attr_reader :name, :age, :weight, :height, :breed
    def initialize(name, age, breed_name, weight, height)
        @name = name
        @age = age
        @weight = weight.to_f
        @height = height.to_f
        @breed = get_breed(breed_name)
    end

    def healthy?
        (underweight? == false) == (overweight? == false)
    end

    def underweight?
        bmi < breed.min_bmi
    end

    def overweight?
        bmi > breed.max_bmi
    end

    def bmi
        weight / height**2
    end

    private 

    def get_breed(breed_name)
        BreedAPI.get_breed(breed_name)
    end
end

BreedAPI.refresh_breeds()
d = Dog.new("John", 5, "Afghan Hound", 24, 66)
binding.pry