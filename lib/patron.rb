require('pry')

class Patron
  attr_reader(:id, :name, :phone)

  define_method(:initialize) do |attributes|
    @id = attributes[:id]
    @name = attributes[:name]
    @phone = attributes[:phone]
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      id = patron.fetch("id").to_i()
      name = patron.fetch("name")
      phone = patron.fetch("phone")
      patrons.push(Patron.new({:id => id, :name => name, :phone => phone}))
    end
    patrons
  end

  define_method(:==) do |other|
    self.name.==(other.name).&(self.id.==(other.id))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, phone) VALUES ('#{@name}', '#{@phone}') RETURNING id;")
    @id = result.first['id'].to_i()
  end

  define_singleton_method(:find_by_name) do |name|
    returned_patrons = DB.exec("SELECT * FROM patrons WHERE name = '#{name}';")
    patrons = []
    returned_patrons.each do |patron|
      id = patron['id'].to_i
      name = patron['name']
      phone = patron['phone']
      patrons.push(Patron.new({:id => id, :name => name, :phone => phone}))
    end
    patrons
  end

  define_singleton_method(:find_by_id) do |id|
    returned_patron = DB.exec("SELECT * FROM patrons WHERE id =#{id};").first()
    id = returned_patron['id'].to_i
    name = returned_patron['name']
    phone = returned_patron['phone']
    Patron.new({:id => id, :name => name, :phone => phone})
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @phone = attributes.fetch(:phone, @phone)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE patrons SET phone = '#{@phone}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id};")
  end

  define_method(:checkout_book) do

  end
end
