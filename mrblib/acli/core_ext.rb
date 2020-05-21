# frozen_string_literal: true

# Generated by Ruby Next v0.8.0 using the following command:
#
#   ruby-next core_ext --name=deconstruct --name=patternerror -o mrblib/acli/core_ext.rb
#

class Array
  def deconstruct
    self
  end
end

class Hash
  def deconstruct_keys(_)
    self
  end
end

class Object
  class NoMatchingPatternError < RuntimeError
  end
end

class Struct
  alias deconstruct to_a

  def deconstruct_keys(keys)
    raise TypeError, "wrong argument type #{keys.class} (expected Array or nil)" if keys && !keys.is_a?(Array)

    return to_h unless keys

    keys.each_with_object({}) do |k, acc|
      # if k is Symbol and not a member of a Struct return {}
      next if (Symbol === k || String === k) && !members.include?(k.to_sym)
      # if k is Integer check that index is not ouf of bounds
      next if Integer === k && k > size - 1
      acc[k] = self[k]
    end
  end
end
