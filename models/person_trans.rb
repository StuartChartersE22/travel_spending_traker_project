require_relative("../db/sql_runner_money_tracker.rb")
require_relative("./money.rb")
require("pry")

class PersonTrans

  attr_reader(:id, :transaction_id, :person_id)
  attr_accessor(:owe, :timelog)

  def initialize(details)
    @id = details["id"].to_i() if details["id"]
    @transaction_id = details["transaction_id"].to_i()
    @person_id = details["person_id"].to_i()
    @owe = Money.convert_to_integer(details["owe"])
    @timelog = details["timelog"]
  end

  #Pure Ruby class methods
    def self.map_relationships(array_of_details)
      return array_of_details.map {|dets| self.new(dets)}
    end

  #SQL instance methods
    def save()
      sql = "INSERT INTO people_trans
      (transaction_id, person_id, owe, timelog) VALUES ($1, $2, $3, $4)
      RETURNING id"
      values = [@transaction_id, @person_id, @owe, @timelog]
      @id = SqlRunner.run(sql, values)[0]["id"].to_i()
    end

  #SQL class methods
    def self.delete_all()
      sql = "DELETE FROM people_trans"
      return SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM people_trans"
      array_of_details = SqlRunner.run(sql)
      return self.map_relationships(array_of_details)
    end
end
