require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'for regular items' do

      it "decreases the quality value by 1 when a day goes by" do
        items = [Item.new("Item", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 9
      end

      it "decreases the sell_in value by 1 when a day goes by" do
        items = [Item.new("Item", 5, 10)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 4
      end

      it 'degrades quality twice as fast, once sell date has passed' do
        items = [Item.new("Item", 2, 10)]
        3.times do
          GildedRose.new(items).update_quality()
        end
        expect(items[0].quality).to eq 6
      end

    end


  end
end
