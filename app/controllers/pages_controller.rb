class PagesController < ApplicationController
    def home
        @breeds = BreedAPI.breeds.collect { |b| b.name }
    end
end
