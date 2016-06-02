#####################################
# Author:zhaozhiyong
# Date:20160602
# Fun:Label Propagation
#####################################
import string

def loadData(filePath):
    f = open(filePath)
    vector_dict = {}
    edge_dict_out = {}#out
    edge_dict_in = {}#in

    for line in f.readlines():
        lines = line.strip().split("\t")
	if lines[0] not in vector_dict:
		vector_dict[lines[0]] = string.atoi(lines[0])
	if lines[1] not in vector_dict:
		vector_dict[lines[1]] = string.atoi(lines[1])

	if lines[0] not in edge_dict_out:
		edge_list = []
		if len(lines) == 3:
			edge_list.append(lines[1] + ":" + lines[2])
		edge_dict_out[lines[0]] = edge_list
	else:
		edge_list = edge_dict_out[lines[0]]
		if len(lines) == 3:
			edge_list.append(lines[1] + ":" + lines[2])
		edge_dict_out[lines[0]] = edge_list
	
	if lines[1] not in edge_dict_in:
		edge_list = []
                if len(lines) == 3:
                        edge_list.append(lines[0] + ":" + lines[2])
                edge_dict_in[lines[1]] = edge_list
	else:
		edge_list = edge_dict_in[lines[1]]
                if len(lines) == 3:
                        edge_list.append(lines[0] + ":" + lines[2])
                edge_dict_in[lines[1]] = edge_list
	
    f.close()
    return vector_dict, edge_dict_out, edge_dict_in

def get_max_community_label(vector_dict, adjacency_node_list):
    label_dict = {}
    # generate the label_dict
    for node in adjacency_node_list:
        node_id_weight = node.strip().split(":")
        node_id = node_id_weight[0]
        node_weight = float(node_id_weight[1])
        if vector_dict[node_id] not in label_dict:
            label_dict[vector_dict[node_id]] = node_weight
        else:
            label_dict[vector_dict[node_id]] += node_weight

    # find the max label
    sort_list = sorted(label_dict.items(), key = lambda d: d[1], reverse=True)

    return sort_list[0][0]

def check(vector_dict, edge_dict):
    #for every node
    for node in vector_dict.keys():
        adjacency_node_list = edge_dict[node]

        node_label = vector_dict[node]#suject to 

        label_check = {}

        for ad_node in adjacency_node_list:
            node_id_weight = ad_node.strip().split(":")
            node_id = node_id_weight[0]
	    node_weight = node_id_weight[1]
            if vector_dict[node_id] not in label_check:
                label_check[vector_dict[node_id]] = float(node_weight)
            else:
                label_check[vector_dict[node_id]] += float(node_weight)
	    #print label_check


        sort_list = sorted(label_check.items(), key = lambda d: d[1], reverse=True)

        if node_label == sort_list[0][0]:
            continue
        else:
            return 0

    return 1    

def label_propagation(vector_dict, edge_dict_out, edge_dict_in):
    #rebuild edge_dict
    edge_dict = {}
    for node in vector_dict.iterkeys():
	out_list = edge_dict_out[node]
	in_list = edge_dict_in[node]
	#print "node:", node
	#print "out_list:", out_list
	#print "in_list:", in_list
	#print "------------------------------------------------"
        out_dict = {}
	for out_x in out_list:
		out_xs = out_x.strip().split(":")
		if out_xs[0] not in out_dict:
			out_dict[out_xs[0]] = float(out_xs[1])
	in_dict = {}
	for in_x in in_list:
		in_xs = in_x.strip().split(":")
		if in_xs[0] not in in_dict:
			in_dict[in_xs[0]] = float(in_xs[1])
	#print "out_dict:", out_dict
	#print "in_dict:", in_dict
	last_list = []
	for x in out_dict.iterkeys():
		out_x = out_dict[x]
		in_x = 0.0
		if x in in_dict:
			in_x = in_dict.pop(x)
		result = out_x + 0.5 * in_x
		last_list.append(x + ":" + str(result))
	if not in_dict:
		for x in in_dict.iterkeys():
			in_x = in_dict[x]
			result = 0.5 * in_x
			last_list.append(x + ":" + str(result))
	#print "last_list:", last_list
	
	if node not in edge_dict:
		edge_dict[node] = last_list
		
    
    #initial, let every vector belongs to a community
    t = 0
    #for every node in a random order
    while True:
        if (check(vector_dict, edge_dict) == 0):
            t = t+1
            print "----------------------------------------"
            print "iteration: ", t
            for node in vector_dict.keys():
                adjacency_node_list = edge_dict[node]
                vector_dict[node] = get_max_community_label(vector_dict, adjacency_node_list)
            print vector_dict
        else:
            break
    
    return vector_dict

if __name__ == "__main__":
    vector_dict, edge_dict_out, edge_dict_in = loadData("./cd_data.txt")
    print vector_dict
    print edge_dict_out
    print edge_dict_in
   
    #print "original community: ", vector_dict

    vec_new = label_propagation(vector_dict, edge_dict_out, edge_dict_in)

    print "---------------------------------------------------------"
    print "the final result: "
    for key in vec_new.keys():
        print str(key) + " ---> " + str(vec_new[key])
