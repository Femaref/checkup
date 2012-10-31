# encoding: utf-8

module Backup
  module Logger
    class << self
      ##
      # Invokes the #colorize method with the provided string
      # and the color code "32" (for green)
      def green(string)
        colorize(string, 32)
      end

      ##
      # Invokes the #colorize method with the provided string
      # and the color code "33" (for yellow)
      def yellow(string)
        colorize(string, 33)
      end

      ##
      # Invokes the #colorize method the with provided string
      # and the color code "31" (for red)
      def red(string)
        colorize(string, 31)
      end

      ##
      # Wraps the provided string in colorizing tags to provide
      # easier to view output to the client
      def colorize(string, code)
        "\e[#{code}m#{string}\e[0m"
      end
    end
  end
end