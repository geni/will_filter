# Arel 2.0 (Rails 3.0) compatibility patch for will_paginate 3.0
# Arel 2.0 doesn't handle raw integers in LIMIT clauses, but will_paginate 3.0 passes them
# This patches Arel's visitor to wrap integers in Arel nodes

if defined?(Arel::VERSION) && Arel::VERSION =~ /^2\.0\./
  module Arel
    module Visitors
      class ToSql
        # Patch visit_Arel_Nodes_Limit to handle raw integers
        alias_method :visit_Arel_Nodes_Limit_without_integer_compat, :visit_Arel_Nodes_Limit

        def visit_Arel_Nodes_Limit(o)
          # If the limit expression is a raw integer, wrap it in a SqlLiteral
          if o.expr.is_a?(Integer)
            o = o.class.new(Arel::Nodes::SqlLiteral.new(o.expr.to_s))
          end
          visit_Arel_Nodes_Limit_without_integer_compat(o)
        end
      end
    end
  end

  # Also patch Offset for consistency
  module Arel
    module Visitors
      class ToSql
        alias_method :visit_Arel_Nodes_Offset_without_integer_compat, :visit_Arel_Nodes_Offset

        def visit_Arel_Nodes_Offset(o)
          # If the offset expression is a raw integer, wrap it in a SqlLiteral
          if o.expr.is_a?(Integer)
            o = o.class.new(Arel::Nodes::SqlLiteral.new(o.expr.to_s))
          end
          visit_Arel_Nodes_Offset_without_integer_compat(o)
        end
      end
    end
  end
end
