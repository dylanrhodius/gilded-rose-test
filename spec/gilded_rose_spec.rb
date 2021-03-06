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

      it 'does not decrease the quality of an item below 0 (quality is never negative)' do
        items = [Item.new("Item", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      it 'does not increase the quality of an item beyond 50' do
        items = [Item.new("Aged Brie", 5, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
      end
    end

    context 'Aged Brie' do
      it 'Aged brie\'s quality increases the older it gets' do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end
    end

    context 'Sulfuras, Hand of Ragnaros' do
      it 'never decreases in quality' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", sell_in=0, quality=80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end

      it 'sell_in never decreases' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", sell_in=0, quality=80)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 0
      end
    end

    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'increases in quality as sellin approaches: regular' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in=20, quality=20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 21
      end

      it 'increases in quality as sellin approaches: 10 or less days' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 22
      end

      it 'increases in quality as sellin approaches: 5 or less days' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 23
      end

      it 'loses all quality after its sellin date drops to 0' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in=0, quality=20)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    context 'Conjured items' do
      it 'degrade in Quality twice as fast as normal items' do
        items = [Item.new("Conjured Mana Cake", 3, 6)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 4
      end

      it 'degrade in Quality twice as fast as normal items' do
        items = [Item.new("Conjured Mana Cake", 0, 6)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
    end
  end
end
