require('spec_helper')

describe(Patron) do

  describe('#name') do
    it "returns the name of the patron" do
      test_patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      expect(test_patron.name()).to(eq('Mr. Rogers'))
    end
  end

  describe('#patron_id') do
    it "returns the id of the patron" do
      test_patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron.save()
      expect(test_patron.patron_id().class()).to(eq(Fixnum))
    end
  end

  describe('.all') do
    it 'is an empty array at first' do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe('#==') do
    it 'compares two patrons by name and id to see if they are the same' do
      test_patron1 = Patron.new({:patron_id => 1, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:patron_id => 1, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron1.eql?(test_patron2)
    end
  end

  describe('#save') do
    it 'saves a patron' do
      test_patron = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron.save()
      expect(Patron.all()).to(eq([test_patron]))
    end
  end

  # NEW STUFF

  describe('.find_by_name') do
    it 'locates patrons with a given name' do
      test_patron1 = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:patron_id => nil, :name => 'Julia Childs',:phone => '206-345-1198'})
      test_patron1.save()
      test_patron2.save()
      expect(Patron.find_by_name(test_patron1.name())).to(eq([test_patron1]))
    end
  end

  describe('.find_by_patron_id') do
    it 'locates a patron with a given patron_id' do
      test_patron1 = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:patron_id => nil, :name => 'Julia Childs',:phone => '206-345-1198'})
      test_patron1.save()
      test_patron2.save()
      expect(Patron.find_by_patron_id(test_patron1.patron_id())).to(eq(test_patron1))
    end
  end

  describe('#update') do
    it 'lets the user update the attributes of the patron' do
      test_patron1 = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron1.save()
      test_patron1.update({:patron_id => nil, :name => 'Fred Rogers',:phone => '971-358-9742'})
      expect(test_patron1.name()).to(eq('Fred Rogers'))
      expect(test_patron1.phone()).to(eq('971-358-9742'))
    end
  end

  describe('#delete') do
    it 'lets the user delete a patron' do
      test_patron1 = Patron.new({:patron_id => nil, :name => 'Mr. Rogers',:phone => '503-250-2173'})
      test_patron2 = Patron.new({:patron_id => nil, :name => 'Julia Childs',:phone => '206-345-1198'})
      test_patron1.save()
      test_patron2.save()
      test_patron1.delete()
      expect(Patron.all()).to(eq([test_patron2]))
    end
  end
end
