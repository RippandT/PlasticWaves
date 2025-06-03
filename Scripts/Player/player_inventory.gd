extends Resource
class_name PlayerInventory

var player_items: Dictionary = {
    "item": ItemObject,
    "quantity": 0
}

var player_inventory: Array[ItemObject]