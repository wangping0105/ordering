module EntityQueryable
  extend ActiveSupport::Concern

  included do
    scope :joins_association_fields, -> (*fields) {
      joins_array = []
      _fields = Array(fields).map(&:to_s)

      joins_array = _fields.map{|field|
        if field.include?('.')
          association_name, field = field.split(".")
          _association = self.reflect_on_association(association_name.to_sym)

          _association.name if _association
        end
      }.compact.uniq

      if joins_array.present?
        joins(*joins_array)
      end
    }

    scope :like_any_fields, -> (query, *fields) {
      _fields = Array(fields).map(&:to_s)

      _flag = false
      queries = _fields.map{|field|
        if field.include?('.')
          association_name, field = field.split(".")
          _association = self.reflect_on_association(association_name.to_sym)

          "#{_association.klass.table_name}.#{field} like :query" if _association
          _flag =true
        else
          "#{table_name}.#{field} like :query"
        end
      }.compact

      joins_association_fields(*_fields).where(queries.join(" or "), query: "%#{query}%") if queries.present?
    }

    scope :eq_any_fields, -> (query, *fields) {
      _fields = Array(fields).map(&:to_s)

      queries = _fields.map{|field|
        if field.include?('.')
          association_name, field = field.split(".")
          _association = self.reflect_on_association(association_name.to_sym)

          "#{_association.klass.table_name}.#{field} = :query" if _association
        else
          "#{table_name}.#{field} = :query"
        end
      }.compact

      joins_association_fields(*_fields).where(queries.join(" or "), query: query.to_s) if queries.present?
    }
  end

end
