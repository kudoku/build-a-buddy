require 'csv'
module CsvHelper
  # module BaseTypes
  #   def inventory(file)
  #     Inventory.new()
  #   end

  #   def product_prices

  #   end

  #   def accessory_compatibility

  #   end

    


  # end

  

  class Importer
    # extend BaseTypes
    class << self
      def import()
        ActiveRecord::Base.transaction do
          filenames = ["#{Rails.root}/lib/assets/Inventory.csv", "#{Rails.root}/lib/assets/Product Prices.csv"]
          filenames.each do |filename|
            csv = CSV.read(filename)
            csv.first.compact.each_with_index do |item, i|
              begin
                klass = "CsvHelper::#{item.delete(' ')}".constantize
                klass.new.import(csv, i)
              rescue NameError => ex
                next
              end
            end
          end

          # filename = "#{Rails.root}/lib/assets/Accessory Compatibility.csv"
          # CSV.read(filename)
        end
      end
    end
  end

  class StuffedAnimals
    FIELD_MAPPINGS = {'Quantity' => :quantity, 'Cost' => :cost, 'Sale Price' => :price}
    attr_accessor :csv_data, :csv_headers, :start_index, :end_index, :order

    def import(csv_rows, order)
      @order = order
      csv_rows.each_with_index do |row, i|
        case i
        when 0
          next
        when 1
          @csv_headers = row.split(nil)[order]
        else
          csv_data = get_csv_data(row)
          if csv_data.present?
            hashed_csv_values = Hash[ @csv_headers.zip(csv_data) ]
            product = Product.find_or_create_by(name: hashed_csv_values['Description'])
            FIELD_MAPPINGS.each do |csv_key, model_field_key|
              value = hashed_csv_values[csv_key]
              product.send("#{model_field_key}=", value) if value
            end
            product.save
          end
        end
      end
    end

    def get_csv_data(row)
      if row.first.present?
        split_row = row.split(nil)
        if !@start_index && !@end_index
          @start_index = 0
          if @order != 0
            split_row[0..@order-1].each_with_index do |previous_group, i|
              @start_index += previous_group.size
            end
            @end_index = @start_index + split_row[@order].size
            @start_index += 1
          else
            @end_index = split_row.first.size - 1
          end
        end
        return split_row[@order]
      else
        return row[@start_index..@end_index].compact
      end
    end
  end

  class Accessories
    FIELD_MAPPINGS = {'Quantity' => :quantity, 'Cost' => :cost, 'Sale Price' => :price, 'Size' => :size}
    attr_accessor :csv_data, :csv_headers, :start_index, :end_index, :order

    def import(csv_rows, order)
      @order = order
      csv_rows.each_with_index do |row, i|
        case i
        when 0
          next
        when 1
          @csv_headers = row.split(nil)[order]
        else
          begin
            csv_data = get_csv_data(row)
            if csv_data
              hashed_csv_values = Hash[ @csv_headers.zip(csv_data) ]
              accessory = Accessory.find_or_create_by(name: hashed_csv_values['Description'], size: hashed_csv_values['Size'])
              FIELD_MAPPINGS.each do |csv_key, model_field_key|
                value = hashed_csv_values[csv_key]
                accessory.send("#{model_field_key}=", value) if value
              end
              accessory.save
            end
          rescue => ex
            binding.pry
          end
        end
      end
    end

    def get_csv_data(row)
      if row.first.present?
        split_row = row.split(nil)
        if !@start_index && !@end_index
          @start_index = 0
          if @order != 0
            split_row[0..@order-1].each_with_index do |previous_group, i|
              @start_index += previous_group.size
            end
            @end_index = @start_index + split_row[@order].size
            @start_index += 1
          else
            @end_index = split_row.first.size - 1
          end
        end
        return split_row[@order]
      else
        return row[@start_index..@end_index].compact
      end
    end
  end

  # class Accessories

  # end

  # class ProductPrices

  # end

  # class AccessoryCompatibility

  # end

  # class PurchaseOrders

  # end

  # class Accessories

  # end

  # class StuffedAnimals

  # end

  # class StuffedAnimals

  # end

  # class Accessories

  # end


end