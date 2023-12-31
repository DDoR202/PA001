tool
extends "res://addons/dialogic/Editor/Events/Parts/EventPart.gd"

# has an event_data variable that stores the current data!!!

## node references
onready var picker_menu = $MenuButton

# used to connect the signals
func _ready():
	picker_menu.connect("about_to_show", self, "_on_PickerMenu_about_to_show")
	picker_menu.custom_icon = load("res://addons/dialogic/Images/Resources/timeline.svg")

# called by the event block
func load_data(data:Dictionary):
	# First set the event_data
	.load_data(data)
	
	# Now update the ui nodes to display the data. 
	if event_data['change_timeline'] != '':
		for c in DialogicUtil.get_timeline_list():
			if c['file'] == event_data['change_timeline']:
				picker_menu.text = c['name']
	else:
		picker_menu.text = 'Select Timeline'


# has to return the wanted preview, only useful for body parts
func get_preview():
	return ''


# when an index is selected on one of the menus.
func _on_PickerMenu_selected(index, menu):
	var text = menu.get_item_text(index)
	var metadata = menu.get_item_metadata(index)
	picker_menu.text = text
	event_data['change_timeline'] = metadata['file']
	
	# informs the parent about the changes!
	data_changed()


func _on_PickerMenu_about_to_show():
	build_PickerMenu()


func build_PickerMenu():
	picker_menu.get_popup().clear()
	var timeline_structure = find_parent('EditorView').flat_structure['Timelines']
	var folder_structure = build_PickerMenuFolderFlat(picker_menu.get_popup(), timeline_structure, "MenuButton")
	var files_info = build_PickerMenuFiles(timeline_structure)
	## building the root level
	build_PickerMenuFolder(picker_menu.get_popup(), folder_structure, "MenuButton", files_info)


# is called recursively to build all levels of the folder structure

func build_PickerMenuFolderFlat(menu:PopupMenu, folder_structure:Dictionary, current_folder_name:String):
	var nested = {}
	nested['folders'] = {}
	nested['files'] = []
	for item in folder_structure.keys():
		DialogicResources.recursive_build(item.right(1), folder_structure[item], nested)
	
	return nested	

func build_PickerMenuFiles(timeline_structure):
	var files_dict = {}
	
	for i in timeline_structure.keys():
		if !("/." in i):
			#print(timeline_structure[i])
			files_dict[timeline_structure[i]['file']] = {'color':timeline_structure[i]['color'], 'file':i, 'name': timeline_structure[i]['name']}
	return files_dict

func build_PickerMenuFolder(menu:PopupMenu, folder_structure:Dictionary, current_folder_name:String, files_info:Dictionary):
	var index = 0
	for folder_name in folder_structure['folders'].keys():
		var submenu = PopupMenu.new()
		var submenu_name = build_PickerMenuFolder(submenu, folder_structure['folders'][folder_name], folder_name, files_info)
		submenu.name = submenu_name
		menu.add_submenu_item(folder_name, submenu_name)
		menu.set_item_icon(index, get_icon("Folder", "EditorIcons"))
		menu.add_child(submenu)
		picker_menu.update_submenu_style(submenu)
		index += 1

	for file in folder_structure['files']:
		menu.add_item(files_info[file]['name'])
		menu.set_item_icon(index, editor_reference.get_node("MainPanel/MasterTreeContainer/MasterTree").timeline_icon)
		menu.set_item_metadata(index, {'file':file})
		index += 1

	if not menu.is_connected("index_pressed", self, "_on_PickerMenu_selected"):
		menu.connect("index_pressed", self, '_on_PickerMenu_selected', [menu])

	return current_folder_name
