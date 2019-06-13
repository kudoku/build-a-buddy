require 'csv'
module CsvHelper
  class Importer
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

          filename = "#{Rails.root}/lib/assets/Accessory Compatibility.csv"
          csv = CSV.read(filename)
          csv.each_with_index do |csv_row, csv_row_i|
            next if !csv_row.first.present?
            product = Product.find_by(name: csv_row.first)
            if product
              csv_row.each_with_index do |csv_item, csv_item_i|
                next if !csv_item
                accessory_name = csv[1][csv_item_i]
                previous_matched_indices = csv_row[0..csv_item_i].each_index.select{ |i| csv_row[i] == csv_item }
                if previous_matched_indices.present?
                  accessory_size = csv[0][previous_matched_indices.size - 1]
                else
                  accessory_size = 'All'
                end
                accessory = Accessory.find_by(name: accessory_name, size: accessory_size.downcase)
                product.accessories << accessory if accessory
              end
              product.save
            end
          end
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
              accessory = Accessory.find_or_create_by(name: hashed_csv_values['Description'], size: hashed_csv_values['Size'].downcase)
              FIELD_MAPPINGS.each do |csv_key, model_field_key|
                value = hashed_csv_values[csv_key]
                accessory.send("#{model_field_key}=", value) if value
              end
              accessory.save
            end
          rescue => ex

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
end