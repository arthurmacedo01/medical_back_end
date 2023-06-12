# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "csv"

Patient.find_or_create_by(
  name: "Fulano de Tal",
  birthday: "1989-01-20",
  cpf: "042.234.567-89",
  gender: "Masculinio",
  contact: "(12) 99234-0934",
)

###  SEED FOR PatchTestInfo Model
csv_text = File.read(Rails.root.join("lib", "seeds", "patch_test_info.csv"))
csv = CSV.parse(csv_text, headers: true, encoding: "utf-8")
csv.each do |row|
  PatchTestInfo.create_with(
    title: row["title"],
    initial_show: row["initial_show"],
    description: row["description"],
    application: row["application"],
    citation: row["citation"],
  ).find_or_create_by(identifier: row["identifier"])
end

###  SEED FOR PatchSensitizersInfo Model
csv_text =
  File.read(Rails.root.join("lib", "seeds", "patch_sensitizers_info.csv"))
csv = CSV.parse(csv_text, headers: true, encoding: "utf-8")
csv.each do |row|
  PatchSensitizerInfo.create_with(
    patch_test_info_id:
      PatchTestInfo.find_by(identifier: row["patch_identifier"]).id,
    name: row["name"],
    option_name: row["option_name"],
    description: row["description"],
    first_text: row["first_text"],
    second_text: row["second_text"],
  ).find_or_create_by(label: row["label"])
end
