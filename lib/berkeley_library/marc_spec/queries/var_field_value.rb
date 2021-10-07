require 'berkeley_library/marc_spec/queries/field_value'

module BerkeleyLibrary
  module MarcSpec
    module Queries
      class VarFieldValue < FieldValue

        # ------------------------------------------------------------
        # Attributes

        attr_reader :subfield

        # ------------------------------------------------------------
        # Initializer

        def initialize(tag, subfield)
          super(tag)
          @subfield = of_any_type(subfield, Subfield, SubfieldValue, allow_nil: false)
        end

        # ------------------------------------------------------------
        # Referent

        def apply(marc_record)
          data_fields = tag.apply(marc_record)
          data_fields.flat_map { |df| subfield.apply(df) }
        end

        # ------------------------------------------------------------
        # Object overrides

        def to_s
          [super, subfield].join
        end

        # ------------------------------------------------------------
        # Predicate

        protected

        def to_s_inspect
          [super, subfield.inspect].join
        end

        def equality_attrs
          [:subfield] + super
        end

      end
    end
  end
end
