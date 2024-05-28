import 'package:flutter/material.dart';

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

  String viewFilter = '';

  RoomModel? selectedRoom;

  @override
  void initState() {
    super.initState();
    viewFilteredItems.addAll(rooms);
  }

  void updateFilteredList() {
    filteredItems = rooms.where((item) => item.isSelected).toList();

    viewFilteredItems = rooms
        .where((item) => item.view == viewFilter || viewFilter.isEmpty)
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
            const SizedBox(width: 10),
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
          flex: 1,
          child: CheckListOptionsList(
            itemsList: viewFilteredItems,
            updateFilteredListFn: updateFilteredList,
            onItemSelected: (room) {
              selectedRoom = room;
              setState(() {});
            },
          ),
        ),
        const Divider(),
        Expanded(
          child: SelectedRoomInfo(room: selectedRoom),
        ),
      ],
    );
  }
}

class SelectedRoomInfo extends StatelessWidget {
  final RoomModel? room;

  const SelectedRoomInfo({super.key, this.room});

  @override
  Widget build(BuildContext context) {
    if (room == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          title: Text(room!.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(room!.description),
              Text('Capacity: ${room!.capacity}'),
              Text('View: ${room!.view}'),
            ],
          ),
        ),
      ],
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

  const CheckListOptionsList({
    super.key,
    required this.itemsList,
    required this.updateFilteredListFn,
    required this.onItemSelected,
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
            title: Text(itemName),
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
            setState(() {});
          },
        );
      },
    );
  }
}
