require('pry')

class Patron
  attr_reader(:patron_id, :name, :phone)

  define_method(:initialize) do |attributes|
    @patron_id = attributes[:patron_id]
    @name = attributes[:name]
    @phone = attributes[:phone]
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      patron_id = patron.fetch("patron_id").to_i()
      name = patron.fetch("name")
      phone = patron.fetch("phone")
      patrons.push(Patron.new({:patron_id => patron_id, :name => name, :phone => phone}))
    end
    patrons
  end

  define_method(:==) do |other|
    self.name.==(other.name).&(self.patron_id.==(other.patron_id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, phone) VALUES ('#{@name}', '#{@phone}') RETURNING patron_id;")
    @patron_id = result.first['patron_id'].to_i()
  end

  # NEW STUFF

  define_singleton_method(:find_by_name) do |name|
    returned_patrons = DB.exec("SELECT * FROM patrons WHERE name = '#{name}';")
    patrons = []
    returned_patrons.each do |patron|
      patron_id = patron['patron_id'].to_i
      name = patron['name']
      phone = patron['phone']
      patrons.push(Patron.new({:patron_id => patron_id, :name => name, :phone => phone}))
    end
    patrons
  end

  define_singleton_method(:find_by_patron_id) do |patron_id|
    returned_patron = DB.exec("SELECT * FROM patrons WHERE patron_id =#{patron_id};").first()
    patron_id = returned_patron['patron_id'].to_i
    name = returned_patron['name']
    phone = returned_patron['phone']
    Patron.new({:patron_id => patron_id, :name => name, :phone => phone})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @patron_id = self.patron_id()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE patron_id = #{@patron_id};")
    DB.exec("UPDATE patrons SET phone = '#{@phone}' WHERE patron_id = #{@patron_id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE patron_id = #{self.patron_id};")
  end
end
