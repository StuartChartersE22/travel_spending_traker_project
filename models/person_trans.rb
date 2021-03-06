require_relative("../db/sql_runner_money_tracker.rb")
require_relative("./money.rb")
require("pry")

class PersonTrans

  attr_reader(:id, :transaction_id, :person_id, :owe, :date)

  def initialize(details)
    @id = details["identity"].to_i() if details["identity"]
    @transaction_id = details["transaction_id"].to_i()
    @person_id = details["person_id"].to_i()
    @owe = details["owe"].to_i()
    @date = details["timelog"]
  end

  #Pure Ruby instance methods
  def show_decimal_owing()
    return Money.convert_to_decimal_string(@owing)
  end

  def change_owing(decimal_string)
    @owe = Money.convert_to_integer(decimal_string)
  end

  #Pure Ruby class methods
    def self.map_relationships(array_of_details)
      return array_of_details.map {|dets| self.new(dets)}
    end

  #SQL instance methods
    def save()
      sql = "INSERT INTO people_trans
      (transaction_id, person_id, owe, timelog) VALUES ($1, $2, $3, $4)
      RETURNING identity"
      values = [@transaction_id, @person_id, @owe, @date]
      @id = SqlRunner.run(sql, values)[0]["identity"].to_i()
    end

    def delete()
      sql = "DELETE FROM people_trans
      WHERE identity = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def update()
      sql = "UPDATE people_trans
      SET (transaction_id, person_id, owe, timelog) = ($1, $2, $3, $4)
      WHERE identity = $5"
      values = [@transaction_id, @person_id, @owe, @date, @id]
      SqlRunner.run(sql, values)
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

    def self.find(id)
      sql = "SELECT * FROM people_trans WHERE identity = $1"
      values = [id]
      details = SqlRunner.run(sql, values)[0]
      return self.new(details)
    end

end
