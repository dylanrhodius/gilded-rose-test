require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases the quality of standard items by 1 when a day goes by" do
      items = [Item.new("Item", 5, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 9
    end


  end

end
