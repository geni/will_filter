# Monkey patches for Rails 3.2.x compatibility with will_paginate and Arel on Ruby 2.7+
# Rails 3.2 uses Arel 3.0.x which has issues with Integer limit values from will_paginate
#
# This fixes the "Cannot visit Integer" error when using will_paginate
# Note: These patches are needed for Ruby 2.7+ compatibility

if defined?(Arel::VERSION) && Arel::VERSION =~ /^3\.0\./
  module Arel
    module Visitors
      module IntegerLimitOffsetCompat
        def visit_Arel_Nodes_Limit(o, *a)
          # If the limit expression is a raw integer, wrap it in a SqlLiteral
          if o.expr.is_a?(Integer)
            o = o.class.new(Arel::Nodes::SqlLiteral.new(o.expr.to_s))
          end
          super(o, *a)
        end

        def visit_Arel_Nodes_Offset(o, *a)
          # If the offset expression is a raw integer, wrap it in a SqlLiteral
          if o.expr.is_a?(Integer)
            o = o.class.new(Arel::Nodes::SqlLiteral.new(o.expr.to_s))
          end
          super(o, *a)
        end
      end

      ToSql.prepend(IntegerLimitOffsetCompat)
    end
  end
end
