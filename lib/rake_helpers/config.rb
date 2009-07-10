module MP
  class Config
    include Singleton

    class OptionNotGivenError < RuntimeError; end

    class Option
      attr_reader :attribute, :name, :message, :default

      def initialize(attribute, options, &block)
        @attribute = attribute
        
        @overrides = ENV
        @default = options[:default]
        @name = options.fetch(:name, attribute).to_s
        @message = options.fetch(:message, "Must specify #{attribute} with #{name}=")
        @required = options.fetch(:required, true)
        
        @parser = block
        
        @attribute, @name, @message = attribute, name, message
      end

      def default
        @default.is_a?(Proc) ? @default.call : @default
      end

      def write(value)
        @value = value
      end

      def fetch(local_default)
        value = fetch_from(@overrides) || @value || local_default || default
        @parser ? @parser.call(value) : value
      end

      def read(*args)
        required = args.empty? ? @required : args[0]
        value = fetch(nil)
        
        raise OptionNotGivenError.new(message) if value.nil? && required
        
        value
      end

      private
      def name_variants
        key = name.to_s

        # for ENV vars we need the upcase, in general we want to allow case-insensitive access for simplicity
        [key, key.upcase, key.downcase]
      end

      def fetch_from(hash)
        # lookup each variant of the key
        all_possible_values = hash.values_at(*name_variants)
        # grab the first non-nil value out of the possible values
        all_possible_values.compact[0]
      end
    end

    def self.configure
      yield instance
    end

    def initialize
      @attributes = {}
    end

    def add(attribute, options={}, &block)
      option = Option.new(attribute, options, &block)
      
      @attributes[option.name] = option
      
      self.class.class_eval do
        define_method("#{option.attribute}=") do |value|
          write(option.name, value)
        end
        
        define_method(option.attribute) do |*args|
          read(option.name)
        end
      end
    end

    def write(attribute, value)
      @attributes[attribute].write(value)
    end

    def fetch(attribute, default=nil)
      @attributes[attribute].fetch(default)
    end

    def read(attribute, *args)
      @attributes[attribute].read(*args)
    end

    def [](key)
      fetch(key)
    end

    def expose_as_method
      method_name = underscore(self.class.name)
      config_class = self
      Object.class_eval do
        define_method(method_name) do
          config_class
        end
      end
    end

    # The reverse of +camelize+. Makes an underscored, lowercase form from the expression in the string.
    #
    # Changes '::' to '/' to convert namespaces to paths.
    #
    # Examples:
    #   "ActiveRecord".underscore         # => "active_record"
    #   "ActiveRecord::Errors".underscore # => active_record/errors
    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end
  end
end