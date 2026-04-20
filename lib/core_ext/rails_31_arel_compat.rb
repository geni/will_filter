# Monkey patches for Rails 3.1.x and 3.2.x compatibility with will_paginate and Arel on Ruby 2.7+
# Rails 3.1 uses Arel 2.2.x, Rails 3.2 uses Arel 3.0.x
# Both have issues with Integer limit values from will_paginate
#
# This fixes the "Cannot visit Integer" error when using will_paginate
# Note: These patches are needed for Ruby 2.7+ compatibility

require 'next_rails'

if NextRails.next?
  # Rails 3.2 / Arel 3.0
  if defined?(Arel::VERSION) && Arel::VERSION =~ /^3\.0\./
    module Arel
      module Visitors
        class ToSql
          alias_method :visit_Arel_Nodes_Limit_without_integer_compat, :visit_Arel_Nodes_Limit

          def visit_Arel_Nodes_Limit(o, *a)
            # If the limit expression is a raw integer, wrap it in a SqlLiteral
            if o.expr.is_a?(Integer)
              o = o.class.new(Arel::Nodes::SqlLiteral.new(o.expr.to_s))
            end
            visit_Arel_Nodes_Limit_without_integer_compat(o, *a)
          end

          alias_method :visit_Arel_Nodes_Offset_without_integer_compat, :visit_Arel_Nodes_Offset

          def visit_Arel_Nodes_Offset(o, *a)
            # If the offset expression is a raw integer, wrap it in a SqlLiteral
            if o.expr.is_a?(Integer)
              o = o.class.new(Arel::Nodes::SqlLiteral.new(o.expr.to_s))
            end
            visit_Arel_Nodes_Offset_without_integer_compat(o, *a)
          end
        end
      end
    end
  end
else
  # Rails 3.1 / Arel 2.2
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
end
