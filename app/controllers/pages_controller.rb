class PagesController < ApplicationController
    def home
        arr = BreedAPI.breeds
        puts arr
    end
end
