class Breed
    attr_reader :name, :bred_for, :breed_group, :origin 
    def initialize(hash)
        # initialize with Hash_table containing Dog Properties
        @name = hash[:name]
        @bred_for = hash[:bred_for]
        @breed_group = hash[:breed_group]
        @life_span = hash[:life_span]
        @temperament = hash[:temperament]
        @origin = hash[:origin]
        @weight = hash[:weight]
        @height = hash[:height]
        @measuring_unit = :metric
    end

    def temperament
        # array: [temperament, temperament, temperament, .....]
        int_temperament
    end

    def life_span
        # array: [at_least_age, at_max_age]
        int_life_span
    end

    def min_bmi
        # float: minimal BMI
        min_weight / min_height**2
    end

    def max_bmi
        # float: maximum BMI
        max_weight / min_height**2
    end

    def max_weight
        # int: max_weight
        min_max_weight.last
    end

    def min_weight
        # int: min_weight
        min_max_weight.first
    end

    def max_height
        # int: max_height
        min_max_height.last
    end

    def min_height
        # int: min_height
        min_max_height.first
    end

    def debug
        binding.pry
    end

    def set_measuring_unit(unit)
        # TODO
    end

    private

    def int_temperament
        # array: [temperament, temperament, temperament, .....]
        temperaments = Array.new()
        @temperament.split(', ').each do |str|
            temperaments.push(str)
        end
        temperaments
    end

    def min_max_weight
        # array: [min_weight, max_weight]
        weights = Array.new()
        @weight[@measuring_unit].split('-').each do |str|
            weights.push(str.strip.to_f)
        end
        weights
    end

    def min_max_height
        # array: [min_height, max_height]
        heights = Array.new()
        @height[@measuring_unit].split('-').each do |str|
            heights.push(str.strip.to_f)
        end
        heights
    end

    def int_life_span
        # array: [at_least_age, at_max_age]
        life_spans = Array.new()
        @life_span.split(' ').each do |str|
            if str !~ /\D/
                life_spans.push(str.to_i)
            end
        end
        life_spans
    end
end