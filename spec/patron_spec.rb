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
end
