namespace :seed do
  task init: :environment do
    CsvHelper.import
  end
end