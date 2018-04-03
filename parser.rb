# In command line, run [ruby parser.rb] to run this file

require 'pry' #Pry is a debugging/REPL tool. Insert a binding.pry where you want 
			# the script to stop and let you look around. Assuming you have Ruby 
			# installed, run [gem install pry] to install
require 'json'
require 'csv'
require 'rubygems'
require 'active_support'

file = File.read('shop.json')

data_hash = JSON.parse(file)

###  generate human readable json file ###

data = JSON.pretty_generate(data_hash)
items = JSON.pretty_generate(data_hash['items'])
# File.open("items.json", "w") do |f|
# 	f.write(items)
# end

labels = 'Handle,Title,Body (HTML),Vendor,Type,Collection,Tags,Published,Option1 Name,Option1 Value,Option2 Name,Option2 Value,Option3 Name,Option3 Value,Variant SKU,Variant Grams,Variant Inventory Tracker,Variant Inventory Qty,Variant Inventory Policy,Variant Fulfillment Service,Variant Price,Variant Compare At Price,Variant Requires Shipping,Variant Taxable,Variant Barcode,Image Src,Image Position,Image Alt Text,Gift Card,Google Shopping / MPN,Google Shopping / Age Group,Google Shopping / Gender,Google Shopping / Google Product Category,SEO Title,SEO Description,Google Shopping / AdWords Grouping,Google Shopping / AdWords Labels,Google Shopping / Condition,Google Shopping / Custom Product,Google Shopping / Custom Label 0,Google Shopping / Custom Label 1,Google Shopping / Custom Label 2,Google Shopping / Custom Label 3,Google Shopping / Custom Label 4,Variant Image,Variant Weight Unit,Variant Tax Code'

headers = labels.split(',')
tags_categories = ""
itemTags = ""
designers = ["Natalie Martin", "Amy Dov Studio", "Matta", "Fay Andrada", "Faris", "Colin Adrian", "Anaak", "Rachel Craven", "Leigh Miller", "Marta Pia", "Takara", "Colleen Hennessey", "Maryam Nassir Zadeh", "Lauren Manoogian", "Mquan", "Moondeli", "Henne", "Ollio E Osso", "La Tierra Sagrada", "Milena Silvano", "Lila Rice", "No.6", "Collina Strada", "Lola James Harper", "Crescioni", "Salihah Moore", "Spencer Peterman", "Norden", "Mary Macgill", "Blue Eagle", "Blue Eagle Pottery", "Fog Linen", "Reinhard Plank", "Beatrice Valenzuela", "Lauren Manoogian Straight Pants In Camel", "Miwak Junior", "Revisited Matters", "Tobacco", "Kathleen Whitaker", "Just Say Native", "Rth", "Kosas", "Daughter Of The Land", "Wildcare", "Rms", "Fiele", "Land Of Women", "Wonder Valley", "Maison Louis Marie", "Grown Alchemist", "Mondo Mondo", "Poppy And Someday", "Moon Juice", "Fat And The Moon", "Shiva Rose", "Mari Giudicelli", "Caron Callahan", "Hans Pants", "Caron Callahan Pants", "Sailor Pants", "Ilana Kohn", "Boyd", "Bliss And Mischief"]
permitted_tags = ["Gift Certificate", "Liner Jacket",  "Gift Card", "Pants", "Earrings",  "Gift Sets", "Boots", "Clogs", "Primecut", "Living Libations", "Hoops", "Dress", "Jumpsuit", "Workwear", "India", "Quilted", "Block Print", "Bucket Bag", "Leather Bucket Bag", "Dune Bag", "Hat", "Mt. Washington", "Talisman", "B Sides", "Accessories", "White Pearl", "Salad Server", "Serving Tray", "Spalted",  "Boilersuit", "Onepiece", "Jewelry", "Camel", "Sweater Pants", "Mug", "Lipstick", "Vintage", "Jacket", "Driftwood", "Serving Bowl", "Wooden Spoon", "Wrap Pants", "Wide Leg"]
prod_tags = []


def populate_row(args = {})
	defaults = {
	Handle: nil,
	Title: nil,
	Body: nil,
	Vendor: nil,
	Type: nil,
	Collection: nil,
	Tags: nil,
	Published: nil,
	Option1_Name: nil,
	Option1_Value: nil,
	Option2_Name: nil,
	Option2_Value: nil,
	Option3_Name: nil,
	Option3_Value: nil,
	Variant_SKU: nil,
	Variant_Grams: nil,
	Variant_Inventory_Tracker: nil,
	Variant_Inventory_Qty: nil,
	Variant_Inventory_Policy: nil,
	Variant_Fulfillment_Service: nil,
	Variant_Price: nil,
	Variant_Compare_At_Price: nil,
	Variant_Requires_Shipping: nil,
	Variant_Taxable: nil,
	Variant_Barcode: nil,
	Image_Src: nil,
	Image_Position: nil,
	Image_Alt_Text: nil,
	Gift_Card: nil,
	Google_Shopping_MPN: nil,
	Google_Shopping_Age_Group: nil,
	Google_Shopping_Gender: nil,
	Google_Shopping_Google_Product_Category: nil,
	SEO_Title: nil,
	SEO_Description: nil,
	Google_Shopping_AdWords_Grouping: nil,
	Google_Shopping_AdWords_Labels: nil,
	Google_Shopping_Condition: nil,
	Google_Shopping_Custom_Product: nil,
	Google_Shopping_Custom_Label0: nil,
	Google_Shopping_Custom_Label1: nil,
	Google_Shopping_Custom_Label2: nil,
	Google_Shopping_Custom_Label3: nil,
	Google_Shopping_Custom_Label4: nil,
	Variant_Image: nil,
	Variant_Weight_Unit: nil,
	Variant_Tax_Code: nil,
	}

	defaults.merge(args).values
	
end

data_hash['items'].each_with_index do |item, index|
	
	# first_variant = item['structuredContent']['variants'][0]['attributes'].keys.first

	# multiple_variants = false
	# variant1_hash = Hash.new
	# variant2_hash = Hash.new
	# value1_array = []
	# value2_array = []
	# second_variant = nil
	


	# if index == 49
	# 	puts "#{item}"
		
	# end

end

# Generates file called 'products.csv' and populates items from 'shop-vestige.json'
CSV.open('latest_products.csv','w', 
    :write_headers=> true,
    :headers => headers #< column headers
  ) do|hdr|

data_hash['items'].each_with_index do |item, index|
	
	handle = item['urlId']
	title = item['title'].split.map(&:capitalize)*' '
	body = item['excerpt']
	vendors = []

	# populate tag list from categories and tags, separate out vendors(designers)
		prod_tags = ''
		item['categories'].each do |cat|
			prod_tags << " #{cat},"
		end
		if item['tags'].class == Array
			item['tags'].each do |tag|
				if tag != item['tags'].last
			  		prod_tags << " #{tag},"
			  	else
			  		prod_tags << " #{tag}"
			  	end
	          if designers.include?("#{tag.split.map(&:capitalize)*' '}")
	 				vendors << "#{tag.split.map(&:capitalize)*' '}"
				end
			end
				vendor = vendors.first
		end

	# the second image listed (in items['items']['assetUrl']) with each item seems to be the lead image
	  	lead_image = item['items'][0]['assetUrl']

	# assign variants for first pass
		
		item['structuredContent']['variants'].each do |var|
			option1_name = "Title"
			option1_value = "Default Title"
			option2_name = ""
			option2_value = ""
			option3_name = ""
			option3_value = ""
			price = var['price']/100
			sku = var['sku']
			quantity = var['qtyInStock']
			unless var['attributes'].values[0] == nil || var['attributes'].values[0] == ""
				option1_name = var['attributes'].keys[0]
				option1_value = var['attributes'].values[0]
			end
			unless var['attributes'].values[1] == nil || var['attributes'].values[1] == ""
				option2_name = var['attributes'].keys[1]
				option2_value = var['attributes'].values[1]
			end

		# Generate first row for this product

			hdr << populate_row(
				Handle: handle,
				Title: title,
				Body: body,
				Vendor: vendor,
				Tags: prod_tags,
				Option1_Name: option1_name,
				Option1_Value: option1_value,
				Option2_Name: option2_name,
				Option2_Value: option2_value,
				Option3_Name: option3_name,
				Option3_Value: option3_value,
				Variant_SKU: sku,
				Variant_Inventory_Tracker: "Shopify",
				Variant_Inventory_Qty: quantity,
				Variant_Inventory_Policy: "Deny",
				Variant_Fulfillment_Service: "Manual",
				Variant_Price: price,
				Image_Src: lead_image,
				Variant_Tax_Code: "",
			)
		end

	# assign additional images for this product
		first_listed_image = item['assetUrl']
		# get first listed image - item['assetUrl']
		item['items'].each_with_index do |item, index|
			if index == 0 # if this is the second listed image (item['item']['assetUrl']), 
					# skip this image as it was loaded earlier and use the first one (item['assetUrl'])
				imageUrl = first_listed_image 
			else # for all other images, load them normally
				imageUrl = item['assetUrl']
			end
			
			hdr << populate_row(Handle: handle, Image_Src: imageUrl)

		end  # end each_with_index
	end  # end data_hash['items'].each do |item|
end # end CSV builder