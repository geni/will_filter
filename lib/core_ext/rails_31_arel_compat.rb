# Monkey patches for Rails 3.1.x compatibility with will_paginate and Arel
# Rails 3.1 uses Arel 2.2.x which has issues with Integer limit values
#
# This fixes the "Cannot visit Integer" error when using will_paginate

if defined?(Arel::VERSION) && Arel::VERSION =~ /^2\.2\./
  # Patch Arel to handle Integer limit and offset values
  module Arel
    module Nodes
      class Limit
        attr_accessor :expr
        alias :value :expr

        def initialize(expr)
          @expr = expr.is_a?(Integer) || expr.is_a?(String) ? expr : expr
        end
      end

      class Offset
        attr_accessor :expr
        alias :value :expr

        def initialize(expr)
          @expr = expr.is_a?(Integer) || expr.is_a?(String) ? expr : expr
        end
      end
    end

    module Visitors
      class ToSql
        alias_method :visit_Arel_Nodes_Limit_original, :visit_Arel_Nodes_Limit

        def visit_Arel_Nodes_Limit(o, *a)
          # Convert Integer to String for Arel
          if o.expr.is_a?(Integer) || o.expr.is_a?(Fixnum)
            o.expr = o.expr.to_s
          end
          visit_Arel_Nodes_Limit_original(o, *a)
        end

        alias_method :visit_Arel_Nodes_Offset_original, :visit_Arel_Nodes_Offset

        def visit_Arel_Nodes_Offset(o, *a)
          # Convert Integer to String for Arel
          if o.expr.is_a?(Integer) || o.expr.is_a?(Fixnum)
            o.expr = o.expr.to_s
          end
          visit_Arel_Nodes_Offset_original(o, *a)
        end
      end
    end
  end
end
