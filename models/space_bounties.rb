require 'pg'

class Bounties
  attr_accessor :name,:species,:bounty
  attr_reader :id

  def initialize(options)
    @name = options['name']
    @species = options['species']
    @bounty = options['bounty']
    @id = options['id'].to_i
  end

  def save()
    db = PG.connect({
        dbname: 'space_bounties',
        host: 'localhost'
    })
    sql = "
      INSERT INTO space_bounties (
        name,species,bounty
      )
      VALUES
      ($1,$2,$3)
      RETURNING id
    ;"
    # Run Query
    db.prepare('save',sql)
    result = db.exec_prepared('save',[@name,@species,@bounty])

    db.close()

    id = result[0]['id'].to_i
    @id = id
  end

  def self.all()
    db = PG.connect({dbname:'space_bounties',host:'localhost'})

    sql = "SELECT * FROM space_bounties"
    db.prepare('all',sql)
    bounty_hashes = db.exec_prepared('all')
    db.close()

    bounty_objects = bounty_hashes.map do |bounty_hash|
      Bounties.new(bounty_hash)
    end
    return bounty_objects
  end

  def self.view_one(input_id)
    db = PG.connect({dbname:'space_bounties',host:'localhost'})

    sql = "SELECT * FROM space_bounties WHERE id = $1"
    db.prepare('all',sql)
    bounty_hashes = db.exec_prepared('all',[input_id])
    db.close()

    bounty_objects = bounty_hashes.map do |bounty_hash|
      Bounties.new(bounty_hash)
    end
    return bounty_objects
  end

  def self.delete_all()
    db = PG.connect({dbname:'space_bounties',host:'localhost'})

    sql = "DELETE FROM space_bounties"
    db.prepare('all',sql)
    db.exec_prepared('all')
  end

  def self.delete(bounty_id)
    db = PG.connect({
        dbname: 'space_bounties',
        host: 'localhost'
    })

    sql = "
      DELETE FROM space_bounties WHERE id = #{bounty_id};
    "
    # Run Query
    db.exec(sql)
    db.close()
  end

  def self.update(name,species,bounty,id)
    db = PG.connect({dbname: 'space_bounties',host:'localhost'})
    sql = "
      UPDATE space_bounties
      SET (name,species,bounty)
      = ($1,$2,$3)
      WHERE id = $4
      ;"

      values = [name,species,bounty,id]

    db.prepare('update',sql)
    db.exec_prepared('update',values)
    db.close()
  end
end
