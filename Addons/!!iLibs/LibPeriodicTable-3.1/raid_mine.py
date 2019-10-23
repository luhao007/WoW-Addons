
import re
import random
import urllib2
import time
import json
from collections import defaultdict

class_ids = {"Death Knight" : 6, "Druid" : 11, "Hunter" : 3, "Mage" : 8, "Monk" : 10, "Paladin" : 2, "Priest" : 5, "Rogue" : 4, "Shaman" : 7, "Warlock" : 9, "Warrior" : 1}

#set_id = 38 #Tier 13 
#set_id = 43 #Tier 15
#set_id = 65 #tier 17
set_id = 71 #tier 18

def get_data(p_class_id, p_set_id):
	opener = urllib2.build_opener()
	opener.addheaders = [('User-agent', 'Mozilla/5.0')]
	urllib2.install_opener(opener)
	
	item_url = "http://www.wowhead.com/itemsets?filter=cl={0};ta={1}&xml".format(p_class_id, p_set_id)
	usock = urllib2.urlopen(url=item_url, timeout=30)
	data = usock.read()
	usock.close()
	
	m = re.search(r'new\s+Listview\s*\((.+?)\)', data, flags=re.DOTALL)
	try:
		listview = m.group(1)
	except AttributeError:
		print "Error: failed to find data for class id {0}".format(p_class_id)
		return
	#print "id:{1}\n {0}\n".format(listview, p_class_id)
	
	listview2 = re.search(r'data:\s*(\[.+\])', listview, flags=re.DOTALL).group(1)
	#print "*********"
	#print listview2 + "\n"
	
	
	j_data = json.loads(listview2)
	
	#print json.dumps(j_data, sort_keys=True, indent=3, separators=(',', ': '))
	
	my_dict = {}
	
	for entry in j_data:
		#item = re.sub('firstseenpatch', '"firstseenpatch"', item)
		#item = re.sub('cost', '"cost"', item)
		#print item
		#print json.dumps(entry, sort_keys=True, indent=3, separators=(',', ': '))
		name = filter(lambda c: not c.isdigit(), entry["name"])
		level = entry["maxlevel"]
		id = entry["id"]
		#print "Name: {0}, Level:{1}, ID:{2}, Pieces:{3}".format(name, level, id, entry["pieces"])
		if name not in my_dict:
			my_dict[name] = {}
		my_dict[name][level] = id
		#j_data = json.loads(item)
		#trim_item_json(j_data)
			
		#all_items.append(j_data)
	
	#print my_dict
	
	#print sorted(my_dict.keys())
	
	return my_dict
	
def process_miner_data(p_data_dict):
	for key in sorted(p_data_dict.keys()):
		#print "key:{0}, value:{1}".format(key, my_dict[key])
	
		line = "\t[\"{0}\"] = {{".format(key)
		for id_key in sorted(p_data_dict[key].keys()):
			line += "[\"{0}\"] = {1}, ".format(id_key, p_data_dict[key][id_key] )
	
		line += "},"
		print line

def process_data_lua(p_data_dict, p_tier, p_class_name):
	for name in sorted(p_data_dict.keys()):
		#print "name:{0}, value:{1}".format(name, my_dict[key])
	
		for id_key in sorted(p_data_dict[name].keys()):
			line = "\t[\"GearSet.Tier {0}.{1}.{2}.{3}\"] = \"\",".format(p_tier, id_key, p_class_name, name)	
			print line
#["GearSet.Tier 16.566.Warrior.Plate of the Prehistoric Marauder"] = "99407,99408,99409,99410,99415",


for class_key in sorted(class_ids.keys()):
#	print class_key
	
	data = get_data(class_ids[class_key], set_id)
	
	process_miner_data(data)

print ""
	
for class_key in sorted(class_ids.keys()):
	
	data = get_data(class_ids[class_key], set_id)
	
	process_data_lua(data, 18, class_key)

print ""

	