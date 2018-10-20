class DocumentDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
	
	subject: { source: "Document.subject", cond: :like }
	year: { source: "Document.year", cond: :like }
	typedoc: { source: "Document.typedoc", cond: :like }
	teacher: { source: "Document.teacher", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        # example:
        subject: record.subject,
       	year: record.year,
	typedoc: record.typedoc,
	teacher: record.teacher
      }
    end
  end

  private

  def get_raw_records
    # insert query here
    Document.select('documents.*, timezone AS custom_column').includes(:subject)
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_subject_condition
  #  ->(column) { column.table[column.field].eq(column.search.value.to_i + 1) }
  # end

  # def filter_custom_column_condition
  #  ->(column) { ::Arel::Nodes::SqlLiteral.new(column.field.to_s).matches("#{ column.search.value }%") }
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
