module MassInsert
  module Adapters
    module Helpers
      module AbstractQuery

        # Returns a begin string to a basic mysql query insertion. Include
        # the class table_name and it's included in the string.
        def begin_string
          "INSERT INTO #{table_name} "
        end

        # Returns a string  with the column names to the class table name
        # and divided by commmas.
        def string_columns
          "(#{column_names.join(", ")}) "
        end

        # Returns the string with all the row values that will be included
        # in the sql string.
        def string_values
          "VALUES (#{string_rows_values});"
        end

        # Gives the correct format to the values string to all rows. This
        # functions calls a function that will generate a single string row
        # and at the end all the strings are concatenated.
        def string_rows_values
          values.map{ |row| string_single_row_values(row) }.join("), (")
        end

        def string_single_row_values row
          # Prepare the single row to be included in the sql string.
          row.merge!(timestamp_values) if timestamp?

          # Generates the values to this row that will be included according
          # to the type column and values.
          column_names.map{ |col| string_single_value(row, col) }.join(", ")
        end

        # Returns a single column string value with the correct format and
        # according to the database configuration, column type and presence.
        def string_single_value row, column
          ColumnValue.new(row, column, options).build
        end

      end
    end
  end
end