require 'uri'
require 'net/http'
require 'json'
require './app/services/breed'
require "erb"
include ERB::Util

class BreedAPI
    @@breeds = Array.new()
    def self.refresh_breeds
        # array: [Breed, Breed, Breed, ....]
        if (raw_breeds = self.int_get_breeds)
            breeds_hash = JSON.parse(raw_breeds, :symbolize_names => true)
        end

        @@breeds = Array.new()

        breeds_hash.each do |breed_hash|
            @@breeds << Breed.new(breed_hash)
        end
        
        @@breeds
    end

    def self.breeds
        # array: [Breed, Breed, Breed, ....]
        if @@breeds.empty?
            self.refresh_breeds()
        end
        @@breeds
    end

    def self.get_breed(breed_name)
        # Breed 
        int_get_breed(breed_name)
    end

    def self.register_breed(breed)
        @@breeds << breed
    end

    private

    def self.int_get_breeds
        uri = URI('https://api.thedogapi.com/v1/breeds')
        params = { api_key: ENV['DOG_API_KEY'] }
        uri.query = URI.encode_www_form(params)

        res = Net::HTTP.get_response(uri)
        res.body if res.is_a?(Net::HTTPSuccess)
    end

    def self.int_get_breed(breed_name)
        # Breed
        if @@breeds.empty?
            uri = URI('https://api.thedogapi.com/v1/breeds/')
            params = { 
                api_key: ENV['DOG_API_KEY'],
                search: breed_name
            }
            uri.query = URI.encode_www_form(params)

            res = Net::HTTP.get_response(uri)
            respons_body = res.body if res.is_a?(Net::HTTPSuccess)
            breed_hash = JSON.parse(respons_body, :symbolize_names => true)
            return Breed.new(breed_hash)
        else
            @@breeds.each do |breed|
                if breed.name == breed_name
                    return breed
                end
            end
        end
        nil
    end
end