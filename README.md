# Weatherise

A simple command line application that shows wheater information
of a region near an US airport(it consumes [this service](http://w1.weather.gov/xml/current_obs/KDTO.xml).

## Installation

  1. Add weatherise to your list of dependencies in `mix.exs`:

        def deps do
          [
            { :weatherise, github: "lucasmedeiros/leite" }
          ]
        end

  2. Ensure weatherise is started before your application:

        def application do
          [ applications: [:weatherise] ]
        end

## Usage

  1. Command line:

        ./weatherise KNYC

  2. On code

        Weatherise.WeatherInfo.fetch("KNYC")

## TODO

Specs for the service consumer.
