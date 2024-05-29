import 'package:flutter/material.dart';

import '../models/room_model.dart';
import '../data/rooms_data.dart';

class RoomListView extends StatefulWidget {
  const RoomListView({super.key});

  @override
  State<RoomListView> createState() => _RoomListViewState();
}

class _RoomListViewState extends State<RoomListView> {
  List<RoomModel> rooms =
      roomsData.map((data) => RoomModel.fromJson(data)).toList();

  List<RoomModel> filteredItems = [];
  List<RoomModel> viewFilteredItems = [];

  String viewFilter = '';

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
            ElevatedButton(
              onPressed: () {
                viewFilter = 'Sea View';
                updateFilteredList();
                setState(() {});
              },
              child: const Text('Sea View'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                viewFilter = 'City View';
                updateFilteredList();
                setState(() {});
              },
              child: const Text('City View'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
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
          child: CheckListOptionsList(
            itemsList: viewFilteredItems,
            updateFilteredListFn: updateFilteredList,
          ),
        ),
        const Divider(),
        const Text('Filtered List:'),
        Expanded(
          child: ListView.builder(
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              String itemName = filteredItems[index].title;
              return ListTile(
                title: Text(itemName),
              );
            },
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
        // CircleAvatar(
        //   backgroundImage: AssetImage(widget.imagePath!),
        //   radius: 30,
        // ),
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

  const CheckListOptionsList({
    super.key,
    required this.itemsList,
    required this.updateFilteredListFn,
  });

  @override
  State<CheckListOptionsList> createState() => _CheckListOptionsListState();
}

class _CheckListOptionsListState extends State<CheckListOptionsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.itemsList.length,
      itemBuilder: (context, index) {
        String itemName = widget.itemsList[index].title;
        String itemDescription = widget.itemsList[index].description;
        String itemcapacity = widget.itemsList[index].capacity;
        bool isSelected = widget.itemsList[index].isSelected;
        String imagePath = widget.itemsList[index].imagePath;

        return CheckListOption(
          isSelected: isSelected,
          itemName: itemName,
          itemText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemDescription),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(itemcapacity)
                ],
              )
            ],
          ),
          onChangedFn: (value) {
            widget.itemsList[index].isSelected = value!;
            widget.updateFilteredListFn();
            setState(() {});
          },
          imagePath: imagePath,
        );
      },
    );
  }
}
