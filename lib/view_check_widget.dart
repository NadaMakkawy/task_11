import 'package:flutter/material.dart';

import 'summary_page.dart';
import 'extras_data.dart';
import 'room_model.dart';
import 'rooms_data.dart';

class ViewCheckWidget extends StatefulWidget {
  const ViewCheckWidget({super.key});

  @override
  State<ViewCheckWidget> createState() => _ViewCheckWidgetState();
}

class _ViewCheckWidgetState extends State<ViewCheckWidget> {
  List<RoomModel> rooms =
      roomsData.map((data) => RoomModel.fromJson(data)).toList();

  List<RoomModel> filteredItems = [];
  List<RoomModel> viewFilteredItems = [];

  List<Map<String, dynamic>> selectedItemsPrice = [];

  String viewFilter = '';

  RoomModel? selectedRoom;

  @override
  void initState() {
    super.initState();
    viewFilteredItems.addAll(rooms);
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var item in selectedItemsPrice) {
      totalPrice += item['price'];
      setState(() {});
    }
    return totalPrice;
  }

  void updateFilteredList() {
    selectedItemsPrice.clear();

    filteredItems = rooms.where((item) => item.isSelected).toList();

    viewFilteredItems = rooms
        .where((item) => item.view == viewFilter || viewFilter.isEmpty)
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = getTotalPrice();

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: extrasData.length,
            itemBuilder: (context, index) {
              final item = extrasData[index];
              return CheckboxListTile(
                title: Text(item['title']),
                value: item['isSelected'],
                onChanged: (value) {
                  setState(() {
                    item['isSelected'] = value!;
                    if (value) {
                      selectedItemsPrice.add(item);
                    } else {
                      selectedItemsPrice.remove(item);
                    }
                  });
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Price: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      activeColor: Colors.orange,
                      value: 'Sea View',
                      groupValue: viewFilter,
                      onChanged: (String? value) {
                        setState(() {
                          viewFilter = value!;
                          updateFilteredList();
                        });
                      },
                    ),
                    const Text('Sea View'),
                  ],
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    Radio<String>(
                      activeColor: Colors.orange,
                      value: 'City View',
                      groupValue: viewFilter,
                      onChanged: (String? value) {
                        setState(() {
                          viewFilter = value!;
                          updateFilteredList();
                        });
                      },
                    ),
                    const Text('City View'),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                elevation: 3,
              ),
              onPressed: () {
                viewFilter = '';
                updateFilteredList();
                setState(() {});
              },
              child: const Text('Clear Filter'),
            ),
          ],
        ),
        Expanded(
          flex: 2,
          child: CheckListOptionsList(
            itemsList: viewFilteredItems,
            updateFilteredListFn: updateFilteredList,
            onItemSelected: (room) {
              selectedRoom = room;
              setState(() {});
            },
            selectedItemsPrice: selectedItemsPrice,
          ),
        ),
        if (selectedRoom != null) const Divider(),
        Expanded(
          child: SelectedRoomInfo(
            room: selectedRoom,
            onRoomSelected: (room) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SummaryPage(selectedItems: selectedItemsPrice),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SelectedRoomInfo extends StatelessWidget {
  final RoomModel? room;
  final Function(RoomModel?)? onRoomSelected;

  const SelectedRoomInfo({
    super.key,
    this.room,
    this.onRoomSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (room == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        if (onRoomSelected != null) {
          onRoomSelected!(room);
        }
      },
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '• Selected Room:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.orange,
              ),
            ),
          ),
          ListTile(
            leading: Image.asset(room!.imagePath),
            title: Text(
              room!.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room!.description),
                Row(
                  children: [
                    const Icon(Icons.person),
                    Text(room!.capacity),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.park),
                    Text(room!.view),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckListOption extends StatefulWidget {
  final String itemName;
  final String? imagePath;
  final Column itemText;
  final bool isSelected;
  final Function(bool?)? onChangedFn;

  const CheckListOption({
    super.key,
    required this.itemName,
    this.imagePath,
    required this.itemText,
    required this.isSelected,
    required this.onChangedFn,
  });

  @override
  State<CheckListOption> createState() => _CheckListOptionState();
}

class _CheckListOptionState extends State<CheckListOption> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: ListTile(
        leading: Image.asset(widget.imagePath!),
        contentPadding: const EdgeInsets.all(0),
        title: Text(widget.itemName),
        subtitle: widget.itemText,
      ),
      value: widget.isSelected,
      onChanged: widget.onChangedFn,
    );
  }
}

class CheckListOptionsList extends StatefulWidget {
  final List<RoomModel> itemsList;
  final Function updateFilteredListFn;
  final Function(RoomModel?) onItemSelected;
  final List<Map<String, dynamic>> selectedItemsPrice;

  const CheckListOptionsList({
    super.key,
    required this.itemsList,
    required this.updateFilteredListFn,
    required this.onItemSelected,
    required this.selectedItemsPrice,
  });

  @override
  State<CheckListOptionsList> createState() => _CheckListOptionsListState();
}

class _CheckListOptionsListState extends State<CheckListOptionsList> {
  RoomModel? selectedRoom;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemsList.length,
      itemBuilder: (context, index) {
        String itemName = widget.itemsList[index].title;
        String itemDescription = widget.itemsList[index].description;
        String itemcapacity = widget.itemsList[index].capacity;
        String imagePath = widget.itemsList[index].imagePath;

        return RadioListTile<RoomModel>(
          activeColor: Colors.orange,
          title: ListTile(
            leading: Image.asset(imagePath),
            title: Text(
              itemName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemDescription),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                    ),
                    const SizedBox(width: 10),
                    Text(itemcapacity),
                  ],
                ),
              ],
            ),
          ),
          value: widget.itemsList[index],
          groupValue: selectedRoom,
          onChanged: (RoomModel? room) {
            selectedRoom = room;
            for (var item in widget.itemsList) {
              item.isSelected = false;
            }
            if (room != null) {
              room.isSelected = true;
            }
            widget.onItemSelected(room);
            widget.updateFilteredListFn();
            if (room != null) {
              widget.selectedItemsPrice.add({
                'title': room.title,
                'price': room.price,
              });
            }
            setState(() {});
          },
        );
      },
    );
  }
}
